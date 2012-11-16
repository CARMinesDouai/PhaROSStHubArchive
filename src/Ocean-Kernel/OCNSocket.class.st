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

{ #category : #'socket_api' }
OCNSocket >> address [
	
	^self localAddress
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

{ #category : #'socket_api' }
OCNSocket >> close [
	^self networkLibrary close: self.
]

{ #category : #'socket_api' }
OCNSocket >> closeAndDestroy [
	self close.
	^self destroy
]

{ #category : #'socket_api' }
OCNSocket >> closeAndDestroy:timeoutSeconds [
	self flag: 'todo'.
	self close.
	^self destroy
]

{ #category : #'socket_api' }
OCNSocket >> dataAvailable [
	
	^self networkLibrary isDataAvailableFrom: self
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

{ #category : #'socket_api' }
OCNSocket >> isOtherEndClosed [
	
	^self networkLibrary isOtherEndClosed: self
]

{ #category : #'socket_api' }
OCNSocket >> isThisEndClosed [
	
	^self networkLibrary isThisEndClosed: self
]

{ #category : #'socket_api' }
OCNSocket >> isUnconnected [
	
	^self networkLibrary isUnconnected: self
]

{ #category : #'socket_api' }
OCNSocket >> isValid [
	
	^self networkLibrary isValid: self
]

{ #category : #'socket_api' }
OCNSocket >> isWaitingForConnection [
	
	^self networkLibrary isWaitingForConnection: self
]

{ #category : #'socket_api' }
OCNSocket >> localAddress [
	
	^self networkLibrary localAddress: self
]

{ #category : #'socket_api' }
OCNSocket >> localPort [
	
	^self networkLibrary localPort: self
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

{ #category : #'socket_api' }
OCNSocket >> port [
	
	^self localPort
]

{ #category : #constants }
OCNSocket >> receiveDataBufferSize [
	^self class receiveDataBufferSize 
]

{ #category : #'socket_api' }
OCNSocket >> remoteAddress [
	
	^self networkLibrary remoteAddress: self
]

{ #category : #'socket_api' }
OCNSocket >> remotePort [
	
	^self networkLibrary remotePort: self
]

{ #category : #constants }
OCNSocket >> sendDataBufferSize [
	^self class sendDataBufferSize 
]

{ #category : #accessing }
OCNSocket >> sendTimeOutSeconds [
	^self connectionTimeoutSeconds
]

{ #category : #'socket_api' }
OCNSocket >> setOption: aName value: aValue [ 
	
	^self networkLibrary set: self option: aName value: aValue 
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

{ #category : #'socket_api' }
OCNSocket >> timeOut [
	^ 3
]

{ #category : #'socket_api' }
OCNSocket >> waitForAcceptFor: timeout [
	"Wait and accept an incoming connection. Return nil if it falis"
	self waitForConnectionFor: timeout ifTimedOut: [^ nil].
	^ self isConnected
		ifTrue:[self accept]
]

{ #category : #'socket_api' }
OCNSocket >> waitForConnectionFor: timeout [
	
	self waitForConnectionFor: timeout ifTimedOut: []
]

{ #category : #'socket_api' }
OCNSocket >> waitForConnectionFor: timeout ifTimedOut: timeoutBlock [
	
	self networkLibrary waitForConnectionOf: self timeoutSeconds: timeout onTimeoutDo: timeoutBlock
]

{ #category : #'socket_api' }
OCNSocket >> waitForDataFor: timeout [
	"Wait for the given nr of seconds for data to arrive.
	Signal a time out or connection close exception if either happens before data becomes available."

	^self
		waitForDataFor: timeout
		ifClosed: [ConnectionClosed signal: 'Connection closed while waiting for data.']
		ifTimedOut: [ConnectionTimedOut signal: 'Data receive timed out.']

]

{ #category : #'socket_api' }
OCNSocket >> waitForDataFor: timeout ifClosed: closedBlock ifTimedOut: timedOutBlock [
	self flag:'TODO: include a close condition'.
	self networkLibrary waitForDataOn: self socketId for: timeout ifClosed: closedBlock ifTimedOut: timedOutBlock
]

{ #category : #'socket_api' }
OCNSocket >> waitForDataIfClosed: closedBlock [
	self flag:'TODO: include a close condition'.
	self networkLibrary waitForDataOn: self socketId for: self timeOut onTimedOut: closedBlock
]

{ #category : #'socket_api' }
OCNSocket >> waitForSendDoneFor: timeout [

	self networkLibrary waitForSendDoneOn: self socketId for: timeout
]
