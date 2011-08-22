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
