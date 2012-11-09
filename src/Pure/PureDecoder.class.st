Class {
	#name : #PureDecoder,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'Pure-Kernel'
}

{ #category : #'as yet unclassified' }
PureDecoder class >> for: aStream [
	^ self new stream: aStream ; yourself .
]

{ #category : #'as yet unclassified' }
PureDecoder class >> forArray: anArray [
	^ self new stream: (ReadStream on: anArray) ; yourself .
]

{ #category : #'as yet unclassified' }
PureDecoder >> hasData [
	^ stream atEnd not.
]

{ #category : #'as yet unclassified' }
PureDecoder >> nextEncodedByte [
	^ stream next. 
	
]

{ #category : #'as yet unclassified' }
PureDecoder >> nextEncodedBytes: anAmountOfBytes [
	^ stream next: anAmountOfBytes. 
	
]

{ #category : #'as yet unclassified' }
PureDecoder >> nextEncodedFloat32 [
	^ (stream next:4) floatAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PureDecoder >> nextEncodedFloat64 [
	^ (stream next:8) doubleAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PureDecoder >> nextEncodedInt16 [
	^(stream next:2) shortAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PureDecoder >> nextEncodedInt32 [
	^  (stream next: 4) longAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PureDecoder >> nextEncodedUInt16 [
	^ ( stream next:2 ) unsignedShortAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PureDecoder >> stream: aStream [
	stream := aStream.
]

{ #category : #'as yet unclassified' }
PureDecoder >> upToEnd [ 

	^ stream upToEnd.
]
