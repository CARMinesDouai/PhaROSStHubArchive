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
	^self new
		networkLibrary: aNetworkLibraryProxy;
		yourself
]

{ #category : #'instance creation' }
OCNSocket class >> newWithNetworkLibraryClass: aNetworkLibraryClass [
	^self newWithNetworkLibrary: (OCNNetworkLibraryProxyFactory proxyForLibraryClass:  aNetworkLibraryClass)
]

{ #category : #connecting }
OCNSocket >> bindToAddress: aSocketAddress [ 
	self isUnconnected ifFalse: [ 
		OCNSocketOperationForbiddenError signal: self state asString capitalized, ' socket can not be bound' ].
	[
		self networkLibrary bind: self toIpv4Address: aSocketAddress
	] on: OCNSocketOperationFailureError do: [:ex|
		self destroy.
		ex pass.
	].
	self state: self boundStateSymbol
	
]

{ #category : #connecting }
OCNSocket >> bindToLocalHostPort: aPortNumber [ 
	| localhostAddress |
	localhostAddress := OCNIPV4SocketAddress loopbackAddressWithPort: aPortNumber.
	self bindToAddress: localhostAddress 	
]

{ #category : #'state names' }
OCNSocket >> boundStateSymbol [
	^#bound

]

{ #category : #connection }
OCNSocket >> destroy [
	self isDestroyed 
		ifTrue: [ ^ self ].
	self state: self destroyedStateSymbol.
	self networkLibrary destroy: self.

]

{ #category : #'state names' }
OCNSocket >> destroyedStateSymbol [
	^ #destroyed
]

{ #category : #'initialize-release' }
OCNSocket >> initialize [ 
	super initialize.
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
	^ networkLibrary ifNil: [ networkLibrary := OCNNetworkLibraryProxyFactory networkLibraryProxy ]
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
	^ socketId ifNil: [ socketId := self newSocketId]
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
