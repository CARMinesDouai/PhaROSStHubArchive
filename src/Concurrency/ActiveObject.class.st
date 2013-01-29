Class {
	#name : #ActiveObject,
	#superclass : #Object,
	#instVars : [
		'process',
		'activityBlock',
		'activityLock',
		'priority'
	],
	#category : #Concurrency
}

{ #category : #'instance creation' }
ActiveObject class >> do: taskBlock [
	^self new
		activityBlock: taskBlock;
		yourself
]

{ #category : #'instance creation' }
ActiveObject class >> do: taskBlock ensure: stopBlock [ 
	^self do: [taskBlock ensure: stopBlock]
]

{ #category : #accessing }
ActiveObject >> activityBlock [
	^ activityBlock
]

{ #category : #accessing }
ActiveObject >> activityBlock: anObject [
	activityBlock := anObject
]

{ #category : #'initialize-release' }
ActiveObject >> defaultPriority [
	^Processor userBackgroundPriority 
]

{ #category : #finalization }
ActiveObject >> finalize [
	self stop
]

{ #category : #'initialize-release' }
ActiveObject >> initialize [ 
	super initialize.
	activityLock := Mutex new.
	self priority: self defaultPriority.

]

{ #category : #testing }
ActiveObject >> isStarted [ 
	^self isStopped not
]

{ #category : #testing }
ActiveObject >> isStopped [
	activityLock critical: [
		self process isNil ifTrue: [^true].
		^self process isTerminated]
]

{ #category : #accessing }
ActiveObject >> priority [
	^ priority
]

{ #category : #accessing }
ActiveObject >> priority: newPriority [
	priority := newPriority.
	self isStopped ifTrue: [^self].
	self process priority: priority
]

{ #category : #accessing }
ActiveObject >> process [
	^ process
]

{ #category : #accessing }
ActiveObject >> process: anObject [
	process := anObject
]

{ #category : #finalization }
ActiveObject >> registerForFinalization [
	self finalizationRegistry add: self
]

{ #category : #activity }
ActiveObject >> start [
	activityLock critical: [
		self isStarted
			ifTrue: [^self].
		self process: self activityBlock newProcess.
		self process priority: self priority.
		self registerForFinalization.
		self process	 resume]

]

{ #category : #activity }
ActiveObject >> stop [
	activityLock critical: [
		self process isNil ifTrue: [^true].
		process terminate]

]
