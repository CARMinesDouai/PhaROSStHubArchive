Class {
	#name : #PrROSPacket,
	#superclass : #PhaROSPacket,
	#category : #PhaRosRelay
}

{ #category : #'instance creation' }
PrROSPacket class >> type: aType [
	^self new
		type: aType;
		yourself
]

{ #category : #marshalling }
PrROSPacket >> dump [
	| anEncoder stream dataSize |
	dataSize := value data size.
	stream := WriteStream on: (ByteArray new:  dataSize + 4).
	anEncoder  := PhaROSEncoder on: stream.
	self encodePacketSize: dataSize into: anEncoder.	
	stream nextPutAll: value data.
	^ stream contents.
]

{ #category : #'initialize-release' }
PrROSPacket >> initialize [
	super initialize.
	value := PrDataArray new
]

{ #category : #marshalling }
PrROSPacket >> loadStream: aStream [ 
	| aDecoder  size |

	aDecoder := PhaROSDecoder on: aStream .

	size := self decodePacketSizeFrom: aDecoder.
 	(type isAPossibleSize: size ) ifFalse: [
		PhaROSUnexpextedValue signal:' Unexpected Value'.	
	].
	size > 20000000 ifTrue: [
		"too long, maybe is a problem in buffer. "	
		aStream resetBuffers.
		self error: 'Warning. trying to load ', size asString, ' bytes'.
	].
	value := aDecoder dataByteArray: size.


]

{ #category : #accessing }
PrROSPacket >> value: anObject [
	self shouldNotImplement 
]
