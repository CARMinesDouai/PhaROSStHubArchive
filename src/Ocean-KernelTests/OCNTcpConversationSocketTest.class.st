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
OCNTcpConversationSocketTest >> clientPort [
	^ 2222
]

{ #category : #testing }
OCNTcpConversationSocketTest >> connect [
	socket connectToServer: self serverAddress.

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
	self signalFailure: 'We need to create socket and specify its buffer sizes'
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testBindBoundSocket [
	
	| initialPort otherPort |
	initialPort := self clientPort.
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
	self startServer.
	self connect.
	self assertSocketState: #isConnected.
	self should: [socket bindToLocalHostPort: self serverPort] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isConnected
	
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testBindDestroyedSocket [
	socket destroy.
	self assertSocketState: #isDestroyed.
	self should: [socket bindToLocalHostPort: self serverPort] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isDestroyed
	
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testBindUnconnectedSocket [
	| ipAddress |
	self testSocketUnconnectedOnCreation.
	self assertSocketState: #isClean.
	ipAddress := OCNIpv4Address loopbackAddressWithPort:  self clientPort.	
	self shouldnt: [socket bindToAddress: ipAddress] raise: OCNSocketOperationFailureError.
	self assertSocketState: #isBound.
	"self signalFailure: 'Ensures that client socket is bount to clientPort '"

]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testConnectConnectedSocket [
	self testConnectUnconnectedSocket.
	self should: [ self connect ] raise: OCNSocketOperationForbiddenError .
	self assertSocketState: #isConnected
	
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testConnectDestroyedSocket [
	self startServer.
	socket destroy.
	self assertSocketState: #isDestroyed.
	self should: [self connect] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isDestroyed
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testConnectFailureOfBoundSocket [
	self testBindUnconnectedSocket.
	self should: [self connect] raise: OCNSocketOperationFailureError.
	self assertSocketState: #isDestroyed
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testConnectFailureOfUnconnectedSocket [
	self assertSocketState: #isClean.
	self should: [self connect] raise: OCNSocketOperationFailureError.
	self assertSocketState: #isDestroyed
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTest >> testConnectUnconnectedSocket [
	self startServer.
	self assertSocketState: #isClean.
	self connect.
	self assertSocketState: #isConnected.

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
	self startServer.
	self connect.
	self assertSocketState: #isConnected.
	socket destroy.
	self assertSocketState: #isDestroyed
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
