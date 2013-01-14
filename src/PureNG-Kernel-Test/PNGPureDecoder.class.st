Class {
	#name : #PNGPureDecoder,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'as yet unclassified' }
PNGPureDecoder class >> for: aStream [
	^ self new stream: aStream ; yourself .
]

{ #category : #'as yet unclassified' }
PNGPureDecoder class >> forArray: anArray [
	^ self new stream: (ReadStream on: anArray) ; yourself .
]

{ #category : #'as yet unclassified' }
PNGPureDecoder >> hasData [
	^ stream atEnd not.
]

{ #category : #'as yet unclassified' }
PNGPureDecoder >> nextEncodedByte [
	^ stream next. 
	
]

{ #category : #'as yet unclassified' }
PNGPureDecoder >> nextEncodedBytes: anAmountOfBytes [
	^ stream next: anAmountOfBytes. 
	
]

{ #category : #'as yet unclassified' }
PNGPureDecoder >> nextEncodedFloat32 [
	^ (stream next:4) floatAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PNGPureDecoder >> nextEncodedFloat64 [
	^ (stream next:8) doubleAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PNGPureDecoder >> nextEncodedInt16 [
	^(stream next:2) shortAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PNGPureDecoder >> nextEncodedInt32 [
	^  (stream next: 4) longAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PNGPureDecoder >> nextEncodedUInt16 [
	^ ( stream next:2 ) unsignedShortAt: 1 bigEndian: false.
]

{ #category : #decoder }
PNGPureDecoder >> nextEncodedUint32 [

	^  (stream next: 4) unsignedLongAt: 1 bigEndian: false.
]

{ #category : #decoder }
PNGPureDecoder >> nextEncodedUint64 [

	^  (stream next: 8) unsignedLongAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PNGPureDecoder >> stream: aStream [
	stream := aStream.
]

{ #category : #'as yet unclassified' }
PNGPureDecoder >> upToEnd [ 

	^ stream upToEnd.
]
