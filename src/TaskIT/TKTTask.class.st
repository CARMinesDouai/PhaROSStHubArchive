Class {
	#name : #TKTTask,
	#superclass : #Object,
	#instVars : [
		'block',
		'priority',
		'errorCallbacks',
		'successCallbacks',
		'cancelCallbacks',
		'job',
		'result'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'instance creation' }
TKTTask class >> for: aBlock [
	^ self new
		block: aBlock;
		yourself
]

{ #category : #'instance creation' }
TKTTask class >> for: aBlock at: aPriority [

	^ (self for: aBlock)
		priority: aPriority;
		yourself
]

{ #category : #'instance-creation' }
TKTTask class >> withJob: aTKTJob [ 
	
	^ self new
		job: aTKTJob;
		yourself
]

{ #category : #sorting }
TKTTask >> < aTKTTask [ 
	^ priority < aTKTTask priority.
]

{ #category : #sorting }
TKTTask >> > aTKTTask [ 
	^ priority > aTKTTask priority.
]

{ #category : #'as yet unclassified' }
TKTTask >> asTask [

	^ self
]

{ #category : #accessing }
TKTTask >> block: aBlock [
	block := aBlock.
]

{ #category : #executing }
TKTTask >> cleanup [
]

{ #category : #running }
TKTTask >> executeWithFuture: aFuture [

	^ job executeInTask: self
]

{ #category : #accessing }
TKTTask >> finalize [
	self halt.
]

{ #category : #'initialize-release' }
TKTTask >> initialize [ 

	super initialize.
	priority := Processor userBackgroundPriority.
	successCallbacks := TKTExclusiveAccessVariable initialValue: OrderedCollection new.
	errorCallbacks := TKTExclusiveAccessVariable initialValue: OrderedCollection new.
	cancelCallbacks := TKTExclusiveAccessVariable initialValue: OrderedCollection new.

]

{ #category : #testing }
TKTTask >> isCancelled [
	
	^ self result isCancelled
]

{ #category : #testing }
TKTTask >> isClean [
	^ block isClean.
]

{ #category : #testing }
TKTTask >> isError [
	
	^ self result isError
]

{ #category : #accesing }
TKTTask >> job: aTKTJob [ 
	
	job := aTKTJob
]

{ #category : #callbacks }
TKTTask >> onCancel: aCallback [ 

	cancelCallbacks add: aCallback
]

{ #category : #callbacks }
TKTTask >> onError: aCallback [ 

	errorCallbacks add: aCallback
]

{ #category : #callbacks }
TKTTask >> onSuccess: aCallback [ 

	successCallbacks add: aCallback
]

{ #category : #accessing }
TKTTask >> priority [
	^ priority .
]

{ #category : #accessing }
TKTTask >> priority: aPriority [
	priority := aPriority.
]

{ #category : #accessing }
TKTTask >> result [
	
	^ result
]

{ #category : #acccessing }
TKTTask >> result: aResult [

	result := aResult
]

{ #category : #running }
TKTTask >> runOnRunner: aRunner withFuture: aFuture [

	| value |
	self setUpOnRunner: aRunner withFuture: aFuture.
	[
		[
			value := self executeWithFuture: aFuture. 
		] on: Error do: [ : exception |
			exception freeze.
			errorCallbacks get do: [ : c  | c cull: exception ].
			^ aRunner deployError: exception intoFuture: aFuture.
		].
		successCallbacks get do: [ : c  | c cull: value ].
		aRunner deployValue: value intoFuture: aFuture.
	] ensure: [
		self tearDownOnRunner: aRunner withFuture: aFuture.
	].
]

{ #category : #executing }
TKTTask >> setUpOnRunner: aRunner withFuture: aFuture [
]

{ #category : #executing }
TKTTask >> shootIt [
	
	^ TKTOneShotRunner new run: self
]

{ #category : #executing }
TKTTask >> tearDownOnRunner: aRunner withFuture: aFuture [
	
]

{ #category : #executing }
TKTTask >> value [
	" The future is dispendable in this case, cause is executing in the same thread "
	^ TKTSameProcessRunner new run: self
]

{ #category : #executing }
TKTTask >> value: aFuture [ 
	
	self error.
]
