Class {
	#name : #PNGEncodedResponse,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'as yet unclassified' }
PNGEncodedResponse class >> for: aStream [
	^ self new stream: aStream ; yourself .
]

{ #category : #'as yet unclassified' }
PNGEncodedResponse class >> forArray: anArray [
	^ self new stream: (ReadStream on: anArray) ; yourself .
]

{ #category : #'as yet unclassified' }
PNGEncodedResponse >> hasData [
	^ stream atEnd not.
]

{ #category : #'as yet unclassified' }
PNGEncodedResponse >> nextEncodedByte [
	^ stream next. 
	
]

{ #category : #'as yet unclassified' }
PNGEncodedResponse >> nextEncodedBytes: anAmountOfBytes [
	^ stream next: anAmountOfBytes. 
	
]

{ #category : #'as yet unclassified' }
PNGEncodedResponse >> nextEncodedFloat32 [
	^ (stream next:4) floatAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PNGEncodedResponse >> nextEncodedFloat64 [
	^ (stream next:8) doubleAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PNGEncodedResponse >> nextEncodedInt16 [
	^(stream next:2) shortAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PNGEncodedResponse >> nextEncodedInt32 [
	^  (stream next: 4) longAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PNGEncodedResponse >> nextEncodedUInt16 [
	^ ( stream next:2 ) unsignedShortAt: 1 bigEndian: false.
]

{ #category : #decoder }
PNGEncodedResponse >> nextEncodedUint32 [

	^  (stream next: 4) unsignedLongAt: 1 bigEndian: false.
]

{ #category : #decoder }
PNGEncodedResponse >> nextEncodedUint64 [

	^  (stream next: 8) unsignedLongAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PNGEncodedResponse >> stream: aStream [
	stream := aStream.
]

{ #category : #'as yet unclassified' }
PNGEncodedResponse >> upToEnd [ 

	^ stream upToEnd.
]
