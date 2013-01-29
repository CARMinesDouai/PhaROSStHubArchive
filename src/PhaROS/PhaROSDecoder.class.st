Class {
	#name : #PhaROSDecoder,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'PhaROS-Encoding'
}

{ #category : #'as yet unclassified' }
PhaROSDecoder class >> on: aReadStream [
	^self new stream: aReadStream; yourself.
]

{ #category : #accessing }
PhaROSDecoder >> minimumPrecision [
	^ 0.002
]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedByte [
	^stream next
]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedDuration [
	| duration |
	duration := Duration new.
	duration seconds: self nextEncodedUint32 nanoSeconds: self nextEncodedUint32.
	^ duration.
]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedFloat32 [
	| n barray |
	
	^( Float fromIEEE32BitByteArray: (stream next:4)) roundUpTo: self minimumPrecision. 

]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedFloat64 [
	^ (stream next:8) doubleAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedInt16 [
	| n firstDigit barray |
	
	barray := ReadStream on: (stream next:2 ) reversed.

	n := firstDigit := barray next.
	n := (n bitShift: 8) + barray next.

	firstDigit >= 128 ifTrue: [n := -16r10000 + n].  "decode negative 16-bit integer"
	^ n

]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedInt32 [
	| n firstDigit barray |
	
	barray := ReadStream on: (stream next: 4) reversed .

	n := firstDigit := barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.

	
	firstDigit >= 128 ifTrue: [n := -16r100000000 + n].  "decode negative 32-bit integer"
	^ n

]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedInt64 [
	| n firstDigit barray |
	
	barray := stream next: 8.
	barray size = 8 ifFalse: [
		PhaROSUnexpextedValue signal:' there are less than 8 bytes in the stream '.
	].
	barray := ReadStream on: (barray) reversed.

	n := firstDigit := barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	
	firstDigit >= 128 ifTrue: [n := -16r10000000000000000 + n].  "decode negative 64-bit integer"
	^ n

]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedInt8 [
	| digit |
	digit := stream next.
	^digit < 128 ifTrue:[ 
		digit
	]ifFalse: [
		-16r100 + digit
	]
]

{ #category : #serialize }
PhaROSDecoder >> nextEncodedString [
	| length aByteArray |


	[
		length := self nextEncodedUint32.
	]on: Error do: [
		RoStUnexpextedValue signal: 'Unable to load string size'.
	].
	aByteArray := ByteArray new: length.

	stream nextInto: aByteArray.
	^aByteArray asString.

]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedTime [
	
 ^ PhaROSTimestamp fromUnixTime: self nextEncodedUint32  nanoSeconds: self nextEncodedUint32.
	
]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedUint16 [
	| n barray |
	
	barray := ReadStream on: (stream next:2) reversed.

	n := barray next.
	n := (n bitShift: 8) + barray next.
	^ n

]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedUint32 [
	| n firstDigit barray |
	
	barray := ReadStream on: (stream next: 4) reversed.

	
	[
		n := firstDigit := barray next.
		n := (n bitShift: 8) + barray next.
		n := (n bitShift: 8) + barray next.
		n := (n bitShift: 8) + barray next.
	] on: Error do: [
		PhaROSUnexpextedValue signal: 'Unable to load 32bits UInt'
	].

	^ n

]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedUint64 [
	| n firstDigit barray |
	
	barray := ReadStream on: (stream next:8) reversed.

	n := firstDigit := barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	
	^ n

]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedUint8 [
	
	^stream next.

]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> stream: aStream [
	stream := aStream.
]
