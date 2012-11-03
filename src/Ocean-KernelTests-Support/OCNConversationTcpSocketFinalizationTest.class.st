Class {
	#name : #OCNConversationTcpSocketFinalizationTest,
	#superclass : #OCNSocketFinalizationTest,
	#category : #'Ocean-KernelTests'
}

{ #category : #'as yet unclassified' }
OCNConversationTcpSocketFinalizationTest class >> shouldBeSubclassedForBackendTesting [
	^true
]

{ #category : #accessing }
OCNConversationTcpSocketFinalizationTest >> socketClass [
	^OCNConversationTcpSocketForFinalizationTest
]

{ #category : #accessing }
OCNConversationTcpSocketFinalizationTest >> stateTestingSelectors [ 
	^#(isClean isBound isConnected isDestroyed)
]
