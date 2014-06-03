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

{ #category : #'setUp-tearDown' }
OCNSocketFinalizationTest >> setUpSocketWithLibrary: aLibrary [
	socket := self socketClass basicNew.
	finalizationDoneSemaphore := Semaphore new.
	socket 
		networkLibrary: aLibrary;
		testUnit: self;
		semaphore: finalizationDoneSemaphore.
	socket initialize
]

{ #category : #testing }
OCNSocketFinalizationTest >> testCleanSocketFinalization [
	self assertSocket: socket state:  #isClean.
	self assertSocketFinalized
]

{ #category : #testing }
OCNSocketFinalizationTest >> testDestroyedSocketFinalization [
	self assertSocket: socket state:  #isClean. "Ensure socket NOT already destroyed"
	socket destroy.
	self assertSocket: socket state:  #isDestroyed.
	self assertSocketFinalized
]
