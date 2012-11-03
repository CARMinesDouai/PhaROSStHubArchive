Class {
	#name : #OCNTcpConversationSocketTestOldDone,
	#superclass : #OCNSocketTestOldDone,
	#category : #'Ocean-KernelTests-Old'
}

{ #category : #accessing }
OCNTcpConversationSocketTestOldDone class >> shouldBeSubclassedForBackendTesting [
	^true
]

{ #category : #testing }
OCNTcpConversationSocketTestOldDone >> connect [
	socket connectToServer: self serverAddress.

]

{ #category : #accessing }
OCNTcpConversationSocketTestOldDone >> socketClass [ 
	^OCNConversationTcpSocket
]

{ #category : #accessing }
OCNTcpConversationSocketTestOldDone >> stateTestingSelectors [ 
	^#(isClean isBound isConnected isDestroyed)
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTestOldDone >> testBindConnectedSocket [
	self startServer.
	self connect.
	self assertSocketState: #isConnected.
	self should: [socket bindToLocalHostPort: self serverPort] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isConnected
	
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTestOldDone >> testBindDestroyedSocket [
	socket destroy.
	self assertSocketState: #isDestroyed.
	self should: [socket bindToLocalHostPort: self serverPort] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isDestroyed
	
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTestOldDone >> testBindTwoSocketsOnSamePort [
	| otherSocket |
	
	self assertSocketState: #isClean.
	socket bindToLocalHostPort: self clientPort.	
	self assertSocketState: #isBound.
	
	otherSocket := OCNConversationTcpSocket newWithNetworkLibraryClass: self networkLibraryClass.
	self should: [ otherSocket bindToLocalHostPort: self clientPort ] raise: OCNSocketOperationFailureError.	
	self assert:  otherSocket isDestroyed.
	
	self assertSocketState: #isBound.
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTestOldDone >> testBindUnconnectedSocket [
	| ipAddress |
	self testSocketUnconnectedOnCreation.
	self assertSocketState: #isClean.
	ipAddress := OCNIpv4Address loopbackAddressWithPort:  self clientPort.	
	self shouldnt: [socket bindToAddress: ipAddress] raise: OCNSocketOperationFailureError.
	self assertSocketState: #isBound.
	"self signalFailure: 'Ensures that client socket is bount to clientPort '"

]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTestOldDone >> testConnectConnectedSocket [
	self testConnectUnconnectedSocket.
	self should: [ self connect ] raise: OCNSocketOperationForbiddenError .
	self assertSocketState: #isConnected
	
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTestOldDone >> testConnectDestroyedSocket [
	self startServer.
	socket destroy.
	self assertSocketState: #isDestroyed.
	self should: [self connect] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isDestroyed
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTestOldDone >> testConnectFailureOfBoundSocket [
	self testBindUnconnectedSocket.
	self should: [self connect] raise: OCNSocketOperationFailureError.
	self assertSocketState: #isDestroyed
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTestOldDone >> testConnectFailureOfUnconnectedSocket [
	self assertSocketState: #isClean.
	self should: [self connect] raise: OCNSocketOperationFailureError.
	self assertSocketState: #isDestroyed
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTestOldDone >> testConnectUnconnectedSocket [
	self startServer.
	self assertSocketState: #isClean.
	self connect.
	self assertSocketState: #isConnected.

]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTestOldDone >> testDestroyBoundSocket [
	self testBindUnconnectedSocket.
	self assertSocketState: #isBound.
	socket destroy.
	self assertSocketState: #isDestroyed.

]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTestOldDone >> testDestroyConnectedSocket [
	self startServer.
	self connect.
	self assertSocketState: #isConnected.
	socket destroy.
	self assertSocketState: #isDestroyed
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTestOldDone >> testReceiveOnDestroyedSocket [
	self testDestroyUnconnectedSocket.
	self assertSocketState: #isDestroyed.
	self should: [ socket receive ] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isDestroyed.

]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTestOldDone >> testSendOnDestroyedSocket [
	self testDestroyUnconnectedSocket.
	self assertSocketState: #isDestroyed.
	self should: [socket send: 'hello'] raise: OCNSocketOperationForbiddenError.
	self assertSocketState: #isDestroyed.
	
]

{ #category : #'testing lifecylce' }
OCNTcpConversationSocketTestOldDone >> testSocketUnconnectedOnCreation [
	self assert: socket socketId notNil.
	self assertSocketState:  #isClean.

]
