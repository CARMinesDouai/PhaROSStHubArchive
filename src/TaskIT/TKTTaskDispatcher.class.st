Class {
	#name : #TKTTaskDispatcher,
	#superclass : #Object,
	#instVars : [
		'workers',
		'eventualTasks',
		'sharedQueue'
	],
	#classVars : [
		'TaskInstance'
	],
	#category : #'TaskIT-Tasks-Worker'
}

{ #category : #'as yet unclassified' }
TKTTaskDispatcher class >> instance [
	TaskInstance ifNil: [
		TaskInstance := super new.	
	].

	^ TaskInstance
]

{ #category : #'as yet unclassified' }
TKTTaskDispatcher class >> instance: aTaskInstance [
	self reset.
	TaskInstance := aTaskInstance.
]

{ #category : #'as yet unclassified' }
TKTTaskDispatcher class >> it: aTaskOrClosure [
	^ self instance dispatch: aTaskOrClosure.
	 
]

{ #category : #'as yet unclassified' }
TKTTaskDispatcher class >> new [
	self error: ' Use instance instead of new '.
]

{ #category : #'as yet unclassified' }
TKTTaskDispatcher class >> reset [
	TaskInstance ifNotNil: [
		TaskInstance destroy.
	 ].
	TaskInstance := nil.
]

{ #category : #'initialize-release' }
TKTTaskDispatcher >> addWorker [
	workers add: ((TKTWorker spawn:sharedQueue) timeout: 5000; yourself )
]

{ #category : #initialize }
TKTTaskDispatcher >> destroy [
	workers do: #stop.
	workers removeAll.
]

{ #category : #accessing }
TKTTaskDispatcher >> dispatch: aTaskOrBlock [
	
	sharedQueue add: aTaskOrBlock asTask.
	
]

{ #category : #'initialize-release' }
TKTTaskDispatcher >> initialize [ 
	super initialize.
	workers := Set new.
	sharedQueue := TKTPriorityQueue new. 
	self addWorker; addWorker. 

]

{ #category : #'initialize-release' }
TKTTaskDispatcher >> removeWorker [
	| selected finalizationQueue |
	selected := workers anyOne.
	finalizationQueue := TKTPriorityQueue new.
	finalizationQueue add: [ selected stop ].
	
	selected workingQueue: finalizationQueue. 
	workers remove: selected.
	
^ selected
]

{ #category : #'initialize-release' }
TKTTaskDispatcher >> workersAmount [
	^ workers size.
]
