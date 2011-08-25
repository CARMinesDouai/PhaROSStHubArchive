Class {
	#name : #OCNConversationTcpSocketFinalizationTest,
	#superclass : #OCNTcpSocketFinalizationTest,
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
