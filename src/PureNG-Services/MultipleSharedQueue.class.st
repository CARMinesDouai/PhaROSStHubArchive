Class {
	#name : #MultipleSharedQueue,
	#superclass : #Object,
	#instVars : [
		'queues',
		'queuesMutex'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #accessing }
MultipleSharedQueue >> findFirst: aBlock [
	^ (self for: thisContext sender) findFirst: aBlock.
]

{ #category : #accessing }
MultipleSharedQueue >> flush [
	^ (self for: thisContext sender) flush.
]

{ #category : #accessing }
MultipleSharedQueue >> flushAllSuchThat: aBlock [
	^ (self for: thisContext sender) flushAllSuchThat: aBlock.
]

{ #category : #accessing }
MultipleSharedQueue >> for: aQueueOwner [
	| queue | 
	queuesMutex critical: [
		queue :=  queues at: aQueueOwner ifAbsentPut: [
			SharedQueue new.	
		].
	].
	^ queue.
]

{ #category : #initializing }
MultipleSharedQueue >> initialize [ 
	queues := Dictionary new.
	queuesMutex := Mutex new.
]

{ #category : #size }
MultipleSharedQueue >> isEmpty [
	^ (self for: thisContext sender) isEmpty.
]

{ #category : #accessing }
MultipleSharedQueue >> next [
	^ (self for: thisContext sender) next.
]

{ #category : #accessing }
MultipleSharedQueue >> nextOrNilSuchThat: aBlock [
	^ (self for: thisContext sender) nextOrNilSuchThat: aBlock.
]

{ #category : #accessing }
MultipleSharedQueue >> nextPut: anObject [
	| allQueues | 
	queuesMutex critical: [
		allQueues := queues values.	
	].
	allQueues do: [ : aQueue | aQueue  nextPut: anObject ].
]

{ #category : #accessing }
MultipleSharedQueue >> peek [
	^ (self for: thisContext sender) peek.
]

{ #category : #copying }
MultipleSharedQueue >> postCopy [
	^ (self for: thisContext sender) postCopy .
]

{ #category : #printing }
MultipleSharedQueue >> printOn: aStream [
	queuesMutex critical: [
		queues keysAndValuesDo: [ : owner : queue | 
			aStream nextPutAll: '[', owner asString, ']'.
			queue printOn: aStream.
			aStream nextPutAll: String cr.
			aStream nextPutAll: '----------------------------'.
			aStream nextPutAll: String cr.
		]
	]
]

{ #category : #accessing }
MultipleSharedQueue >> removeAll [ 
	^ (self for: thisContext sender) removeAll .
]

{ #category : #size }
MultipleSharedQueue >> size [
	^ (self for: thisContext sender) size.
]
