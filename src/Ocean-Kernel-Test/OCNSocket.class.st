"
an OCNSocket has the following lifecycle :
 
state 1 : closed
state 2 : connected
state 3 : listening
state 4 : destroyed

1 -> 2, 3, 4
2 -> 1
3 -> 1

"
Class {
	#name : #OCNSocket,
	#superclass : #Object,
	#instVars : [
		'socketId',
		'networkLibrary',
		'state'
	],
	#category : #'Ocean-Kernel'
}

{ #category : #'instance creation' }
OCNSocket class >> newWithNetworkLibrary: aNetworkLibraryProxy [
	^super new
		networkLibrary: aNetworkLibraryProxy;
		yourself
]

{ #category : #connecting }
OCNSocket >> bindToAddress: aSocketAddress [ 
	
	self networkLibrary bind: self socketId toIpv4Address: aSocketAddress.
	self state: self boundStateSymbol
	
]

{ #category : #connection }
OCNSocket >> destroy [
	self isDestroyed 
		ifTrue: [ ^ self ].
	(self networkLibrary close: self socketId) = 0
		ifTrue: [ self state: self destroyedStateSymbol ]
]

{ #category : #'state names' }
OCNSocket >> destroyedStateSymbol [
	^ #destroyed
]

{ #category : #'initialize-release' }
OCNSocket >> initialize [ 
	super initialize.
	self networkLibrary: OCNNetworkLibraryProxyFactory networkLibraryProxy.
	self socketId: self newSocketId.
	self state: self unconnectedStateSymbol 
]

{ #category : #'state testing' }
OCNSocket >> isDestroyed [
	^self state = self destroyedStateSymbol
]

{ #category : #'state testing' }
OCNSocket >> isUnconnected [ 
	^self state = self unconnectedStateSymbol
]

{ #category : #accessing }
OCNSocket >> networkLibrary [
	^ networkLibrary
]

{ #category : #accessing }
OCNSocket >> networkLibrary: anObject [
	networkLibrary := anObject
]

{ #category : #'initialize-release' }
OCNSocket >> newSocketId [
	self subclassResponsibility 
]

{ #category : #accessing }
OCNSocket >> socketId [
	^ socketId
]

{ #category : #accessing }
OCNSocket >> socketId: anObject [
	socketId := anObject
]

{ #category : #accessing }
OCNSocket >> state [
	^ state
]

{ #category : #private }
OCNSocket >> state: anObject [
	state := anObject
]

{ #category : #'state names' }
OCNSocket >> unconnectedStateSymbol [
	^ #unconnected
]
