Class {
	#name : #PITWorkersPoolMock,
	#superclass : #Object,
	#instVars : [
		'destroyed',
		'tasks'
	],
	#category : #'PoolIT-Tests'
}

{ #category : #initialize }
PITWorkersPoolMock >> destroy [
	destroyed := true.
]

{ #category : #accessing }
PITWorkersPoolMock >> destroyed [
	^ destroyed
]

{ #category : #accessing }
PITWorkersPoolMock >> dispatch: aTaskOrBlock [
	tasks add: aTaskOrBlock.
]

{ #category : #'initialize-release' }
PITWorkersPoolMock >> initialize [ 
	destroyed := false.
	tasks := OrderedCollection new.
]

{ #category : #accessing }
PITWorkersPoolMock >> tasks [ 
	^ tasks. 
]
