Class {
	#name : #MultiSharedQueueConsumer,
	#superclass : #Object,
	#instVars : [
		'queue'
	],
	#category : #'PureNG-Concurrency'
}

{ #category : #'as yet unclassified' }
MultiSharedQueueConsumer class >> with: aQueue [
	^ self new queue: aQueue ; yourself.
]

{ #category : #'as yet unclassified' }
MultiSharedQueueConsumer >> queue: aQueue [
	queue := aQueue 
]

{ #category : #'as yet unclassified' }
MultiSharedQueueConsumer >> queueNext [ 
	^ queue next.
]

{ #category : #'as yet unclassified' }
MultiSharedQueueConsumer >> queueSize [
	^ queue size.
]
