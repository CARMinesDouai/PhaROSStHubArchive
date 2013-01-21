Extension { #name : #Socket }

{ #category : #'*PureNoLog' }
Socket >> receiveUDPDataInto: aStringOrByteArray withTimeOut: aTimeOut [
	"Receive UDP data into the given buffer and return the number of bytes received. Note the given buffer may be only partially filled by the received data. What is returned is an array, the first element is the bytes read, the second the sending bytearray address, the third the senders port, the fourth, true if more of the datagram awaits reading"
	
	self waitForDataFor: aTimeOut.
      self dataAvailable ifFalse: [ ^{ 0 .0 .0} ].
	^ self primSocket: socketHandle
		receiveUDPDataInto: aStringOrByteArray
		startingAt: 1
		count: aStringOrByteArray size

]

{ #category : #'*PureNoLog' }
Socket >> receiveWithTimeOutUDPDataInto: aStringOrByteArray [ 
	^ self receiveUDPDataInto: aStringOrByteArray withTimeOut: Socket standardTimeout.
]

{ #category : #'*PureNoLog' }
Socket class >> standardTimeout [

	^ 5

]
