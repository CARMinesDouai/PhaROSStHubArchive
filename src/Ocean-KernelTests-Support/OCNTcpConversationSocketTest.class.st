Class {
	#name : #OCNTcpConversationSocketTest,
	#superclass : #OCNSocketTest,
	#category : #'Ocean-KernelTests'
}

{ #category : #accessing }
OCNTcpConversationSocketTest class >> shouldBeSubclassedForBackendTesting [
	^true
]

{ #category : #accessing }
OCNTcpConversationSocketTest >> serverClass [
	^OCNTcpReceivingServerForTest 
]

{ #category : #accessing }
OCNTcpConversationSocketTest >> socketClass [ 
	^OCNConversationTcpSocket
]

{ #category : #accessing }
OCNTcpConversationSocketTest >> stateTestingSelectors [ 
	^#(isClean isBound isConnected isDestroyed)
]

{ #category : #testing }
OCNTcpConversationSocketTest >> testAdaptSocketBufferSizes [
	<expectedFailure>
	self signalFailure: 'We need to create socket and specify its buffer sizes'
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testBindBoundSocket [
	
	| initialPort otherPort |
	initialPort := 1234.
	otherPort := 9125.
	self assertSocketState: #isClean.
	socket bindToLocalHostPort: initialPort.	
	self assertSocketState: #isBound.
	self should: [socket bindToLocalHostPort: initialPort] raise: OCNSocketOperationForbiddenError.	
	self assertSocketState: #isBound.
	self should: [socket bindToLocalHostPort: otherPort] raise: OCNSocketOperationForbiddenError.	
	self assertSocketState: #isBound
	
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testBindConnectedSocket [
	self startServerAndValue: [:server|
		socket connectToServer: server address.
		self assertSocketState: #isConnected.
		self should: [socket bindToLocalHostPort: server portNumber] raise: OCNSocketOperationForbiddenError.
		self assertSocketState: #isConnected
	]
	
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testBindDestroyedSocket [
	socket destroy.
	self assertSocketState: #isDestroyed.
	self should: [socket bindToLocalHostPort: 12345] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isDestroyed
	
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testBindTwoSocketsOnSamePort [
	| otherSocket  clientPort|
	clientPort := 1234.
	
	self assertSocketState: #isClean.
	socket bindToLocalHostPort: clientPort.	
	self assertSocketState: #isBound.
	
	otherSocket := OCNConversationTcpSocket newWithNetworkLibraryClass: self networkLibraryClass.
	self should: [ otherSocket bindToLocalHostPort: clientPort ] raise: OCNSocketOperationFailureError.	
	self assert:  otherSocket isDestroyed.
	
	self assertSocketState: #isBound.
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testBindUnconnectedSocket [
	| ipAddress  |
	self testSocketUnconnectedOnCreation.
	self assertSocketState: #isClean.
	ipAddress := OCNIpv4Address loopbackAddressWithPort:  1234.	
	self shouldnt: [socket bindToAddress: ipAddress] raise: OCNSocketOperationFailureError.
	self assertSocketState: #isBound.

]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testConnectConnectedSocket [
	self startServerAndValue: [:server|
		socket connectToServer: server address.
		self should: [ socket connectToServer: server address ] raise: OCNSocketOperationForbiddenError .
		self assertSocketState: #isConnected
	]
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testConnectDestroyedSocket [
	self startServerAndValue: [:server|
		socket destroy.
		self assertSocketState: #isDestroyed.
		self should: [socket connectToServer: server address] raise: OCNSocketOperationForbiddenError.
		self assertSocketState: #isDestroyed
	]
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testConnectFailureOfBoundSocket [
	self testBindUnconnectedSocket.
	self assertSocketState: #isBound.
	self should: [socket connectToServer: (OCNIpv4Address loopbackAddressWithPort: 4387)] raise: OCNSocketOperationFailureError.
	self assertSocketState: #isDestroyed
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testConnectFailureOfUnconnectedSocket [
	self assertSocketState: #isClean.
	self should: [socket connectToServer: (OCNIpv4Address loopbackAddressWithPort: 4387)] raise: OCNSocketOperationFailureError.
	self assertSocketState: #isDestroyed
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testConnectUnconnectedSocket [
	self startServerAndValue: [:server|
		self assertSocketState: #isClean.
		socket connectToServer: server address.
		self assertSocketState: #isConnected]

]

{ #category : #accessing }
OCNTcpConversationSocketTest >> testCreateSocketWithAnId [
	<expectedFailure>
	self signalFailure: 'We need to create socket with an already known Id'
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testDestroyBoundSocket [
	self testBindUnconnectedSocket.
	self assertSocketState: #isBound.
	socket destroy.
	self assertSocketState: #isDestroyed.

]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testDestroyConnectedSocket [
	self startServerAndValue: [:server|
		socket connectToServer: server address.
		self assertSocketState: #isConnected.
		socket destroy.
		self assertSocketState: #isDestroyed
	]
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testReceiveOnDestroyedSocket [
	self testDestroyUnconnectedSocket.
	self assertSocketState: #isDestroyed.
	self should: [ socket receive ] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isDestroyed.

]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testSendOnDestroyedSocket [
	self testDestroyUnconnectedSocket.
	self assertSocketState: #isDestroyed.
	self should: [socket send: 'hello'] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isDestroyed.
	
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testSocketUnconnectedOnCreation [
	self assert: socket socketId notNil.
	self assertSocketState:  #isClean.

]
