Class {
	#name : #ActiveObject,
	#superclass : #Object,
	#instVars : [
		'process',
		'activityBlock',
		'stopBlock',
		'priority'
	],
	#category : #Concurrency
}

{ #category : #'instance creation' }
ActiveObject class >> activityBlock: activityBlock stopBlock: stopBlock [ 
	^self new
		activityBlock: activityBlock;
		stopBlock: stopBlock;
		yourself
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
	self priority: self defaultPriority 
]

{ #category : #testing }
ActiveObject >> isStarted [ 
	^self process notNil
]

{ #category : #testing }
ActiveObject >> isStopped [
	self process isNil ifTrue: [^true].
	^self process isTerminated
]

{ #category : #accessing }
ActiveObject >> priority [
	^ priority
]

{ #category : #accessing }
ActiveObject >> priority: anObject [
	priority := anObject
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
	self isStarted
		ifTrue: [ ^ self ].
	self process: [self activityBlock ensure: self stopBlock] newProcess.
	self process
		priority: self priority;
		resume.
	self registerForFinalization
]

{ #category : #activity }
ActiveObject >> stop [
	self process isNil ifTrue: [^true].
	^process isTerminated
]

{ #category : #accessing }
ActiveObject >> stopBlock [
	^ stopBlock
]

{ #category : #accessing }
ActiveObject >> stopBlock: anObject [
	stopBlock := anObject
]
