Class {
	#name : #PhaROSHandShakeMessageEncoder,
	#superclass : #Object,
	#traits : 'TLogger',
	#classTraits : 'TLogger classTrait',
	#instVars : [
		'tcpmessage'
	],
	#category : #'PhaROS-Kernel-Tcp'
}

{ #category : #encoding }
PhaROSHandShakeMessageEncoder class >> encode: aTcpMessage [
	^self new encode: aTcpMessage.
]

{ #category : #encoding }
PhaROSHandShakeMessageEncoder class >> encodeHeader: aTcpMessageHeader [
	^self new encodeHeader: aTcpMessageHeader.
]

{ #category : #'encoding-private' }
PhaROSHandShakeMessageEncoder >> byteArrayForSizeOf: aCollection [
	|encodedSize sizeBytes|
	encodedSize := #[0 0 0 0].
	aCollection size asRoStByteArray reversed keysAndValuesDo: [:index :byte|
		encodedSize at: index put: byte
	].
	^encodedSize 
	
]

{ #category : #encoding }
PhaROSHandShakeMessageEncoder >> encode: aTcpHandshakeMessage [
	| byteStream bodyBytes handshakeMessageBytes  |
		
	byteStream := ByteArray new writeStream.
	handshakeMessageBytes := self encodeMessage: aTcpHandshakeMessage.

	
	byteStream nextPutAll: (self byteArrayForSizeOf: handshakeMessageBytes ).
	byteStream nextPutAll: handshakeMessageBytes .	

	
	^ byteStream contents.
]

{ #category : #encoding }
PhaROSHandShakeMessageEncoder >> encodeMessage: aTcpHandshakeMessage [
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
PhaROSHandShakeMessageEncoder >> putSizeAndBytesOf: anObject into: byteStream [
		|bytes|
		bytes := anObject asRoStByteArray.
		byteStream nextPutAll: (self byteArrayForSizeOf: bytes).
		byteStream nextPutAll: bytes

]
