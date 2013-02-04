Class {
	#name : #TKTWorker,
	#superclass : #Object,
	#instVars : [
		'keepRunning',
		'process',
		'workQueue',
		'onIdleTime',
		'currentTask'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'as yet unclassified' }
TKTWorker class >> pickOne [ 
	^ self new startUp ; yourself.
]

{ #category : #'as yet unclassified' }
TKTWorker >> do: aWork [
	^ workQueue add: aWork.
]

{ #category : #'as yet unclassified' }
TKTWorker >> forceRestart [
	process terminate.
	process := nil. 
	currentTask ifNotNil: [ 
		currentTask processFinished ifFalse: [
			currentTask  priority: 10.
			workQueue do: currentTask.
		].
	].

	self startUp.
]

{ #category : #'as yet unclassified' }
TKTWorker >> initialize [ 
	keepRunning := TKTVariable for: false.
	workQueue := TKTPriorityQueue new.
	onIdleTime := []. 
]

{ #category : #'as yet unclassified' }
TKTWorker >> isRunning [
	^ process isNil not and: [ process isTerminated not].
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
TKTWorker >> priorityPolicy [ 
	^ Processor userBackgroundPriority.
]

{ #category : #'as yet unclassified' }
TKTWorker >> processName [ 
	| pih | 
	pih := process hash \\ 999999.
	^ 'PureWorker-', pih asString. 
]

{ #category : #'as yet unclassified' }
TKTWorker >> run [

	currentTask := self next. 
	currentTask execute.
	currentTask := nil.
]

{ #category : #'as yet unclassified' }
TKTWorker >> startUp [
	process ifNil: [
		keepRunning set: true.
		process := [
			[ keepRunning get ] whileTrue: [ self run. ].
		] forkAt: self priorityPolicy named: self processName.
	].
]

{ #category : #'as yet unclassified' }
TKTWorker >> stop [
	self addWork: [
		keepRunning set: false.
	].
	(Delay forMilliseconds: 500) wait.
	process terminate.
	process := nil.
]

{ #category : #accessing }
TKTWorker >> waitTimeoutInSeconds: aSmallInteger [ 
	^ workQueue waitTimeoutInSeconds: aSmallInteger 
]
