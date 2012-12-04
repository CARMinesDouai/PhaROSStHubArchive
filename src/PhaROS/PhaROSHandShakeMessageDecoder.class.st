Class {
	#name : #PhaROSHandShakeMessageDecoder,
	#superclass : #Object,
	#traits : 'TLogger',
	#classTraits : 'TLogger classTrait',
	#instVars : [
		'header',
		'tcpmessage'
	],
	#category : #'PhaROS-Kernel-Tcp'
}

{ #category : #configuration }
PhaROSHandShakeMessageDecoder class >> configurationOfLog [
	<logConfiguration>
	^ [
	     :builder |
	     builder forClass: LoggedExampleCustomized 
			     useLevel:#debug 
			     showingLogAs: ('%tag #%class >> %selector [%log]' asPatternFormatter) 
			     into: Transcript asLogWriter .
	].

]

{ #category : #decoding }
PhaROSHandShakeMessageDecoder class >> decode: aByteArray [ 

	^ self decode: aByteArray using: PhaROSHandShakeMessage newUnknownFormat.
]

{ #category : #decoding }
PhaROSHandShakeMessageDecoder class >> decode: aByteArray using: aMessage [
	^ self new 	tcpmessage: aMessage; 
				decode: aByteArray.


]

{ #category : #decoding }
PhaROSHandShakeMessageDecoder class >> decodePublisherMessage: aByteArray [ 

	^ self decode: aByteArray using: PhaROSHandShakeMessage newPublisher.
]

{ #category : #decoding }
PhaROSHandShakeMessageDecoder class >> decodeServiceClientMessage: aByteArray [ 
	^ self decode: aByteArray using: RoStHandShakeMessage newServiceClient.
]

{ #category : #decoding }
PhaROSHandShakeMessageDecoder class >> decodeServiceMessage: aByteArray [ 
	^ self decode: aByteArray using: PhaROSHandShakeMessage newService.
]

{ #category : #decoding }
PhaROSHandShakeMessageDecoder class >> decodeSubscriberMessage: aByteArray [ 

	^ self decode: (aByteArray asByteArray)using: PhaROSHandShakeMessage newSubscriber.
]

{ #category : #decoding }
PhaROSHandShakeMessageDecoder >> addTo: dataStream bodyPartAt: dataIndex from: bytes [
	dataStream nextPut: (self stringFrom: bytes)
]

{ #category : #'type-formatting' }
PhaROSHandShakeMessageDecoder >> booleanFrom: bytes [
	^bytes first ~= 0
]

{ #category : #'header-loading' }
PhaROSHandShakeMessageDecoder >> dataSizeFrom: byteStream [
	^self intFrom: (byteStream next: self sizeBytesCount)
]

{ #category : #decoding }
PhaROSHandShakeMessageDecoder >> decode: aByteArray [
	| byteStream headerSize bodySize |
	
	self debug: [ 'Decoding: ' , aByteArray asString ].
	" Header parsing "
	byteStream := aByteArray readStream.
	headerSize := self dataSizeFrom: byteStream.
	self initHeaderFrom: (byteStream next: headerSize).

	self debug: [ 'Message decoded as ', tcpmessage asString ].
	^tcpmessage.
]

{ #category : #accessing }
PhaROSHandShakeMessageDecoder >> header [ 
	^ tcpmessage header.
]

{ #category : #'header-loading' }
PhaROSHandShakeMessageDecoder >> headerFieldSeparator [
	^61 "$=  asInteger"
]

{ #category : #'body-loading' }
PhaROSHandShakeMessageDecoder >> initBodyFrom: bytes [
	| byteStream dataStream dataIndex |
	byteStream := bytes readStream.
	dataStream := Array new writeStream.
	dataIndex := 1.
	[byteStream atEnd] whileFalse: [
		|dataSize|
		dataSize := self dataSizeFrom: byteStream.
		self addTo: dataStream bodyPartAt: dataIndex from: (byteStream next: dataSize).
		dataIndex := dataIndex + 1
	].
	^ dataStream contents.

	
]

{ #category : #'header-loading' }
PhaROSHandShakeMessageDecoder >> initFieldFrom: bytes [
	| separatorIndex fieldNameBytes fieldName fieldValueBytes fieldValue |
	separatorIndex := bytes indexOf: self headerFieldSeparator.
	fieldNameBytes := bytes copyFrom: 1 to: separatorIndex - 1.
	fieldName := self stringFrom: fieldNameBytes.
	fieldValueBytes := bytes copyFrom: separatorIndex + 1 to: bytes size.
	fieldValue := self valueFrom: fieldValueBytes forField: fieldName.
	self header at: fieldName put: fieldValue
]

{ #category : #'header-loading' }
PhaROSHandShakeMessageDecoder >> initHeaderFrom: byteArray [ 
	| byteStream |
	byteStream := byteArray readStream.
	[byteStream atEnd] whileFalse: [
		|fieldSize|
		fieldSize := self dataSizeFrom: byteStream.
		self initFieldFrom: (byteStream next: fieldSize).
	]

]

{ #category : #'type-formatting' }
PhaROSHandShakeMessageDecoder >> intFrom: bytes [
	^ bytes longAt: 1 bigEndian: false.
]

{ #category : #constants }
PhaROSHandShakeMessageDecoder >> sizeBytesCount [
	^4
]

{ #category : #'type-formatting' }
PhaROSHandShakeMessageDecoder >> stringFrom: bytes [
	^bytes asString
]

{ #category : #accessing }
PhaROSHandShakeMessageDecoder >> tcpmessage: aMessage [
	tcpmessage := aMessage. 
]

{ #category : #'header-loading' }
PhaROSHandShakeMessageDecoder >> valueFrom: fieldValueBytes forField: fieldName [
	fieldName = 'latching' ifTrue: [^self booleanFrom: fieldValueBytes].
	^self stringFrom: fieldValueBytes
]
