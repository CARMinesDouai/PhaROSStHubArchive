Class {
	#name : #PNGDecoder,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'instance creation' }
PNGDecoder class >> newOn: aStream [
	^self new 
		stream: aStream;
		yourself
]

{ #category : #testing }
PNGDecoder >> hasData [
	^ self stream atEnd not
]

{ #category : #decoder }
PNGDecoder >> nextEncodedByte [
	^ self stream next. 
	
]

{ #category : #decoder }
PNGDecoder >> nextEncodedBytes: anAmountOfBytes [
	^ self stream next: anAmountOfBytes. 
	
]

{ #category : #decoder }
PNGDecoder >> nextEncodedFloat32 [
	^ (self stream next:4) floatAt: 1 bigEndian: false.
]

{ #category : #decoder }
PNGDecoder >> nextEncodedFloat64 [
	^ (self stream next:8) doubleAt: 1 bigEndian: false.
]

{ #category : #decoder }
PNGDecoder >> nextEncodedInt16 [
	^(self stream next:2) shortAt: 1 bigEndian: false.
]

{ #category : #decoder }
PNGDecoder >> nextEncodedUInt16 [
	^ ( self stream next:2 ) unsignedShortAt: 1 bigEndian: false.
]

{ #category : #decoder }
PNGDecoder >> nextEncodedUInt32 [

	^  (self stream next: 4) unsignedLongAt: 1 bigEndian: false.
]

{ #category : #decoder }
PNGDecoder >> nextEncodedUInt64 [

	^  (self stream next: 8) unsignedLongAt: 1 bigEndian: false.
]

{ #category : #accessing }
PNGDecoder >> stream [
	^ stream
]

{ #category : #accessing }
PNGDecoder >> stream: anObject [
	stream := anObject
]
