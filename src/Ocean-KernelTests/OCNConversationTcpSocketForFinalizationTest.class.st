Class {
	#name : #OCNConversationTcpSocketForFinalizationTest,
	#superclass : #OCNConversationTcpSocket,
	#instVars : [
		'testUnit'
	],
	#category : #'Ocean-KernelTests-Support'
}

{ #category : #finalization }
OCNConversationTcpSocketForFinalizationTest >> finalize [
self halt.
	super finalize.
	self testUnit lastSocketState: self state.

]

{ #category : #accessing }
OCNConversationTcpSocketForFinalizationTest >> testUnit [
	^ testUnit
]

{ #category : #accessing }
OCNConversationTcpSocketForFinalizationTest >> testUnit: anObject [
	testUnit := anObject
]
