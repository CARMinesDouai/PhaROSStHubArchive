Class {
	#name : #SocketStreamTest,
	#superclass : #TestCase,
	#instVars : [
		'listener',
		'stream1',
		'stream2'
	],
	#category : #'Network-Kernel-Tests'
}

{ #category : #running }
SocketStreamTest >> setUp [
	listener _ Socket newTCP listenOn: 7357 backlogSize: 5.
	stream1 _ SocketStream on: (Socket newTCP connectTo: NetNameResolver localHostAddress port: 7357).
	stream2 _ SocketStream on: listener accept
]

{ #category : #running }
SocketStreamTest >> tearDown [
	listener close.
	stream1 close.
	stream2 close
]

{ #category : #running }
SocketStreamTest >> testNextColonBug [
	stream2 timeout: 1.
	stream1 nextPutAll: '12345678'; flush.
	stream2 next: 4.
	"self should: [stream2 next: 8] raise: ConnectionTimedOut"
	self assert: false.
	"md: doesn't timeOut for me... just hangs".
]

{ #category : #running }
SocketStreamTest >> testNextColonConnectionTimeout [
	"
	stream1 nextPutAll: '12345'; flush.
	stream2 timeout: 1.
	self should: [stream2 next: 10] raise: ConnectionTimedOut.
	stream1 nextPutAll: '67890'; flush.
	self assert: (stream2 next: 10) size = 10
	"
	self assert: false.
	"md: doesn't timeOut for me... just hangs".
]
