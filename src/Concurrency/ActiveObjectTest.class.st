Class {
	#name : #ActiveObjectTest,
	#superclass : #TestCase,
	#instVars : [
		'activeObject'
	],
	#category : #Concurrency
}

{ #category : #testing }
ActiveObjectTest >> activeObjProcess [
	activeObject ifNil: [ ^nil ].
	^activeObject instVarNamed: #process
]

{ #category : #testing }
ActiveObjectTest >> assertSemaphore: semaphore signaledWithinMilliseconds: milliseconds [
	self deny: (semaphore waitTimeoutMSecs: milliseconds)
]

{ #category : #testing }
ActiveObjectTest >> assertSemaphore: semaphore signaledWithinSeconds: seconds [
	self deny: (semaphore waitTimeoutSeconds: seconds)
]

{ #category : #testing }
ActiveObjectTest >> denySemaphore: semaphore signaledWithinMilliseconds: milliseconds [
	self assert: (semaphore waitTimeoutMSecs: milliseconds)
]

{ #category : #testing }
ActiveObjectTest >> denySemaphore: semaphore signaledWithinSeconds: seconds [
	self assert: (semaphore waitTimeoutSeconds: seconds)
]

{ #category : #testing }
ActiveObjectTest >> tearDown [
	super tearDown.
	self activeObjProcess ifNotNilDo: [:process | process terminate]
]
