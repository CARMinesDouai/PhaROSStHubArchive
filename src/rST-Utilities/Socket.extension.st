Extension { #name : #Socket }

{ #category : #'*rST' }
Socket >> getData [
	"Get some data"

	| buf bytesRead |
	[self waitForDataFor: 15] 
		on: ConnectionTimedOut
		do: [:ex | self error: 'getData timeout'].
	buf := String new: 4000.
	bytesRead := self 
		primSocket: socketHandle 
		receiveDataInto: buf 
		startingAt: 1 
		count: buf size.
	^ buf copyFrom: 1 to: bytesRead
]

{ #category : #'*rST' }
Socket >> getObject [
	"gets a serialized object from this socket"
	| encoded object |
	encoded := String new writeStream.
	[encoded isEmpty]
		whileTrue: [encoded nextPutAll: (self receiveDataTimeout: 15)].
	[self isConnected
		and: [self dataAvailable]]
		whileTrue: [encoded nextPutAll: (self receiveDataTimeout: 15)].
	object := ReferenceStream unStream: encoded contents.
	^ object
]

{ #category : #'*rST' }
Socket >> sendData: aStringOrByteArray [
	"Send all of the data in the given array, even if it requires multiple calls to send it all. Return the number of bytes sent."

	"An experimental version use on slow lines: Longer timeout and smaller writes to try to avoid spurious timeouts."

	| bytesSent bytesToSend count |
	bytesToSend := aStringOrByteArray size.
	bytesSent := 0.
	[bytesSent < bytesToSend] whileTrue: [
		(self waitForSendDoneFor: 60)
			ifFalse: [self error: 'send data timeout; data not sent'].
		count := self primSocket: socketHandle
			sendData: aStringOrByteArray
			startIndex: bytesSent + 1
			count: (bytesToSend - bytesSent min: 5000).
		bytesSent := bytesSent + count].

	^ bytesSent
]

{ #category : #'*rST' }
Socket >> sendObject: anObject [ 
	"sends a serialized object to this socket"
	| encoded |
	encoded := ReferenceStream streamedRepresentationOf: anObject.
	self sendData: encoded
]
