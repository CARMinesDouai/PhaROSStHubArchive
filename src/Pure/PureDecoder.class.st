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
PureDecoder >> nexEncodedFloat32 [
	^ (ByteArray readHexFrom: (stream next:4) )floatAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PureDecoder >> nexEncodedFloat64 [
	^ (ByteArray readHexFrom: (stream next:8) ) doubleAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PureDecoder >> nexEncodedInt16 [
	^ (ByteArray readHexFrom: (stream next:2) ) shortAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PureDecoder >> nexEncodedInt32 [
	^ (ByteArray readHexFrom: (stream next: 4) ) longAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PureDecoder >> nexEncodedUInt16 [
	^ (ByteArray readHexFrom: (stream next:2) ) unsignedShortAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PureDecoder >> stream: aStream [
	stream := aStream.
]
