Class {
	#name : #OCNTcpSocketTest,
	#superclass : #OCNSocketTest,
	#category : #'Ocean-Kernel-Test'
}

{ #category : #accessing }
OCNTcpSocketTest >> clientPort [
	^ 2222
]

{ #category : #testing }
OCNTcpSocketTest >> connect [
	socket connectToServer: self serverAddress.

]

{ #category : #accessing }
OCNTcpSocketTest >> socketClass [ 
	^OCNConversationTcpSocket
]

{ #category : #accessing }
OCNTcpSocketTest >> stateTestingSelectors [ 
	^#(isClean isBound isConnected isDestroyed)
]

{ #category : #'testing lifecylce' }
OCNTcpSocketTest >> testBindBoundSocket [
	
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
OCNTcpSocketTest >> testBindConnectedSocket [
	self startServer.
	self connect.
	self assertSocketState: #isConnected.
	self should: [socket bindToLocalHostPort: self serverPort] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isConnected
	
]

{ #category : #'testing lifecylce' }
OCNTcpSocketTest >> testBindDestroyedSocket [
	socket destroy.
	self assertSocketState: #isDestroyed.
	self should: [socket bindToLocalHostPort: self serverPort] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isDestroyed
	
]

{ #category : #'testing lifecylce' }
OCNTcpSocketTest >> testBindUnconnectedSocket [
	| socketAddress |
	self testSocketUnconnectedOnCreation.
	self assertSocketState: #isClean.
	socketAddress := OCNIPV4SocketAddress loopbackAddressWithPort:  self clientPort.	
	self shouldnt: [socket bindToAddress: socketAddress] raise: OCNSocketOperationFailureError.
	self assertSocketState: #isBound.
	"self signalFailure: 'Ensures that client socket is bount to clientPort '"

]

{ #category : #'testing lifecylce' }
OCNTcpSocketTest >> testConnectConnectedSocket [
	self testConnectUnconnectedSocket.
	self should: [ self connect ] raise: OCNSocketOperationForbiddenError .
	self assertSocketState: #isConnected
	
]

{ #category : #'testing lifecylce' }
OCNTcpSocketTest >> testConnectDestroyedSocket [
	self startServer.
	socket destroy.
	self assertSocketState: #isDestroyed.
	self should: [self connect] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isDestroyed
]

{ #category : #'testing lifecylce' }
OCNTcpSocketTest >> testConnectFailureOfBoundSocket [
	self testBindUnconnectedSocket.
	self should: [self connect] raise: OCNSocketOperationFailureError.
	self assertSocketState: #isDestroyed
]

{ #category : #'testing lifecylce' }
OCNTcpSocketTest >> testConnectFailureOfUnconnectedSocket [
	self assertSocketState: #isClean.
	self should: [self connect] raise: OCNSocketOperationFailureError.
	self assertSocketState: #isDestroyed
]

{ #category : #'testing lifecylce' }
OCNTcpSocketTest >> testConnectUnconnectedSocket [
	self startServer.
	self assertSocketState: #isClean.
	self connect.
	self assertSocketState: #isConnected.

]

{ #category : #'testing lifecylce' }
OCNTcpSocketTest >> testDestroyBoundSocket [
	self testBindUnconnectedSocket.
	self assertSocketState: #isBound.
	socket destroy.
	self assertSocketState: #isDestroyed.

]

{ #category : #'testing lifecylce' }
OCNTcpSocketTest >> testDestroyConnectedSocket [
	self startServer.
	self connect.
	self assertSocketState: #isConnected.
	socket destroy.
	self assertSocketState: #isDestroyed
]

{ #category : #'testing lifecylce' }
OCNTcpSocketTest >> testDestroyDestroyedSocket [
	self testDestroyUnconnectedSocket.
	self assertSocketState: #isDestroyed.
	self shouldnt: [socket destroy] raise: Error.
	self assertSocketState: #isDestroyed.
	
]

{ #category : #'testing lifecylce' }
OCNTcpSocketTest >> testDestroyUnconnectedSocket [
	self assertSocketState: #isClean.
	socket destroy.
	self assertSocketState: #isDestroyed.

]

{ #category : #'testing lifecylce' }
OCNTcpSocketTest >> testReceiveOnDestroyedSocket [
	self testDestroyUnconnectedSocket.
	self assertSocketState: #isDestroyed.
	self should: [ socket receive ] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isDestroyed.

]

{ #category : #'testing lifecylce' }
OCNTcpSocketTest >> testSendOnDestroyedSocket [
	self testDestroyUnconnectedSocket.
	self assertSocketState: #isDestroyed.
	self should: [socket send: 'hello'] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isDestroyed.
	
]

{ #category : #'testing lifecylce' }
OCNTcpSocketTest >> testSocketUnconnectedOnCreation [
	self assert: socket socketId notNil.
	self assertSocketState:  #isClean.

]
