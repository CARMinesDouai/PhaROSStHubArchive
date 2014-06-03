"
an OCNTcpSocket has the following lifecycle :
 
state 1 : clean
state 2 : bound
state 3 : connected
state 4 : destroyed
1 -> 2, 3, 4
2 -> 3, 4
3 -> 4



""simple example to finish""


ip := OCNIPV4SocketAddress family: OCNIPV4SocketAddress afInetFamily;
		ip: (OCNNetNameResolver ipv4AddressForName: 'www.google.fr'); 
		port: aPortNumber ;
		yourself
OCNConversationTcpSocket new connectToServer: 


(OCNNetNameResolver ipv4AddressForName: 'www.google.fr') '209.85.143.104'  
"
Class {
	#name : #OCNConversationTcpSocket,
	#superclass : #OCNTcpSocket,
	#instVars : [
		'connectionTimeoutSeconds',
		'sendTimeoutSeconds',
		'receiveTimeOutSeconds'
	],
	#category : #'Ocean-Kernel'
}

{ #category : #'instance creation' }
OCNConversationTcpSocket class >> newConnectedTo: anIpAddress [
	 
	^self new 
		connectToServer: anIpAddress;
		yourself
]

{ #category : #'instance creation' }
OCNConversationTcpSocket class >> newConnectedToIp: anIp port: aPort [
	
	 | anIpAddress |
	anIpAddress := OCNIpv4Address ip: anIp port: aPort.
	^ self newConnectedTo: anIpAddress
]

{ #category : #'instance creation' }
OCNConversationTcpSocket class >> newConnectedToIp: anIp port: aPort timeout: timeout [
	 | anIpAddress |
	anIpAddress := OCNIpv4Address ip: anIp port: aPort.
	^self new 
		connectionTimeoutSeconds: timeout;
		connectToServer: anIpAddress;
		yourself

]

{ #category : #'instance creation' }
OCNConversationTcpSocket class >> newConnectedWithId: socketId [
	 |newSocket|
	newSocket := self basicNew.
	newSocket
		socketId: socketId;
		initialize;
		state: newSocket connectedStateSymbol.
	^newSocket
]

{ #category : #'instance creation' }
OCNConversationTcpSocket class >> newConnectedWithId: socketId  library: networkLibrary [
	^(self newConnectedWithId: socketId) 
		networkLibrary:  networkLibrary;
		yourself
]

{ #category : #connection }
OCNConversationTcpSocket >> connectToServer: serverAddress [

	(self isClean | self isBound ) ifFalse:  [ 
		OCNSocketOperationForbiddenError signal: self state asString capitalized, ' socket can not be connected' ].
	[
		self networkLibrary connect: self toServerWithIpv4Address: serverAddress.
	] on: OCNError do: [:ex|
		self destroy.
		ex pass.
	].
	self state:  self connectedStateSymbol

]

{ #category : #'state names' }
OCNConversationTcpSocket >> connectedStateSymbol [
	^#connected

]

{ #category : #accessing }
OCNConversationTcpSocket >> connectionTimeoutSeconds [
	^connectionTimeoutSeconds
]

{ #category : #accessing }
OCNConversationTcpSocket >> connectionTimeoutSeconds: anObject [
	connectionTimeoutSeconds := anObject
]

{ #category : #'initialize-release' }
OCNConversationTcpSocket >> initialize [ 
	super initialize.
	self connectionTimeoutSeconds: 3.
	self sendTimeoutSeconds: 3.
	self receiveTimeOutSeconds: 3
]

{ #category : #'state testing' }
OCNConversationTcpSocket >> isConnected [ 
	^self state = self connectedStateSymbol
]

{ #category : #'state testing' }
OCNConversationTcpSocket >> isDataAvailable [
	^self isConnected and: [self networkLibrary isDataAvailableFrom: self]
]

{ #category : #'state testing' }
OCNConversationTcpSocket >> isOtherEndClosed [
	"Return true if this socket had the other end closed."

	^ self networkLibrary isSocketOtherEndClosed: self
]

{ #category : #communicating }
OCNConversationTcpSocket >> receive [
	self isConnected ifFalse: [OCNSocketOperationForbiddenError signal: 'Socket should be connected before receiving'].
	^self networkLibrary tcpReceiveFrom: self	
]

{ #category : #communicating }
OCNConversationTcpSocket >> receiveDataInto: aStringOrByteArray startingAt: aNumber count: count [
	
	| bytesRead closed |
	bytesRead := 0.
	closed := false.
	self isConnected ifFalse: [OCNSocketOperationForbiddenError signal: 'Socket should be connected before receiving'].	
	[closed not and: [bytesRead = 0]]
		whileTrue: [
			self waitForDataIfTimeout: [closed := true].
			bytesRead := self networkLibrary tcpReceiveFrom: self into: aStringOrByteArray startingAt: aNumber count: count].
	^bytesRead
]

{ #category : #accessing }
OCNConversationTcpSocket >> receiveTimeOutSeconds [
	^receiveTimeOutSeconds
]

{ #category : #accessing }
OCNConversationTcpSocket >> receiveTimeOutSeconds: timeout [
	receiveTimeOutSeconds := timeout
	
]

{ #category : #accessing }
OCNConversationTcpSocket >> refreshState [
	state = self connectedStateSymbol ifFalse: [^self].
	(self networkLibrary isSocketConnected: self) ifFalse: [self basicDestroy]

]

{ #category : #communicating }
OCNConversationTcpSocket >> send: aByteStringOrByteArray [
	^ self sendData: aByteStringOrByteArray 
]

{ #category : #communicating }
OCNConversationTcpSocket >> sendData: buffer [
	^ self sendData: buffer count: buffer size
]

{ #category : #communicating }
OCNConversationTcpSocket >> sendData: buffer count: n [
	"Send the amount of data from the given buffer"
	| sent |
	sent := 0.
	[sent < n] whileTrue:[
		sent := sent + (self sendData: buffer startIndex: sent+1 count: (n-sent))].
	^ sent
]

{ #category : #communicating }
OCNConversationTcpSocket >> sendData: aStringOrByteArray startIndex: startIndex count: count [
	"Send up to count bytes of the given data starting at the given index. Answer the number of bytes actually sent."
	"Note: This operation may have to be repeated multiple times to send a large amount of data."
	
	self isConnected
		ifFalse: [ OCNSocketOperationForbiddenError signal: 'Socket should be connected before sending' ].
	
	^self networkLibrary tcpSendSomeData: aStringOrByteArray startIndex: startIndex count: count to: self

]

{ #category : #'backward compatibility' }
OCNConversationTcpSocket >> sendSomeData: aStringOrByteArray startIndex: startIndex count: count [ 
		^ self sendData: aStringOrByteArray startIndex: startIndex count: count
]

{ #category : #'backward compatibility' }
OCNConversationTcpSocket >> sendSomeData: aStringOrByteArray startIndex: startIndex count: count for: aTimeoutInSeconds [
	"Send up to count bytes of the given data starting at the given index. Answer the number of bytes actually sent."
	"Note: This operation may have to be repeated multiple times to send a large amount of data."
	
	self sendTimeoutSeconds: aTimeoutInSeconds.
	^self sendData: aStringOrByteArray startIndex: startIndex count: count
]

{ #category : #accessing }
OCNConversationTcpSocket >> sendTimeoutSeconds [
	^sendTimeoutSeconds
]

{ #category : #accessing }
OCNConversationTcpSocket >> sendTimeoutSeconds: timeout [
	sendTimeoutSeconds := timeout
]

{ #category : #accessing }
OCNConversationTcpSocket >> state [
	self refreshState.
	^super state
]

{ #category : #waiting }
OCNConversationTcpSocket >> waitForDataIfTimeout: timeoutBlock [
	self networkLibrary waitForDataOn: self socketId for: self receiveTimeOutSeconds onTimedOut: timeoutBlock
]

{ #category : #'backward compatibility' }
OCNConversationTcpSocket >> waitForSendDoneFor: timeoutSeconds [
	^ self networkLibrary waitForSendDoneOn: socketId for: timeoutSeconds
]
