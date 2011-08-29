Class {
	#name : #OCNUdpSocketForFinalizationTest,
	#superclass : #OCNUdpSocket,
	#instVars : [
		'semaphore',
		'testUnit'
	],
	#category : #'Ocean-KernelTests-Support'
}

{ #category : #finalization }
OCNUdpSocketForFinalizationTest >> finalize [
	super finalize.
	self testUnit lastSocketState: self state.
	self semaphore signal.
	
]

{ #category : #accessing }
OCNUdpSocketForFinalizationTest >> semaphore [
	^ semaphore
]

{ #category : #accessing }
OCNUdpSocketForFinalizationTest >> semaphore: anObject [
	semaphore := anObject
]

{ #category : #accessing }
OCNUdpSocketForFinalizationTest >> testUnit [
	^ testUnit
]

{ #category : #accessing }
OCNUdpSocketForFinalizationTest >> testUnit: t [
	testUnit := t
]
