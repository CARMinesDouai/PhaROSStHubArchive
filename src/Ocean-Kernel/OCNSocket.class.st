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
	^self basicNew 
		networkLibrary: aNetworkLibraryProxy;
		initialize;
		yourself
]

{ #category : #'instance creation' }
OCNSocket class >> newWithNetworkLibraryClass: aNetworkLibraryClass [
	^self newWithNetworkLibrary: (OCNNetworkLibraryProxyFactory proxyForLibraryClass:  aNetworkLibraryClass)
]

{ #category : #constants }
OCNSocket class >> receiveDataBufferSize [
	^2048
]

{ #category : #constants }
OCNSocket class >> sendDataBufferSize [
	^2048
]

{ #category : #connection }
OCNSocket >> basicDestroy [
	self state: self destroyedStateSymbol.

]

{ #category : #connecting }
OCNSocket >> bindToAddress: anIpAddress [ 
	self isClean ifFalse: [ 
		OCNSocketOperationForbiddenError signal: self state asString capitalized, ' socket can not be bound' ].
	[
		self networkLibrary bind: self toIpv4Address: anIpAddress
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
	self destroy.
]

{ #category : #'initialize-release' }
OCNSocket >> initialize [
	super initialize.
	self state: self cleanStateSymbol.
	self socketId ifNotNil: [ ^self ].
	self initializeWithId: self newSocketId
]

{ #category : #'initialize-release' }
OCNSocket >> initializeWithId: aSocketId [
	[self socketId: aSocketId] 
		on: OCNSocketOperationFailureError 
		do: [:ex|
			self destroy.
			ex pass].
	WeakRegistry default add: self. "to ensure future finalization"


]

{ #category : #'state testing' }
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

{ #category : #constants }
OCNSocket >> receiveDataBufferSize [
	^self class receiveDataBufferSize 
]

{ #category : #constants }
OCNSocket >> sendDataBufferSize [
	^self class sendDataBufferSize 
]

{ #category : #accessing }
OCNSocket >> sendTimeOutSeconds [
	^self connectionTimeoutSeconds
]

{ #category : #accessing }
OCNSocket >> socketId [
	^ socketId
]

{ #category : #accessing }
OCNSocket >> socketId: anObject [
	socketId := anObject.
]

{ #category : #accessing }
OCNSocket >> state [
	^ state
]

{ #category : #private }
OCNSocket >> state: anObject [
	
	state := anObject
]
