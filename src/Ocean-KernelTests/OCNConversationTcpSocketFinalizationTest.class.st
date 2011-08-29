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

{ #category : #accessing }
OCNConversationTcpSocketFinalizationTest >> testCreateSocketWithAnId [
	self signalFailure: 'We need to create socket with an already known Id'
]
