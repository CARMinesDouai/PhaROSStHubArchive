"
A PhaROSEncoder is stream encoder. It writes in a given stream. It expose several methods per type. 
"
Class {
	#name : #PhaROSEncoder,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'PhaROS-Types-Encoding'
}

{ #category : #'as yet unclassified' }
PhaROSEncoder class >> on: aWriteStream [
	^self new stream: aWriteStream; yourself.
]

{ #category : #encoding }
PhaROSEncoder >> encodeArray: anArray of: aRelatedType [
	self encodeUint32: anArray size.
	self encodeFixedLenghtArray: anArray  of: aRelatedType.
	
	
]

{ #category : #encoding }
PhaROSEncoder >> encodeBoolean: aBoolean [
	^aBoolean ifTrue: [
		stream nextPut: 1.	
	] ifFalse: [
		stream nextPut: 0.
	]
]

{ #category : #encoding }
PhaROSEncoder >> encodeByte: aByte [
	stream nextPut: aByte.
]

{ #category : #encoding }
PhaROSEncoder >> encodeBytes: aCollection [
	stream nextPutAll: aCollection.
]

{ #category : #encoding }
PhaROSEncoder >> encodeDuration: aDuration [
	self encodeUint32: aDuration secondsField.
	self encodeUint32: aDuration nanoSeconds.
	

]

{ #category : #encoding }
PhaROSEncoder >> encodeFixedLenghtArray: anArray of: aRelatedType [
	anArray do: [
		:item |
		aRelatedType serialize: item into: self.
	].
	
]

{ #category : #encoding }
PhaROSEncoder >> encodeInt16: aSmallInteger [ 
	"Write a signed integer to the next 4 bytes"
	| pos topMagnitude  |
	
	topMagnitude :=  (2 raisedTo: (8 * 2) ) / 2.
	self verifyIf: aSmallInteger isBetween: topMagnitude * -1 and: topMagnitude .
	
	pos := aSmallInteger < 0
		ifTrue: [ ( 0 - aSmallInteger ) bitInvert16 + 1 ]
		ifFalse: [ aSmallInteger ].
		
	1 to: 2 do: [ :i | stream nextPut: ( pos digitAt: i ) ].
 
]

{ #category : #encoding }
PhaROSEncoder >> encodeInt32: aSmallInteger [ 
	"Write a signed integer to the next 4 bytes"
	| pos topMagnitude |
	
	topMagnitude :=  (2 raisedTo: (8 * 4) ) / 2.
	self verifyIf: aSmallInteger isBetween: topMagnitude * -1 and: topMagnitude .
	
	
	pos := aSmallInteger < 0
		ifTrue: [(0-aSmallInteger) bitInvert32 + 1]
		ifFalse: [aSmallInteger].
	1 to: 4 do: [:i | stream nextPut: (pos digitAt: i )].

]

{ #category : #encoding }
PhaROSEncoder >> encodeInt64: aSmallInteger [ 

	"Write a signed integer to the next 4 bytes"
	| pos topMagnitude |
	
	topMagnitude :=  (2 raisedTo: (8 * 8) ) / 2.
	self verifyIf: aSmallInteger isBetween: topMagnitude * -1 and: topMagnitude .
	
	pos := aSmallInteger < 0
		ifTrue: [(0-aSmallInteger) bitInvert64 + 1]
		ifFalse: [aSmallInteger].
	1 to: 8 do: [:i | stream nextPut: (pos digitAt: i )].


]

{ #category : #encoding }
PhaROSEncoder >> encodeInt8: aSmallInteger [ 
	"Write a signed integer to the next byte"
	| val topMagnitude |
	topMagnitude :=  (2 raisedTo: (8) ) / 2.
	self verifyIf: aSmallInteger isBetween: topMagnitude * -1 and: topMagnitude .
	
	(aSmallInteger >= 0 and: [aSmallInteger < 128]) ifTrue:[ val :=  aSmallInteger ].
	(aSmallInteger < 0 and: [aSmallInteger > -129]) ifTrue:[ val:= aSmallInteger abs bitInvert8 + 1].
		
	val ifNil: [ self error: 'out of bounds.'] .
	^self encodeByte: val.

]

{ #category : #encoding }
PhaROSEncoder >> encodeString: aString [
	self encodeUint32: aString size.
	self encodeBytes: aString asByteArray. 
	
]

{ #category : #encoding }
PhaROSEncoder >> encodeTime: aTime [
        | time |
        time := aTime.
        aTime isSymbol  ifTrue: [
                time := PhaROSTimestamp perform: aTime.
        ].
        (aTime isKindOf: DateAndTime )ifTrue:[
                time := PhaROSTimestamp new timestamp: aTime; yourself.
        ].
        aTime = 0
                ifTrue: [ self encodeUint32: 0.
                                self encodeUint32: 0]
                ifFalse: [ self encodeUint32: time  secondsUTC.
                                self encodeUint32: time  nanoSeconds.]
]

{ #category : #encoding }
PhaROSEncoder >> encodeUint16: aSmallInteger [ 
	"Append to the receiver an Integer as the next two bytes."
	
	| array a b topMagnitude |
	
	topMagnitude :=  (2 raisedTo: (8 * 2) ).
	self verifyIf: aSmallInteger isBetween: 0 and: topMagnitude .
	
	a := aSmallInteger bitShift: -8.
	b :=  aSmallInteger bitAnd: 255.
	array := (ByteArray new), b asByteArray , a asByteArray .

	stream nextPutAll: array.

]

{ #category : #encoding }
PhaROSEncoder >> encodeUint32: aSmallInteger [ 
 | topMagnitude |
	
	topMagnitude :=  (2 raisedTo: (8 * 4) ).
	self verifyIf: aSmallInteger isBetween: 0 and: topMagnitude .
	
	"Append to the receiver an Integer as the next 4 bytes."
	1 to: 4 do: [:i | stream nextPut: (aSmallInteger digitAt: i)].
]

{ #category : #encoding }
PhaROSEncoder >> encodeUint64: aNumber [

	| val  topMagnitude |
	
	topMagnitude :=  (2 raisedTo: (8 * 8) ).
	self verifyIf: aNumber  isBetween: 0 and: topMagnitude .
	
	val :=  aNumber asByteArray.
	val := (ByteArray new: (8 - val size)), val.
	val := val reversed.
	stream nextPutAll: val.
	
]

{ #category : #encoding }
PhaROSEncoder >> encodeUint8: aSmallInteger [ 
	"Write a signed integer to the next byte"
	|  topMagnitude |
	
	topMagnitude :=  (2 raisedTo: (8) ).
	self verifyIf: aSmallInteger isBetween: 0 and: topMagnitude .
	
	
	^self encodeByte: aSmallInteger.

]

{ #category : #encoding }
PhaROSEncoder >> encodefloat32: aFloat [
	| encoded |
	encoded := aFloat asFloat asIEEE32BitWord asByteArray reversed.
	encoded :=  (ByteArray new: 4 - encoded size), encoded.
	stream nextPutAll: encoded.
]

{ #category : #encoding }
PhaROSEncoder >> encodefloat64: aFloat64 [
	| encoded aFloat |
	aFloat := aFloat64 asFloat.
	encoded := ByteArray new: 8.
	
	encoded at:1 put: ((aFloat basicAt:2) digitAt: 1).
	encoded at:2 put: ((aFloat basicAt:2) digitAt: 2).
	encoded at:3 put: ((aFloat basicAt:2) digitAt: 3).
	encoded at:4 put: ((aFloat basicAt:2) digitAt: 4).
	
	encoded at:5 put: ((aFloat basicAt:1) digitAt: 1).
	encoded at:6 put: ((aFloat basicAt:1) digitAt: 2).
	encoded at:7 put: ((aFloat basicAt:1) digitAt: 3).
	encoded at:8 put: ((aFloat basicAt:1) digitAt: 4).
	
	
	stream nextPutAll: encoded.
	
	
	"encoded := ByteArray readHexFrom: (PDRConverter as64BitsHexStringFromFloat: aFloat).
	stream nextPutAll: encoded."
]

{ #category : #serialize }
PhaROSEncoder >> flush [
	stream flush.
]

{ #category : #accessing }
PhaROSEncoder >> stream: aStream [ 
	stream := aStream.
	

]

{ #category : #encoding }
PhaROSEncoder >> verifyIf: aNumber isBetween: aLower and: aHigher [
	" the implementation of x between: a and: b  is  x belongs to (a, b). But i need x belongs to [a, b]. Thats why i use (a-1; b+1)"
	(aNumber between: aLower   and: aHigher ) ifFalse: [
			self error: ' number should be in the proper interval '.
	].
]
