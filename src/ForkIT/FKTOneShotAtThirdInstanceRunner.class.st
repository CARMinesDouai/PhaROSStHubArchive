"
A one shot runner, instance of TKTOneShotAtThirdInstanceRunner, is a task runner that is meant to run a single task in a separate Pharo INSTANCE. The one shot runner will start a new image with a vm (by default the last saved snapshot of this image and the same VM that is used to run this image) process when the task is run, and so, handle the process' life cycle. A one shot runner, as it name says, is meant to be used once and be discarded. It should not be reused with several tasks.

The usage of a one shot runner is simple. We should create a new instance of it and send it the message ==run:== with the task to run as a parameter. The result of that message will be a future object.

[[[
runner := TKTOneShotAtThirdInstanceRunner new.
future := runner run: [ (Delay forMilliseconds: 30000) wait ] asTask.
]]]


There are some disclaimers for this runner. 
	1- You should just be interested in the result of the process because it will execute in a different image, so, any side effect triggered by this process will be lost. 
	2- A local pharo process will be installed in a pseudo-active wait for the result. By default it ask for result 1 time per second. 
	3- Also, in order to achieve this we serialize with FUEL the block, what means that it takes time.


This kind of runner is good for a lot of processing time, not much objects implied, and oriented to result. 
An example for this can be run tests. You can run the tests of an image in a copy, keep working, and receive the result when is done.

Also start a server for static content.

Since the usage of one shot runners is pretty common and straight forward, the ==forkIt== method of a task is a shortcut to it.
"
Class {
	#name : #FKTOneShotAtThirdInstanceRunner,
	#superclass : #TKTOneShotRunner,
	#category : #ForkIT
}

{ #category : #'as yet unclassified' }
FKTOneShotAtThirdInstanceRunner >> run: aJob [

	| task outputPath inputPath  |

	task := aJob  asTask.
	"self assert: (task isClean) description: 'The task to execute in a third image cannot point any contextual value '."
	
	process := FKTInstanceProcess simpleInstance.

	outputPath := '{1}-output.fl' format: {self hash asString}.
	inputPath := '{1}-input.fl' format: {self hash asString}.
	

	FLSerializer serialize: task toFileNamed: inputPath .	

	
	process executable: [
		|  remoteTask localFuture |		
		[	
			remoteTask := FLMaterializer  materializeFromFileNamed: inputPath.
			localFuture :=  remoteTask shootIt .
			localFuture wait.
			FLSerializer serialize: localFuture toFileNamed:  outputPath.
		] ensure: [
			inputPath asFileReference deleteIfAbsent:[].
		]
	].

	
	process name: 'A TKTTask'.
	process priority: task priority.
	process execute.
	
	future:= [ 
		| remoteFuture |
		self waitUntilProcessIsComplete.		
		[
			[
				remoteFuture := (FLMaterializer materializeFromFileNamed: outputPath).
			] on: Error do: [
				self error: 'Error decoding answer from remote image!'.
			]
		] ensure: [ outputPath asFileReference deleteIfAbsent:[] ].
	
		remoteFuture value.
	] shootIt.

	future onCancel: [ 
		process terminate.
		outputPath asFileReference deleteIfAbsent:[].
		inputPath asFileReference deleteIfAbsent:[].
	 ]. 


	^ future.
]

{ #category : #'as yet unclassified' }
FKTOneShotAtThirdInstanceRunner >> waitUntilProcessIsComplete [
	
	[ process isTerminated ] whileFalse: [ 1 second asDelay wait ].
]
