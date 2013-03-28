Class {
	#name : #MultipleSharedQueue,
	#superclass : #Object,
	#instVars : [
		'queues',
		'mutex'
	],
	#category : #'PureNG-Concurrency'
}

{ #category : #accessing }
MultipleSharedQueue >> findFirst: aBlock [
	^ (self for: thisContext sender receiver) findFirst: aBlock.
]

{ #category : #accessing }
MultipleSharedQueue >> flush [
	^ (self for: thisContext sender receiver) flush.
]

{ #category : #accessing }
MultipleSharedQueue >> flushAllSuchThat: aBlock [
	^ (self for: thisContext sender receiver) flushAllSuchThat: aBlock.
]

{ #category : #accessing }
MultipleSharedQueue >> for: aQueueOwner [
	| queue | 
	mutex critical: [
		queue :=  queues at: aQueueOwner ifAbsentPut: [
			SharedQueue new nextPutAll: (ReadStream on:(queues at: #history) contents); yourself.
		].
		
	].
	^ queue.
]

{ #category : #initializing }
MultipleSharedQueue >> initialize [ 
	queues := Dictionary new.
	queues at: #history put: (ReadWriteStream with: OrderedCollection new).
	mutex := Mutex new.
]

{ #category : #size }
MultipleSharedQueue >> isEmpty [
	^ (self for: thisContext sender receiver) isEmpty.
]

{ #category : #accessing }
MultipleSharedQueue >> next [
	^ (self for: thisContext sender receiver) next.
]

{ #category : #accessing }
MultipleSharedQueue >> nextOrNilSuchThat: aBlock [
	^ (self for: thisContext sender receiver) nextOrNilSuchThat: aBlock.
]

{ #category : #accessing }
MultipleSharedQueue >> nextPut: anObject [
	| allQueues | 
	mutex critical: [
		allQueues := queues values.
	].
	
	allQueues do: [ : aQueue | aQueue  nextPut: anObject ].
]

{ #category : #accessing }
MultipleSharedQueue >> peek [
	^ (self for: thisContext sender receiver) peek.
]

{ #category : #copying }
MultipleSharedQueue >> postCopy [
	^ (self for: thisContext sender receiver) postCopy .
]

{ #category : #printing }
MultipleSharedQueue >> printOn: aStream [
	mutex critical: [
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
	^ (self for: thisContext sender receiver) removeAll .
]

{ #category : #size }
MultipleSharedQueue >> size [
	^ (self for: thisContext sender receiver) size.
]
