Class {
	#name : #PITWorkersPool,
	#superclass : #Object,
	#instVars : [
		'workers',
		'eventualTasks',
		'sharedQueue'
	],
	#classVars : [
		'TaskInstance'
	],
	#category : #PoolIT
}

{ #category : #'as yet unclassified' }
PITWorkersPool class >> instance [
	TaskInstance ifNil: [
		TaskInstance := super new.	
	].

	^ TaskInstance
]

{ #category : #'as yet unclassified' }
PITWorkersPool class >> instance: aTaskInstance [
	self reset.
	TaskInstance := aTaskInstance.
]

{ #category : #'as yet unclassified' }
PITWorkersPool class >> it: aTaskOrClosure [
	^ self instance dispatch: aTaskOrClosure.
	 
]

{ #category : #'as yet unclassified' }
PITWorkersPool class >> new [
	self error: ' Use instance instead of new '.
]

{ #category : #'as yet unclassified' }
PITWorkersPool class >> reset [
	TaskInstance ifNotNil: [
		TaskInstance destroy.
	 ].
	TaskInstance := nil.
]

{ #category : #'initialize-release' }
PITWorkersPool >> addWorker [
	workers add: ((TKTWorker spawn:sharedQueue) timeout: 5000; yourself )
]

{ #category : #initialize }
PITWorkersPool >> destroy [
	workers do: #stop.
	workers removeAll.
]

{ #category : #accessing }
PITWorkersPool >> dispatch: aTaskOrBlock [
	
	sharedQueue add: aTaskOrBlock asTask.
	
]

{ #category : #'initialize-release' }
PITWorkersPool >> initialize [ 
	super initialize.
	workers := Set new.
	sharedQueue := TKTPriorityQueue new. 
	self addWorker; addWorker. 

]

{ #category : #'initialize-release' }
PITWorkersPool >> removeWorker [
	| selected finalizationQueue |
	selected := workers anyOne.
	finalizationQueue := TKTPriorityQueue new.
	finalizationQueue add: [ selected stop ].
	
	selected workingQueue: finalizationQueue. 
	workers remove: selected.
	
^ selected
]

{ #category : #'initialize-release' }
PITWorkersPool >> workersAmount [
	^ workers size.
]
