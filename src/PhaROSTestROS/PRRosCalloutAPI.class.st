"
I am a simple API that uses the ROS command line utilities to interact with ROS. I am intended as a lightweight bridge to ROS.

I am stateless, see my class side for my provided functionality. 
"
Class {
	#name : #PRRosCalloutAPI,
	#superclass : #Object,
	#category : #'PhaROSTestROS-SimpleAPI'
}

{ #category : #services }
PRRosCalloutAPI class >> call: aService [ 
	
	OSProcess waitForCommand: 'rosservice call ', aService. 
]

{ #category : #services }
PRRosCalloutAPI class >> call: aService withArgs: someArguments [
	
	OSProcess waitForCommand: 'rosservice call ', aService , '  ', someArguments. 
]

{ #category : #'publish-subscribe' }
PRRosCalloutAPI class >> peek: aTopic [
	| command process result id |
	"Slow and not very reliable because it just waits some time,
	instead of waiting until it sees the message separators '---' "
	
	"Unique id for today"
	id := 'PRRosCalloutAPIPeek', Time now asNanoSeconds asString.

	command := String streamContents: [ :str |
		str	nextPutAll: 'rostopic echo ';
			nextPutAll: aTopic;
			nextPutAll: ' __name:=';
			nextPutAll: id].
	
	[	process := (PipeableOSProcess  command: command).
		800 milliSeconds wait.
		result :=  (process upToEnd readStream upToAll: '---').
	]
		ensure: [ OSProcess command: 'rosnode kill /',id].
	^result.

]

{ #category : #'publish-subscribe' }
PRRosCalloutAPI class >> publish: aMessage ofType: aType on: aTopic [
	| command |
	
	command := String streamContents: [ :str |
		str	nextPutAll: 'rostopic pub -1 ';
			nextPutAll: aTopic;
			nextPutAll: ' ';
			nextPutAll: aType;
			nextPutAll: ' ';
			nextPutAll: aMessage.
		 ].
	
	OSProcess waitForCommand: command.
]

{ #category : #'publish-subscribe' }
PRRosCalloutAPI class >> subscribeTo: aTopic [
	"Returns an association with 
		key: { ID of the echo node . forked thread }
		value: the last message read.
	 Don't forget to terminate the subscription! Call unsubscribe: with as argument retval."
	| retval key thread command |
	
	retval := Association new.
	"A simple attempt at a unique key"
	key := 'PRRosCalloutAPISub', Time now asNanoSeconds asString, 100000 atRandom asString.

	command := String streamContents: [ :str |
		str	nextPutAll: 'rostopic echo ';
			nextPutAll: aTopic;
			nextPutAll: ' __name:=';
			nextPutAll: key].
	
	thread := [| process |
		process := (PipeableOSProcess command: command).
		[true] whileTrue: [ | output char complete |
			output := WriteStream on: (String new: 10).
			complete := false.
			[complete] whileFalse: [ 
				"read while not hogging the CPU"
				[(char := process next) isNil] whileTrue: [Processor yield].
				output nextPut: char.
				"slightly clever testing for end of message"
				((char = $-) and: [output contents endsWith: '---']) ifTrue: [|contents|
					contents := output contents.
					retval value: (contents copyFrom: 1 to: contents size - 3).
					complete := true.
					"swallow the newline"
					[process next isNil] whileTrue: [Processor yield]].
				]]] fork.
	retval key: { key . thread }.

	^ retval.
]

{ #category : #'publish-subscribe' }
PRRosCalloutAPI class >> unsubscribe: aSubscriptionAssoc [
	"Pass me the result of the subscribeTo: call"
	OSProcess command: 'rosnode kill /', (aSubscriptionAssoc key first).
	aSubscriptionAssoc key second terminate.
]
