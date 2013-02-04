Class {
	#name : #Task,
	#superclass : #Object,
	#instVars : [
		'workers'
	],
	#classInstVars : [
		'TaskInstance'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'as yet unclassified' }
Task class >> instance [
	TaskInstance ifNil: [
		TaskInstance := super new.	
	].

	^ TaskInstance
]

{ #category : #'as yet unclassified' }
Task class >> it: aTaskOrClosure [
	^ self instance dispatch: aTaskOrClosure.
	 
]

{ #category : #'as yet unclassified' }
Task class >> new [
	self error: ' Use instance instead of new '.
]

{ #category : #'as yet unclassified' }
Task >> dispatch: aTaskOrBlock [
	| task |
	
	task := aTaskOrBlock asTask.
	(self selectWorkerFor: task) do: task.
	
	^ task future.
]

{ #category : #'as yet unclassified' }
Task >> initialize [ 
	super initialize.
	workers := Set new. 
	workers add: TKTWorker pickOne.

]

{ #category : #'as yet unclassified' }
Task >> selectWorkerFor: aTask [
	^ workers anyOne.
]
