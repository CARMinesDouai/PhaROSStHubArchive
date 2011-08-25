Class {
	#name : #OCNConversationTcpSocketForFinalizationTest,
	#superclass : #OCNConversationTcpSocket,
	#instVars : [
		'semaphore',
		'testUnit'
	],
	#category : #'Ocean-KernelTests-Support'
}

{ #category : #finalization }
OCNConversationTcpSocketForFinalizationTest >> finalize [
	super finalize.
	self testUnit lastSocketState: self state.
	self semaphore signal.
	
]

{ #category : #accessing }
OCNConversationTcpSocketForFinalizationTest >> semaphore [
	^ semaphore
]

{ #category : #accessing }
OCNConversationTcpSocketForFinalizationTest >> semaphore: anObject [
	semaphore := anObject
]

{ #category : #accessing }
OCNConversationTcpSocketForFinalizationTest >> testUnit [
	^ testUnit
]

{ #category : #accessing }
OCNConversationTcpSocketForFinalizationTest >> testUnit: t [
	testUnit := t
]
