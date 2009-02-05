Class {
	#name : #RSTSocketStreamPoolTest,
	#superclass : #RSTTestCase,
	#instVars : [
		'pool'
	],
	#category : #'rST-Tests'
}

{ #category : #'setUp-tearDown' }
RSTSocketStreamPoolTest >> setUp [
	super setUp.
	pool := defaultBroker  socketStreamPoolFor: self extraIpAndPortString 
]

{ #category : #testing }
RSTSocketStreamPoolTest >> testReleaseStreamDoNotRemberAClosedSockeStream [
	| socketStream |
	socketStream := pool socketStream.
	self assert: socketStream isConnected.
	socketStream close.	
	self assert: socketStream socket isUnconnectedOrInvalid.
	pool releaseStream: socketStream.
	self deny: socketStream == pool socketStream
]
