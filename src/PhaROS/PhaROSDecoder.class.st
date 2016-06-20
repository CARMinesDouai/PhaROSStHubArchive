"
A PhaROSDecoder is stream encoder. It reads from a given stream. It expose several methods per type. 
"
Class {
	#name : #PhaROSDecoder,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'PhaROS-Types-Encoding'
}

{ #category : #'as yet unclassified' }
PhaROSDecoder class >> on: aReadStream [
	^self new stream: aReadStream; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> hasLeft: anAmountOfBytes [
	 self flag: #comment.
	
	^ true.
	
	"
		since SocketStream doesnot understand position, this maybe has not sense. 
		^stream position + anAmountOfBytes <= stream size.
	"
]

{ #category : #accessing }
PhaROSDecoder >> minimumPrecision [
	^ 0.002
]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedByte [
	self verifyDataAvailability.
	^stream next
]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedDuration [
	| duration |
	self verifyDataAvailability: (4 * 2).
	duration := Duration new.
	duration seconds: self nextEncodedUint32 nanoSeconds: self nextEncodedUint32.
	^ duration.
]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedFloat32 [
	| rawFloatValue |
	self verifyDataAvailability: 4.
	rawFloatValue := Float fromIEEE32BitByteArray: (stream next: 4).
	((rawFloatValue isNaN) or: [rawFloatValue isInfinite]) ifTrue: [ ^ rawFloatValue ].
	^ rawFloatValue roundUpTo: self minimumPrecision
]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedFloat64 [
	self verifyDataAvailability: (8).
	^ (stream next:8) doubleAt: 1 bigEndian: false.
]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedInt16 [
	| n firstDigit barray |
	self verifyDataAvailability: (2).	
	barray := ReadStream on: (stream next:2 ) reversed.

	n := firstDigit := barray next.
	n := (n bitShift: 8) + barray next.

	firstDigit >= 128 ifTrue: [n := -16r10000 + n].  "decode negative 16-bit integer"
	^ n

]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedInt32 [
	| n firstDigit barray |
	
	self verifyDataAvailability: (4).
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
	
	self verifyDataAvailability: (8).
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
	self verifyDataAvailability.
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
		PhaROSUnexpextedValue signal: 'Unable to load string size'.
	].
	self verifyDataAvailability: (length).
	aByteArray := ByteArray new: length.

	stream nextInto: aByteArray.
	^aByteArray asString.

]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedTime [
	self verifyDataAvailability: (4 * 2).
 ^ PhaROSTimestamp fromUnixTime: self nextEncodedUint32  nanoSeconds: self nextEncodedUint32.
	
]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedUint16 [
	| n barray |
	self verifyDataAvailability: (2).
	barray := ReadStream on: (stream next:2) reversed.

	n := barray next.
	n := (n bitShift: 8) + barray next.
	^ n

]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> nextEncodedUint32 [
	| n n2 firstDigit src barray |

	self verifyDataAvailability: (4).	
	
	src := stream next: 4.

	barray := ReadStream on: src reversed.

	
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
	
	self verifyDataAvailability: (8).
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
	self verifyDataAvailability.
	^stream next.

]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> stream: aStream [
	stream := aStream.
]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> verifyDataAvailability [
	^ self verifyDataAvailability: 1.
]

{ #category : #'as yet unclassified' }
PhaROSDecoder >> verifyDataAvailability: anAmount [
	(self hasLeft: anAmount ) ifFalse: [ self error: 'There are no more data'].
]
