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
OCNSocket class >> new [
	^self newWithNetworkLibraryClass: OCNNetworkLibraryProxyFactory defaultNetworkLibraryProxyClass
]

{ #category : #'instance creation' }
OCNSocket class >> newWithNetworkLibrary: aNetworkLibraryProxy [
	^super new
		networkLibrary: aNetworkLibraryProxy;
		yourself
]

{ #category : #'instance creation' }
OCNSocket class >> newWithNetworkLibraryClass: aNetworkLibraryClass [
	^self newWithNetworkLibrary: (OCNNetworkLibraryProxyFactory proxyForLibraryClass:  aNetworkLibraryClass)
]

{ #category : #connection }
OCNSocket >> basicDestroy [
	self state: self destroyedStateSymbol.
	self networkLibrary destroy: self
]

{ #category : #connecting }
OCNSocket >> bindToAddress: aSocketAddress [ 
	self isClean ifFalse: [ 
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
	localhostAddress := OCNIpv4Address loopbackAddressWithPort: aPortNumber.
	self bindToAddress: localhostAddress 	
]

{ #category : #'state names' }
OCNSocket >> boundStateSymbol [
	^#bound

]

{ #category : #'state names' }
OCNSocket >> cleanStateSymbol [
	^ #clean
]

{ #category : #connection }
OCNSocket >> destroy [
	self isDestroyed
		ifTrue: [ ^ self ].
	self basicDestroy
]

{ #category : #'state names' }
OCNSocket >> destroyedStateSymbol [
	^ #destroyed
]

{ #category : #finalization }
OCNSocket >> finalize [ 
	super finalize.
	self destroy
]

{ #category : #'initialize-release' }
OCNSocket >> initialize [ 
	super initialize.
	self state: self cleanStateSymbol 
]

{ #category : #'as yet unclassified' }
OCNSocket >> isBound [
	^self state = self boundStateSymbol
]

{ #category : #'state testing' }
OCNSocket >> isClean [
	^self state = self cleanStateSymbol
]

{ #category : #'state testing' }
OCNSocket >> isDestroyed [
	^self state = self destroyedStateSymbol
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
OCNSocket >> receiveDataBufferSize [
	^2048
]

{ #category : #accessing }
OCNSocket >> sendDataBufferSize [
	^self receiveDataBufferSize
]

{ #category : #accessing }
OCNSocket >> sendTimeOutSeconds [
	^self connectionTimeOutSeconds
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
