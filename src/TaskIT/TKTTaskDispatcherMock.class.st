Class {
	#name : #TKTTaskDispatcherMock,
	#superclass : #Object,
	#instVars : [
		'destroyed',
		'tasks'
	],
	#category : #'TaskIT-Kernel-Tests'
}

{ #category : #initialize }
TKTTaskDispatcherMock >> destroy [
	destroyed := true.
]

{ #category : #accessing }
TKTTaskDispatcherMock >> destroyed [
	^ destroyed
]

{ #category : #accessing }
TKTTaskDispatcherMock >> dispatch: aTaskOrBlock [
	tasks add: aTaskOrBlock.
]

{ #category : #'initialize-release' }
TKTTaskDispatcherMock >> initialize [ 
	destroyed := false.
	tasks := OrderedCollection new.
]

{ #category : #accessing }
TKTTaskDispatcherMock >> tasks [ 
	^ tasks. 
]
