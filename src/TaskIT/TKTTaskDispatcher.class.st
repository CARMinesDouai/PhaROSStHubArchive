Class {
	#name : #TKTTaskDispatcher,
	#superclass : #Object,
	#instVars : [
		'workers',
		'eventualTasks'
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

{ #category : #initialize }
TKTTaskDispatcher >> destroy [
	workers do: #stop.
	workers removeAll.
]

{ #category : #accessing }
TKTTaskDispatcher >> dispatch: aTaskOrBlock [
	| task |
	
	task := aTaskOrBlock asTask.
	^ (self selectWorkerFor: task) scheduleTask: task.
]

{ #category : #'initialize-release' }
TKTTaskDispatcher >> initialize [ 
	super initialize.
	workers := Set new.
	workers 	add: (TKTWorker spawn timeout: 5000; yourself ); 
				add: ((TKTWorker with: Processor systemBackgroundPriority) timeout: 300; yourself ).

]

{ #category : #accessing }
TKTTaskDispatcher >> selectWorkerFor: aTask [
	
	^ (workers asSortedCollection: [:w1 :w2 | (w1 matching: aTask ) > (w2 matching: aTask )]) first.
]
