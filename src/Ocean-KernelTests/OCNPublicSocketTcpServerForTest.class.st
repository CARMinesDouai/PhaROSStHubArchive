Class {
	#name : #OCNPublicSocketTcpServerForTest,
	#superclass : #OCNTcpServerForTest,
	#instVars : [
		'conversationSocket'
	],
	#category : #'Ocean-KernelTests-Support'
}

{ #category : #accessing }
OCNPublicSocketTcpServerForTest >> conversationSocket [
	^ conversationSocket
]

{ #category : #accessing }
OCNPublicSocketTcpServerForTest >> conversationSocket: anObject [
	conversationSocket := anObject
]

{ #category : #running }
OCNPublicSocketTcpServerForTest >> interactThenClose: aSocketStream [
	self conversationSocket: aSocketStream socket
]
