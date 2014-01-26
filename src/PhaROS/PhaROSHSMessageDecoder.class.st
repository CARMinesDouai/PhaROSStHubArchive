Class {
	#name : #PhaROSHSMessageDecoder,
	#superclass : #Object,
	#instVars : [
		'tcpmessage'
	],
	#category : #'PhaROS-Network-Tcp-Encoding'
}

{ #category : #decoding }
PhaROSHSMessageDecoder class >> decode: aStream using: aMessage [
	^ self new 	tcpmessage: aMessage; 
				decode: aStream.


]

{ #category : #decoding }
PhaROSHSMessageDecoder class >> decodePublisherMessage: aByteArray [ 

	^ self decode: aByteArray using: PhaROSHSMessageHeader newPublisher.
]

{ #category : #decoding }
PhaROSHSMessageDecoder class >> decodeServiceClientMessage: aStream [ 
	^ self decode: aStream using: PhaROSHSMessageHeader newServiceClient.
]

{ #category : #decoding }
PhaROSHSMessageDecoder class >> decodeServiceMessage: aStream [
	| message |
	message :=  self decode: aStream using: PhaROSHSMessageHeader newService.
	self assert: (message header includesKey: #error) not.
	^ message
]

{ #category : #decoding }
PhaROSHSMessageDecoder class >> decodeSubscriberMessage: aStream [ 

	^ self decode: aStream using: PhaROSHSMessageHeader newSubscriber.
]

{ #category : #decoding }
PhaROSHSMessageDecoder class >> decodeUnknownMessageHeader: aStream [ 

	^ self decode: aStream using: PhaROSHSMessageHeader genericHeader.
]

{ #category : #decoding }
PhaROSHSMessageDecoder >> addTo: dataStream bodyPartAt: dataIndex from: bytes [
	dataStream nextPut: (self stringFrom: bytes)
]

{ #category : #'type-formatting' }
PhaROSHSMessageDecoder >> booleanFrom: bytes [
	^bytes first ~= 0
]

{ #category : #'header-loading' }
PhaROSHSMessageDecoder >> dataSizeFrom: byteStream [
	^self intFrom: (byteStream next: self sizeBytesCount)
]

{ #category : #decoding }
PhaROSHSMessageDecoder >> decode: byteStream [
	|  headerSize |
	
	[" Header parsing "
		headerSize := (self dataSizeFrom: byteStream).
		self initHeaderFrom: (byteStream next: headerSize).
	] on: Error do: [ :e | 
		PhaROSHeaderVerifier new verify: tcpmessage. 
	].

	(self header includesKey: #error) ifTrue: [  self error: (self header at: #error)].
	^tcpmessage.
]

{ #category : #accessing }
PhaROSHSMessageDecoder >> header [ 
	^ tcpmessage header.
]

{ #category : #'header-loading' }
PhaROSHSMessageDecoder >> headerFieldSeparator [
	^61 "$=  asInteger"
]

{ #category : #'header-loading' }
PhaROSHSMessageDecoder >> initFieldFrom: bytes [
	| separatorIndex fieldNameBytes fieldName fieldValueBytes fieldValue |
	
	separatorIndex := bytes indexOf: self headerFieldSeparator.
	fieldNameBytes := bytes copyFrom: 1 to: separatorIndex - 1.
	fieldName := self stringFrom: fieldNameBytes.
	fieldValueBytes := bytes copyFrom: separatorIndex + 1 to: bytes size.
	fieldValue := self valueFrom: fieldValueBytes forField: fieldName.
	self header at: fieldName put: fieldValue.
]

{ #category : #'header-loading' }
PhaROSHSMessageDecoder >> initHeaderFrom: byteArray [ 
	| byteStream |
	byteStream := byteArray readStream.
	[byteStream atEnd] whileFalse: [
		|fieldSize|
		fieldSize := self dataSizeFrom: byteStream.
		self initFieldFrom: (byteStream next: fieldSize).
	]

]

{ #category : #'type-formatting' }
PhaROSHSMessageDecoder >> intFrom: bytes [
	^ bytes longAt: 1 bigEndian: false.
]

{ #category : #constants }
PhaROSHSMessageDecoder >> sizeBytesCount [
	^4
]

{ #category : #'type-formatting' }
PhaROSHSMessageDecoder >> stringFrom: bytes [
	^bytes asString
]

{ #category : #accessing }
PhaROSHSMessageDecoder >> tcpmessage: aMessage [
	tcpmessage := aMessage. 
]

{ #category : #'header-loading' }
PhaROSHSMessageDecoder >> valueFrom: fieldValueBytes forField: fieldName [
	fieldName = 'latching' ifTrue: [^self booleanFrom: fieldValueBytes].
	^self stringFrom: fieldValueBytes
]
