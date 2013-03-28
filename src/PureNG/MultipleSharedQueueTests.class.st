Class {
	#name : #MultipleSharedQueueTests,
	#superclass : #TestCase,
	#instVars : [
		'queue'
	],
	#category : #'PureNG-Concurrency'
}

{ #category : #'as yet unclassified' }
MultipleSharedQueueTests >> setUp [ 
	queue := MultipleSharedQueue new.
]

{ #category : #'as yet unclassified' }
MultipleSharedQueueTests >> testAllNewCallersHaveTheMaximumSizeAsFirst [
	| consumer |

	consumer := MultiSharedQueueConsumer with: queue. 
		 
	queue nextPut: Object.
	queue nextPut: Object.

	self assert: consumer queueSize = 2.	
	self assert: queue size = 2.
	
	self assert: queue next = Object.
	
	self assert: consumer queueSize = 2.
	
	self assert: queue size = 1.
	self assert: queue next = Object.
	
	self assert: consumer queueSize = 2.
	self assert: queue size = 0.
	
	queue nextPut: self.
	
	self assert: consumer queueSize = 3.
	self assert: queue size = 1.
	
	self assert: consumer queueNext  = Object.
	self assert: consumer queueNext = Object.
	self assert: consumer queueNext = self.
	
	self assert: consumer queueSize = 0.
	self assert: queue size = 1.
	




]

{ #category : #'as yet unclassified' }
MultipleSharedQueueTests >> testPutGetSameObject [
	queue nextPut: Object.
	self assert: queue next = Object.
]

{ #category : #'as yet unclassified' }
MultipleSharedQueueTests >> testSizeDecrease [
	queue nextPut: Object.
	queue nextPut: Object.

	self assert: queue size = 2.
	self assert: queue next = Object.
	self assert: queue size = 1.
	self assert: queue next = Object.
	self assert: queue size = 0.
	
	
]
