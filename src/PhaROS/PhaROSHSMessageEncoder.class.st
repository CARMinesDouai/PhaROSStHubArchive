Class {
	#name : #PhaROSHSMessageEncoder,
	#superclass : #Object,
	#instVars : [
		'tcpmessage'
	],
	#category : #'PhaROS-Network-Tcp'
}

{ #category : #encoding }
PhaROSHSMessageEncoder class >> encode: aTcpMessage [
	^self new encode: aTcpMessage.
]

{ #category : #encoding }
PhaROSHSMessageEncoder class >> encodeHeader: aTcpMessageHeader [
	^self new encodeHeader: aTcpMessageHeader.
]

{ #category : #'encoding-private' }
PhaROSHSMessageEncoder >> byteArrayForSizeOf: aCollection [
	|encodedSize sizeBytes|
	encodedSize := #[0 0 0 0].
	aCollection size asRoStByteArray reversed keysAndValuesDo: [:index :byte|
		encodedSize at: index put: byte
	].
	^encodedSize 
	
]

{ #category : #encoding }
PhaROSHSMessageEncoder >> encode: aTcpHandshakeMessage [
	| byteStream bodyBytes handshakeMessageBytes  |
		
	byteStream := ByteArray new writeStream.
	handshakeMessageBytes := self encodeMessage: aTcpHandshakeMessage.

	
	byteStream nextPutAll: (self byteArrayForSizeOf: handshakeMessageBytes ).
	byteStream nextPutAll: handshakeMessageBytes .	

	
	^ byteStream contents.
]

{ #category : #encoding }
PhaROSHSMessageEncoder >> encodeMessage: aTcpHandshakeMessage [
	| byteStream |
	
	aTcpHandshakeMessage verify.
	byteStream := ByteArray new writeStream.
	
	aTcpHandshakeMessage attributesDo:  [
		: association |
		self putSizeAndBytesOf: association into: byteStream
	].

	^byteStream contents 
	
]

{ #category : #'encoding-private' }
PhaROSHSMessageEncoder >> putSizeAndBytesOf: anObject into: byteStream [
		|bytes|
		bytes := anObject asRoStByteArray.
		byteStream nextPutAll: (self byteArrayForSizeOf: bytes).
		byteStream nextPutAll: bytes

]
