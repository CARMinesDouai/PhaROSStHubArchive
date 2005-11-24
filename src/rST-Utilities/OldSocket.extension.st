Extension { #name : #OldSocket }

{ #category : #'*rST-fixes-override' }
OldSocket >> accept [
	"Accept a connection from the receiver socket.
	Return a new socket that is connected to the client"
	^OldSocket acceptFrom: self.
]

{ #category : #'*rST-fixes-override' }
OldSocket >> closeAndDestroy: timeoutSeconds [
	"First, try to close this connection gracefully. If the close attempt fails or times out, abort the connection. In either case, destroy the socket. Do nothing if the socket has already been destroyed (i.e., if its socketHandle is nil)."

	socketHandle = nil
		ifFalse: [
			self isConnected ifTrue: [
				self close.  "close this end"
				(self waitForDisconnectionUntil: (OldSocket deadlineSecs: timeoutSeconds))
					ifFalse: [
						"if the other end doesn't close soon, just abort the connection"
						self primSocketAbortConnection: socketHandle]].
			self destroy].

]

{ #category : #'*rST-fixes-override' }
OldSocket classSide >> ensureNetworkConnected [
	"Try to ensure that an intermittent network connection, such as a dialup or ISDN line, is actually connected. This is necessary to make sure a server is visible in order to accept an incoming connection."
	"Socket ensureNetworkConnected"

	OldSocket initializeNetwork.
	Utilities
		informUser: 'Contacting domain name server...'
		during: [
			NetNameResolver
				addressForName: 'bogusNameToForceDNSToBeConsulted.org'
				timeout: 30].

]

{ #category : #'*rST-fixes-override' }
OldSocket >> getData [
	"Get some data"

	| buf bytesRead |
	(self waitForDataUntil: OldSocket standardDeadline) ifFalse: [self error: 'getData timeout'].
	buf := String new: 4000.
	bytesRead := self primSocket: socketHandle receiveDataInto: buf startingAt: 1 count: buf size.
	^ buf copyFrom: 1 to: bytesRead
]

{ #category : #'*rST-sending-receiving objects' }
OldSocket >> getObject [
	"gets a serialized object from this socket"
	| encoded object |
	encoded _ String new writeStream.
	[encoded size isZero]
		whileTrue: [encoded nextPutAll: self getData].
	[self isConnected
		and: [self dataAvailable]]
		whileTrue: [encoded nextPutAll: self getData].
	object _ ReferenceStream unStream: encoded contents.
	^ object
]

{ #category : #'*rST-fixes-override' }
OldSocket >> getResponseNoLF [
	"Get the response to the last command."

	| buf response bytesRead c lf |
	(self waitForDataUntil: (OldSocket deadlineSecs: 20)) ifFalse: [
		self error: 'getResponse timeout'].
	lf := Character lf.
	buf := String new: 1000.
	response := WriteStream on: ''.
	[self dataAvailable] whileTrue: [
		bytesRead := self primSocket: socketHandle receiveDataInto: buf startingAt: 1 count: buf size.
		1 to: bytesRead do: [ :i |
			(c := buf at: i) ~= lf ifTrue: [response nextPut: c]]].

	^ response contents

]

{ #category : #'*rST-fixes-override' }
OldSocket >> localAddress [
	self waitForConnectionUntil: OldSocket standardDeadline.
	self isConnected ifFalse: [^ByteArray new: 4].
	^ self primSocketLocalAddress: socketHandle

]

{ #category : #'*rST-fixes-override' }
OldSocket >> localPort [
	self waitForConnectionUntil: OldSocket standardDeadline.
	self isConnected ifFalse: [^0 ].
	^ self primSocketLocalPort: socketHandle

]

{ #category : #'*rST-fixes-override' }
OldSocket >> readInto: aStringOrByteArray startingAt: aNumber [
	"Read data into the given buffer starting at the given index and return the number of bytes received. Note the given buffer may be only partially filled by the received data."

	(self waitForDataUntil: OldSocket standardDeadline) ifFalse: [self error: 'receive timeout'].
	^ self primSocket: socketHandle
		receiveDataInto: aStringOrByteArray
		startingAt: aNumber
		count: aStringOrByteArray size - aNumber + 1

]

{ #category : #'*rST-fixes-override' }
OldSocket >> sendData: aStringOrByteArray [
	"Send all of the data in the given array, even if it requires multiple calls to send it all. Return the number of bytes sent."

	"An experimental version use on slow lines: Longer timeout and smaller writes to try to avoid spurious timeouts."

	| bytesSent bytesToSend count |
	bytesToSend := aStringOrByteArray size.
	bytesSent := 0.
	[bytesSent < bytesToSend] whileTrue: [
		(self waitForSendDoneUntil: (OldSocket deadlineSecs: 60))
			ifFalse: [self error: 'send data timeout; data not sent'].
		count := self primSocket: socketHandle
			sendData: aStringOrByteArray
			startIndex: bytesSent + 1
			count: (bytesToSend - bytesSent min: 5000).
		bytesSent := bytesSent + count].

	^ bytesSent

]

{ #category : #'*rST-sending-receiving objects' }
OldSocket >> sendObject: anObject [ 
	"sends a serialized object to this socket"
	| encoded |
	encoded _ ReferenceStream streamedRepresentationOf: anObject.
	self sendData: encoded
]

{ #category : #'*rST-fixes-override' }
OldSocket >> sendSomeData: aStringOrByteArray startIndex: startIndex count: count [
	"Send up to count bytes of the given data starting at the given index. Answer the number of bytes actually sent."
	"Note: This operation may have to be repeated multiple times to send a large amount of data."

	| bytesSent |
	(self waitForSendDoneUntil: (OldSocket deadlineSecs: 20))
		ifTrue: [
			bytesSent := self primSocket: socketHandle
				sendData: aStringOrByteArray
				startIndex: startIndex
				count: count]
		ifFalse: [self error: 'send data timeout; data not sent'].
	^ bytesSent

]

{ #category : #'*rST-fixes-override' }
OldSocket >> sendUDPData: aStringOrByteArray toHost: hostAddress port: portNumber [
	"Send a UDP packet containing the given data to the specified host/port."
	| bytesToSend bytesSent count |

	bytesToSend := aStringOrByteArray size.
	bytesSent := 0.
	[bytesSent < bytesToSend] whileTrue: [
		(self waitForSendDoneUntil: (OldSocket deadlineSecs: 20))
			ifFalse: [self error: 'send data timeout; data not sent'].
		count := self primSocket: socketHandle
			sendUDPData: aStringOrByteArray
			toHost: hostAddress
			port: portNumber
			startIndex: bytesSent + 1
			count: bytesToSend - bytesSent.
		bytesSent := bytesSent + count].

	^ bytesSent

]
