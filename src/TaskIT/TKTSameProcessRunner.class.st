"
The same process runner is a simple runner that executes a task in the caller process. This runner may come in handy to perform change the way a task runs in a transparent way to the task, since it is polymorphic with the other task runners. A same process runner is reusable, since it holds no state.

[[[
runner := TKTSameProcessRunner new.
future := runner run: [ (Delay forMilliseconds: 30000) wait ] asTask.
]]]

Additionally, sending the ==value== message to a task is a shortcut to execute it with a same process runner.
"
Class {
	#name : #TKTSameProcessRunner,
	#superclass : #TKTRunner,
	#category : #'TaskIT-Kernel'
}

{ #category : #testing }
TKTSameProcessRunner >> isTerminated [

	^ true
]

{ #category : #running }
TKTSameProcessRunner >> run: aJob [

	aJob asTKTJob asTask runOnRunner: self withFuture: nil.
]
