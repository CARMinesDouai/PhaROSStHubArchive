Class {
	#name : #TKTTaskDispatcherMock,
	#superclass : #Object,
	#instVars : [
		'destroyed',
		'tasks'
	],
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #'as yet unclassified' }
TKTTaskDispatcherMock >> destroy [
	destroyed := true.
]

{ #category : #'as yet unclassified' }
TKTTaskDispatcherMock >> destroyed [
	^ destroyed
]

{ #category : #'as yet unclassified' }
TKTTaskDispatcherMock >> dispatch: aTaskOrBlock [
	tasks add: aTaskOrBlock.
]

{ #category : #'as yet unclassified' }
TKTTaskDispatcherMock >> initialize [ 
	destroyed := false.
	tasks := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
TKTTaskDispatcherMock >> tasks [ 
	^ tasks. 
]
