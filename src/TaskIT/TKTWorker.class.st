Class {
	#name : #TKTWorker,
	#superclass : #TKTTask,
	#instVars : [
		'keepRunning',
		'workQueue',
		'onIdleTime',
		'currentTask',
		'beginning',
		'future'
	],
	#category : #'TaskIT-Worker'
}

{ #category : #'as yet unclassified' }
TKTWorker class >> new [
	^ self with: Processor userBackgroundPriority.
]

{ #category : #'as yet unclassified' }
TKTWorker class >> with: aPriority [
	^ super new priority:aPriority ; doIt ; yourself.
]

{ #category : #accessing }
TKTWorker >> busy [
	^ workQueue size.
]

{ #category : #'as yet unclassified' }
TKTWorker >> doIt [
	(future isNil or: [ future valueAvailable]) ifTrue: [
		future := super doIt.	
		future whenFinished: [: t | t inspect. ].
	].
	
]

{ #category : #'as yet unclassified' }
TKTWorker >> initialize [ 
	super initialize.
	keepRunning := TKTVariable for: false.
	workQueue := TKTPriorityQueue new.
	future := nil.
	onIdleTime := []. 
	block := self mainTask.
]

{ #category : #'as yet unclassified' }
TKTWorker >> isRunning [
	^ future valueAvailable not.
]

{ #category : #'as yet unclassified' }
TKTWorker >> mainTask [
	^ [
		keepRunning set: true.
		[ keepRunning get ] whileTrue: [ 
			self run. 
		]
	].
	
]

{ #category : #'as yet unclassified' }
TKTWorker >> next [
	^ workQueue nextIfTimeOut: onIdleTime
]

{ #category : #'as yet unclassified' }
TKTWorker >> onIdleTime: aBlockOrWork [
	onIdleTime:= aBlockOrWork asWork.
]

{ #category : #'as yet unclassified' }
TKTWorker >> restart [

	future stop.

	currentTask ifNotNil: [ 
		currentTask processFinished ifFalse: [
			currentTask  priority: 10.
			workQueue do: currentTask.
		].
	].

	self doIt.
]

{ #category : #'as yet unclassified' }
TKTWorker >> run [
	| task future | 
	(currentTask := self next ) ifNotNil: [ 
		task := currentTask key.
		future := currentTask value.
		
		beginning := DateAndTime now. 
		task value: future.
		currentTask := nil.
	]
]

{ #category : #'as yet unclassified' }
TKTWorker >> scheddule: aTaskOrBlockClosure [
	^ workQueue add: aTaskOrBlockClosure.
]

{ #category : #'as yet unclassified' }
TKTWorker >> stop [
	self scheddule: [
		keepRunning set: false.
	] asTask -> TKTFuture new.
	(Delay forMilliseconds: 500) wait.

	future valueAvailable ifFalse: [
		future cancel.		
	].
	
]

{ #category : #accessing }
TKTWorker >> timeout: aSmallInteger [ 
	^ workQueue timeout: aSmallInteger 
]
