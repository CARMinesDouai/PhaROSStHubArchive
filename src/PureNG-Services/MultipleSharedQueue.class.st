Class {
	#name : #MultipleSharedQueue,
	#superclass : #Object,
	#instVars : [
		'queues',
		'queuesMutex'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'as yet unclassified' }
MultipleSharedQueue >> for: aQueueOwner [
	| queue | 
	queuesMutex critical: [
		queue :=  queues at: aQueueOwner ifAbsentPut: [
			SharedQueue new.	
		].
	].
	^ queue.
]

{ #category : #'as yet unclassified' }
MultipleSharedQueue >> initialize [ 
	queues := Dictionary new.
	queuesMutex := Mutex new.
]

{ #category : #'as yet unclassified' }
MultipleSharedQueue >> nextPut: anObject [
	| allQueues | 
	queuesMutex critical: [
		allQueues := queues values.	
	].
	allQueues do: [ : aQueue | aQueue  nextPut: anObject ].
]
