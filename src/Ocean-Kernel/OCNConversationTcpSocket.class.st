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
		'connectionTimeoutSeconds'
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

{ #category : #'socket_api' }
OCNConversationTcpSocket >> connectNonBlockingTo: hostAddress port: port [
	"Initiate a connection to the given port at the given host address. This operation will return immediately; follow it with waitForConnectionUntil: to wait until the connection is established."

	|serverAddress|
	serverAddress := OCNIpv4Address new 
		ip: hostAddress; 
		port: port;
		yourself.

	(self isClean | self isBound ) ifFalse:  [ 
		OCNSocketOperationForbiddenError signal: self state asString capitalized, ' socket can not be connected' ].
	[
		self networkLibrary connectNonBlocking: self toServerWithIpv4Address: serverAddress.
	] on: OCNSocketOperationFailureError do: [:ex|
		self destroy.
		ex pass.
	].
	self state:  self connectedStateSymbol
]

{ #category : #'socket_api' }
OCNConversationTcpSocket >> connectTo: hostAddress port: port [
	"Initiate a connection to the given port at the given host address. This operation will return immediately; follow it with waitForConnectionUntil: to wait until the connection is established."

	|serverAddress|
	serverAddress := OCNIpv4Address new 
		ip: hostAddress; 
		port: port;
		yourself.

	(self isClean | self isBound ) ifFalse:  [ 
		OCNSocketOperationForbiddenError signal: self state asString capitalized, ' socket can not be connected' ].
	[
		self networkLibrary connect: self toServerWithIpv4Address: serverAddress.
	] on: OCNSocketOperationFailureError do: [:ex|
		self destroy.
		ex pass.
	].
	self state:  self connectedStateSymbol
]

{ #category : #'socket_api' }
OCNConversationTcpSocket >> connectTo: hostAddress port: port waitForConnectionFor: timeout [ 
	"Initiate a connection to the given port at the given host address. This operation will return immediately; follow it with waitForConnectionUntil: to wait until the connection is established."

	|serverAddress|
	serverAddress := OCNIpv4Address new 
		ip: hostAddress; 
		port: port;
		yourself.

	(self isClean | self isBound ) ifFalse:  [ 
		OCNSocketOperationForbiddenError signal: self state asString capitalized, ' socket can not be connected' ].
	[
		self networkLibrary connect: self toServerWithIpv4Address: serverAddress timeout: timeout.
	] on: OCNSocketOperationFailureError do: [:ex|
		self destroy.
		ex pass.
	].
	self state:  self connectedStateSymbol
]

{ #category : #'socket_api' }
OCNConversationTcpSocket >> connectToHostNamed: hostName port: port [
	"Initiate a connection to the given port at the given host address. This operation will return immediately; follow it with waitForConnectionUntil: to wait until the connection is established."

	|serverAddress|
	serverAddress := OCNNetNameResolver ipv4AddressForName: hostName.
	serverAddress port: port.

	(self isClean | self isBound ) ifFalse:  [ 
		OCNSocketOperationForbiddenError signal: self state asString capitalized, ' socket can not be connected' ].
	[
		self networkLibrary connect: self toServerWithIpv4Address: serverAddress.
	] on: OCNSocketOperationFailureError do: [:ex|
		self destroy.
		ex pass.
	].
	self state:  self connectedStateSymbol
]

{ #category : #connection }
OCNConversationTcpSocket >> connectToServer: serverAddress [

	(self isClean | self isBound ) ifFalse:  [ 
		OCNSocketOperationForbiddenError signal: self state asString capitalized, ' socket can not be connected' ].
	[
		self networkLibrary connect: self toServerWithIpv4Address: serverAddress.
	] on: OCNSocketOperationFailureError do: [:ex|
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

{ #category : #'socket_api' }
OCNConversationTcpSocket >> discardReceivedData [
	"Discard any data received up until now, and return the number of bytes discarded."

	| buf totalBytesDiscarded |
	buf := String new: 10000.
	totalBytesDiscarded := 0.
	[self isConnected] whileTrue: [
		totalBytesDiscarded :=
			totalBytesDiscarded + (self receiveDataInto: buf)].
	^ totalBytesDiscarded

]

{ #category : #'socket_api' }
OCNConversationTcpSocket >> disconnect [

	self networkLibrary disconnect: self
]

{ #category : #'initialize-release' }
OCNConversationTcpSocket >> initialize [ 
	super initialize.
	self connectionTimeoutSeconds: 3
]

{ #category : #'state testing' }
OCNConversationTcpSocket >> isConnected [ 
	^self state = self connectedStateSymbol
]

{ #category : #communicating }
OCNConversationTcpSocket >> isDataAvailable [
	^self isConnected and: [self networkLibrary isDataAvailableFrom: self]
]

{ #category : #communicating }
OCNConversationTcpSocket >> receive [
	self isConnected ifFalse: [OCNSocketOperationForbiddenError signal: 'Socket should be connected before receiving'].
	^self networkLibrary tcpReceiveFrom: self	
]

{ #category : #'socket_api' }
OCNConversationTcpSocket >> receiveData [
	| buffer bytesRead |
	buffer := String new: 2000.
	bytesRead := self receiveDataInto: buffer.
	^buffer copyFrom: 1 to: bytesRead
]

{ #category : #'socket_api' }
OCNConversationTcpSocket >> receiveDataInto: aStringOrByteArray [
	"Receive data into the given buffer and return the number of bytes received. 
	Note the given buffer may be only partially filled by the received data.
	Waits for data once.
	Either returns data or signals a time out or connection close."

	^self receiveDataInto: aStringOrByteArray startingAt: 1
]

{ #category : #'socket_api' }
OCNConversationTcpSocket >> receiveDataInto: aStringOrByteArray startingAt: aNumber [
	
	| bytesRead closed |
	bytesRead := 0.
	closed := false.
	self isConnected ifFalse: [OCNSocketOperationForbiddenError signal: 'Socket should be connected before receiving'].	
	[closed not and: [bytesRead = 0]]
		whileTrue: [
			self waitForDataIfClosed: [closed := true].
			bytesRead := self networkLibrary tcpReceiveFrom: self	into: aStringOrByteArray startingAt: aNumber].
	^bytesRead
]

{ #category : #'socket_api' }
OCNConversationTcpSocket >> receiveDataSignallingClosedInto: aStringOrByteArray startingAt: aNumber [
	
	| bytesRead closed |
	self flag:'TODO: inform if closed'.
	bytesRead := 0.
	closed := false.
	self isConnected ifFalse: [OCNSocketOperationForbiddenError signal: 'Socket should be connected before receiving'].	
	bytesRead := 0.
	[bytesRead = 0]
		whileTrue: [
			self waitForData.
			bytesRead := self networkLibrary tcpReceiveFrom: self	into: aStringOrByteArray startingAt: aNumber].
	^bytesRead
]

{ #category : #'socket_api' }
OCNConversationTcpSocket >> receiveDataSignallingTimeout: timeout into: aStringOrByteArray startingAt: aNumber [
	| bytesRead closed |
	self flag:'TODO: inform if timeout'.
	bytesRead := 0.
	closed := false.
	self isConnected ifFalse: [OCNSocketOperationForbiddenError signal: 'Socket should be connected before receiving'].	
	
	self waitForDataFor: timeout.
	bytesRead := self networkLibrary tcpReceiveFrom: self	into: aStringOrByteArray startingAt: aNumber.
	^bytesRead
]

{ #category : #'socket_api' }
OCNConversationTcpSocket >> receiveDataTimeout: timeout into: aStringOrByteArray startingAt: aNumber [
	self flag:'TODO: inform if timeout'.
	self isConnected ifFalse: [OCNSocketOperationForbiddenError signal: 'Socket should be connected before receiving'].
	self waitForDataFor: timeout ifClosed: [] ifTimedOut: [].
	^self networkLibrary tcpReceiveFrom: self	into: aStringOrByteArray startingAt: aNumber
]

{ #category : #'socket_api' }
OCNConversationTcpSocket >> receiveDataWithTimeoutInto: aStringOrByteArray [
	self flag:'TODO: inform if timeout'.
	self isConnected ifFalse: [OCNSocketOperationForbiddenError signal: 'Socket should be connected before receiving'].
	^self receiveDataWithTimeoutInto: aStringOrByteArray startingAt: 1
]

{ #category : #'socket_api' }
OCNConversationTcpSocket >> receiveDataWithTimeoutInto: aStringOrByteArray startingAt: aNumber [
	self flag:'TODO: inform if timeout'.
	self isConnected ifFalse: [OCNSocketOperationForbiddenError signal: 'Socket should be connected before receiving'].
	^self receiveDataTimeout: Socket standardTimeout into: aStringOrByteArray startingAt: aNumber 

]

{ #category : #'socket_api' }
OCNConversationTcpSocket >> receiveSomeDataInto: aStringOrByteArray startingAt: aNumber [
	self isConnected ifFalse: [OCNSocketOperationForbiddenError signal: 'Socket should be connected before receiving'].
	^self networkLibrary tcpReceiveFrom: self	into: aStringOrByteArray startingAt: aNumber
]

{ #category : #accessing }
OCNConversationTcpSocket >> refreshState [
	state = self connectedStateSymbol ifFalse: [^self].
	(self networkLibrary isSocketConnected: self) ifFalse: [self basicDestroy]

]

{ #category : #communicating }
OCNConversationTcpSocket >> send: aByteStringOrByteArray [
	| totalToSendCount totalSentCount  indexOfFirstByteToSend pendingBytesCount toSendCount sentCount indexOfLastByteToSend dataToSend|
	self isConnected
		ifFalse: [ OCNSocketOperationForbiddenError signal: 'Socket should be connected before sending' ].
	totalToSendCount := aByteStringOrByteArray size.
	totalSentCount := 0.
	[totalSentCount < totalToSendCount] whileTrue: [
		indexOfFirstByteToSend := totalSentCount + 1.
		pendingBytesCount := totalToSendCount - totalSentCount.
		toSendCount := self sendDataBufferSize min: pendingBytesCount.
		indexOfLastByteToSend := indexOfFirstByteToSend + toSendCount - 1. 
		dataToSend := aByteStringOrByteArray copyFrom: indexOfFirstByteToSend  to:  indexOfLastByteToSend.
		sentCount := self networkLibrary tcpSendData: dataToSend to: self.
		totalSentCount := sentCount + totalSentCount.
	].
	^totalSentCount  
]

{ #category : #'socket_api' }
OCNConversationTcpSocket >> send: aByteStringOrByteArray for: aTimeoutInSeconds [
	| totalToSendCount totalSentCount  indexOfFirstByteToSend pendingBytesCount toSendCount sentCount indexOfLastByteToSend dataToSend|
	self isConnected
		ifFalse: [ OCNSocketOperationForbiddenError signal: 'Socket should be connected before sending' ].
	totalToSendCount := aByteStringOrByteArray size.
	totalSentCount := 0.
	[totalSentCount < totalToSendCount] whileTrue: [
		indexOfFirstByteToSend := totalSentCount + 1.
		pendingBytesCount := totalToSendCount - totalSentCount.
		toSendCount := self sendDataBufferSize min: pendingBytesCount.
		indexOfLastByteToSend := indexOfFirstByteToSend + toSendCount - 1. 
		dataToSend := aByteStringOrByteArray copyFrom: indexOfFirstByteToSend  to:  indexOfLastByteToSend.
		sentCount := self networkLibrary tcpSendData: dataToSend to: self for: aTimeoutInSeconds.
		totalSentCount := sentCount + totalSentCount.
	].
	^totalSentCount  
]

{ #category : #'socket_api' }
OCNConversationTcpSocket >> sendCommand: commandString [
	"Send the given command as a single line followed by a <CR><LF> terminator."

	self send: commandString, String crlf.
]

{ #category : #'socket_api' }
OCNConversationTcpSocket >> sendData: aStringOrByteArray [

	^ self send: aStringOrByteArray
]

{ #category : #'socket_api' }
OCNConversationTcpSocket >> sendData: buffer count: n [
	"Send the amount of data from the given buffer"
	| sent |
	sent := 0.
	[sent < n] whileTrue:[
		sent := sent + (self sendSomeData: buffer startIndex: sent+1 count: (n-sent))].
]

{ #category : #'socket_api' }
OCNConversationTcpSocket >> sendSomeData: aStringOrByteArray startIndex: startIndex count: count [
	"Send up to count bytes of the given data starting at the given index. Answer the number of bytes actually sent."
	"Note: This operation may have to be repeated multiple times to send a large amount of data."

	^ self 
		sendSomeData: aStringOrByteArray 
		startIndex: startIndex 
		count: count 
		for: self sendTimeOutSeconds

]

{ #category : #'socket_api' }
OCNConversationTcpSocket >> sendSomeData: aStringOrByteArray startIndex: startIndex count: count for: aTimeoutInSeconds [
	"Send up to count bytes of the given data starting at the given index. Answer the number of bytes actually sent."
	"Note: This operation may have to be repeated multiple times to send a large amount of data."

	| bytesSent dataToSend |
	dataToSend := aStringOrByteArray copyFrom: startIndex  to:  startIndex+ count.
	^ self send: dataToSend for: aTimeoutInSeconds
]

{ #category : #'socket_api' }
OCNConversationTcpSocket >> sendStreamContents: stream [
	"Send the data in the stream. Close the stream.
	Usefull for directly sending contents of a file without reading into memory first."

	self sendStreamContents: stream checkBlock: [true]
]

{ #category : #'socket_api' }
OCNConversationTcpSocket >> sendStreamContents: stream checkBlock: checkBlock [
	"Send the data in the stream. Close the stream after you are done. After each block of data evaluate checkBlock and abort if it returns false.
	Usefull for directly sending contents of a file without reading into memory first."

	| chunkSize buffer |
	chunkSize := 5000.
	buffer := ByteArray new: chunkSize.
	stream binary.
	[[stream atEnd and: [checkBlock value]]
		whileFalse: [
			buffer := stream next: chunkSize into: buffer.
			self send: buffer]]
		ensure: [stream close]
]

{ #category : #accessing }
OCNConversationTcpSocket >> state [
	self refreshState.
	^super state
]
