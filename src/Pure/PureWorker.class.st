Class {
	#name : #PureWorker,
	#superclass : #Object,
	#instVars : [
		'keepRunning',
		'process',
		'processMutex',
		'workQueue',
		'onIdleTime',
		'something',
		'task'
	],
	#category : #'Pure-Kernel'
}

{ #category : #'as yet unclassified' }
PureWorker class >> pickOne [ 
	^ self new startUp ; yourself.
]

{ #category : #'as yet unclassified' }
PureWorker >> addWork: aWork [
	^ workQueue add: aWork.
]

{ #category : #'as yet unclassified' }
PureWorker >> forceRestart [
	process terminate.
	process := nil. 
	task ifNotNil: [ 
		task processFinished ifFalse: [
			task priority: 10.
			workQueue addWork: task.
		].
	].

	self startUp.
]

{ #category : #'as yet unclassified' }
PureWorker >> initialize [ 
	processMutex := Mutex new.
	workQueue := PureWorkPriorityQueue new.
	onIdleTime := []. 
]

{ #category : #'as yet unclassified' }
PureWorker >> isRunning [
	^ process isNil not and: [ process isTerminated not].
]

{ #category : #'as yet unclassified' }
PureWorker >> keepRunning [ 
	| val |
	processMutex  critical: [
		val := keepRunning.
	].
	^val. 
]

{ #category : #'as yet unclassified' }
PureWorker >> keepRunning: aBoolean [
	processMutex  critical: [
		keepRunning := aBoolean.
		
	].
]

{ #category : #'as yet unclassified' }
PureWorker >> next [
	^ workQueue nextIfTimeOut: onIdleTime
]

{ #category : #'as yet unclassified' }
PureWorker >> onIdleTime: aBlockOrWork [
	onIdleTime:= aBlockOrWork asWork.
]

{ #category : #'as yet unclassified' }
PureWorker >> priorityPolicy [ 
	^ Processor userBackgroundPriority.
]

{ #category : #'as yet unclassified' }
PureWorker >> processName [ 
	| pih | 
	pih := process hash \\ 999999.
	^ 'PureWorker-', pih asString. 
]

{ #category : #'as yet unclassified' }
PureWorker >> run [


	(task := self next ) ifNil:[ ^ self ]. 
	[
		task execute: self.	
	]	on: Error do: [ : e |
		task := nil.	
		self forceRestart.	
	].

]

{ #category : #'as yet unclassified' }
PureWorker >> startUp [
	process ifNil: [
		self keepRunning: true.
		process := [
			[ self keepRunning ] whileTrue: [ self run. ].
		] forkAt: self priorityPolicy named: self processName.
	].
]

{ #category : #'as yet unclassified' }
PureWorker >> stop [
	self addWork: [
		self keepRunning: false.
	].
	(Delay forMilliseconds: 500) wait.
	process terminate.
	process := nil.
]

{ #category : #accessing }
PureWorker >> waitTimeoutInSeconds: aSmallInteger [ 
	^ workQueue waitTimeoutInSeconds: aSmallInteger 
]
