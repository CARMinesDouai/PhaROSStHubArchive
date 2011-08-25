Class {
	#name : #OCNSocketFinalizationTest,
	#superclass : #OCNSocketTest,
	#instVars : [
		'lastSocketState',
		'finalizationDoneSemaphore'
	],
	#category : #'Ocean-KernelTests'
}

{ #category : #'as yet unclassified' }
OCNSocketFinalizationTest class >> lookupHierarchyRoot [
	^OCNSocketFinalizationTest 
]

{ #category : #testing }
OCNSocketFinalizationTest >> assertSocketFinalized [
	socket := nil.
	Smalltalk garbageCollect.
	self deny: (finalizationDoneSemaphore waitTimeoutMSecs:  100).
	self assert: self lastSocketState == #destroyed
]

{ #category : #testing }
OCNSocketFinalizationTest >> lastSocketState [
	^ lastSocketState
]

{ #category : #testing }
OCNSocketFinalizationTest >> lastSocketState: anObject [
	lastSocketState := anObject
]

{ #category : #testing }
OCNSocketFinalizationTest >> setUp [
	super setUp.
	finalizationDoneSemaphore := Semaphore new.
	socket 
		testUnit: self;
		semaphore: finalizationDoneSemaphore.
	WeakRegistry default add: socket.

]

{ #category : #testing }
OCNSocketFinalizationTest >> testCleanSocketFinalization [
	self assertSocket: socket state:  #isClean.
	self assertSocketFinalized
]
