Class {
	#name : #OCNTcpSocketFinalizationTest,
	#superclass : #TestCase,
	#instVars : [
		'socket',
		'lastSocketState'
	],
	#category : #'Ocean-KernelTests'
}

{ #category : #accessing }
OCNTcpSocketFinalizationTest >> lastSocketState [
	^ lastSocketState
]

{ #category : #accessing }
OCNTcpSocketFinalizationTest >> lastSocketState: anObject [
	lastSocketState := anObject
]

{ #category : #testing }
OCNTcpSocketFinalizationTest >> testBoundSocketFinalization [
	self fail
]

{ #category : #testing }
OCNTcpSocketFinalizationTest >> testCleanSocketFinalization [
	socket := OCNConversationTcpSocketForFinalizationTest new.
	WeakRegistry default add: socket.
	self assert: socket isClean.
	socket testUnit: self.
	socket := nil.
	SmalltalkImage current garbageCollect.
	self assert: self lastSocketState == #destroyed
]
