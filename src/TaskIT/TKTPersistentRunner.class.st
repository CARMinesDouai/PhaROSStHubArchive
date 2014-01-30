Class {
	#name : #TKTPersistentRunner,
	#superclass : #TKTOwnProcessRunner,
	#instVars : [
		'keepRunning',
		'priority',
		'failureBlock'
	],
	#category : #'TaskIT-PersistentRunners'
}

{ #category : #testing }
TKTPersistentRunner class >> isAbstract [
	^ self = TKTOwnProcessRunner
]

{ #category : #running }
TKTPersistentRunner >> afterRunTask: currentTask [

	"Hook for subclasses"
]

{ #category : #running }
TKTPersistentRunner >> beforeRunTask: currentTask [

	"Hook for subclasses"
]

{ #category : #running }
TKTPersistentRunner >> executeNextTask [

	[
	| currentTask |
	currentTask := self nextTask.
	self beforeRunTask: currentTask.
	currentTask runOnRunner: self withFuture: (self futureForTask: currentTask).
	self afterRunTask: currentTask.
	] on: Error do: failureBlock.
]

{ #category : #accessing }
TKTPersistentRunner >> failureBlock: anObject [
	
	failureBlock := anObject
]

{ #category : #private }
TKTPersistentRunner >> futureForTask: currentTask [

	self subclassResponsibility
]

{ #category : #'initialize-release' }
TKTPersistentRunner >> initialize [ 

	super initialize.
	self priority: Processor userBackgroundPriority.
	keepRunning := TKTExclusiveAccessVariable initialValue: true.
	failureBlock := [ :e | e pass ].
]

{ #category : #running }
TKTPersistentRunner >> nextTask [

	self subclassResponsibility
]

{ #category : #accessing }
TKTPersistentRunner >> priority [
	^ priority
]

{ #category : #accessing }
TKTPersistentRunner >> priority: anObject [
	priority := anObject
]

{ #category : #running }
TKTPersistentRunner >> run [

	keepRunning set: true.
	[ self shouldKeepRunning ] whileTrue: [ 
		self executeNextTask.
	]
]

{ #category : #running }
TKTPersistentRunner >> shouldKeepRunning [

	^ keepRunning get
]

{ #category : #running }
TKTPersistentRunner >> start [

	process := [ self run ] newProcess.
	process priority: self priority.
	process name: self processName.
	process resume.
]

{ #category : #running }
TKTPersistentRunner >> stop [
	self scheduleTask: [ keepRunning set: false ] asTask.
	(Delay forMilliseconds: 500) wait.
	self cancel.
]
