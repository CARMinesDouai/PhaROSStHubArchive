Class {
	#name : #PhaROSEncoder,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'PhaROS-Kernel-Types'
}

{ #category : #'as yet unclassified' }
PhaROSEncoder class >> on: aReadStream [
	^self new stream: aReadStream; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSEncoder >> encodeArray: anArray of: aRelatedType [
	self encodeUint32: anArray size.
	self encodeFixedLenghtArray: anArray  of: aRelatedType.
	
	
]

{ #category : #serialize }
PhaROSEncoder >> encodeBoolean: aBoolean [
	^aBoolean ifTrue: [
		stream nextPut: 1.	
	] ifFalse: [
		stream nextPut: 0.
	]
]

{ #category : #'as yet unclassified' }
PhaROSEncoder >> encodeByte: aByte [
	stream nextPut: aByte.
]

{ #category : #'as yet unclassified' }
PhaROSEncoder >> encodeBytes: aCollection [
	stream nextPutAll: aCollection.
]

{ #category : #'as yet unclassified' }
PhaROSEncoder >> encodeDuration: aDuration [
	self encodeUint32: aDuration secondsField.
	self encodeUint32: aDuration nanoSeconds.
	

]

{ #category : #'as yet unclassified' }
PhaROSEncoder >> encodeFixedLenghtArray: anArray of: aRelatedType [
	anArray do: [
		:item |
		aRelatedType serialize: item into: self.
	].
	
]

{ #category : #'as yet unclassified' }
PhaROSEncoder >> encodeInt16: aSmallInteger [ 
	"Write a signed integer to the next 4 bytes"
	| pos |
	pos := aSmallInteger < 0
		ifTrue: [ ( 0 - aSmallInteger ) bitInvert16 + 1 ]
		ifFalse: [ aSmallInteger ].
		
	1 to: 2 do: [ :i | stream nextPut: ( pos digitAt: i ) ].
 
]

{ #category : #'as yet unclassified' }
PhaROSEncoder >> encodeInt32: aSmallInteger [ 
	"Write a signed integer to the next 4 bytes"
	| pos |
	pos := aSmallInteger < 0
		ifTrue: [(0-aSmallInteger) bitInvert32 + 1]
		ifFalse: [aSmallInteger].
	1 to: 4 do: [:i | stream nextPut: (pos digitAt: i )].

]

{ #category : #encode }
PhaROSEncoder >> encodeInt64: aSmallInteger [ 

	"Write a signed integer to the next 4 bytes"
	| pos |
	pos := aSmallInteger < 0
		ifTrue: [(0-aSmallInteger) bitInvert64 + 1]
		ifFalse: [aSmallInteger].
	1 to: 8 do: [:i | stream nextPut: (pos digitAt: i )].


]

{ #category : #'as yet unclassified' }
PhaROSEncoder >> encodeInt8: aSmallInteger [ 
	"Write a signed integer to the next byte"
	| val |
	(aSmallInteger >= 0 and: [aSmallInteger < 128]) ifTrue:[ val :=  aSmallInteger ].
	(aSmallInteger < 0 and: [aSmallInteger > -129]) ifTrue:[ val:= aSmallInteger abs bitInvert8 + 1].
		
	val ifNil: [ self error: 'out of bounds.'] .
	^self encodeByte: val.

]

{ #category : #'as yet unclassified' }
PhaROSEncoder >> encodeString: aString [
	self encodeUint32: aString size.
	self encodeBytes: aString asByteArray. 
	
]

{ #category : #'as yet unclassified' }
PhaROSEncoder >> encodeTime: aTime [
	| time |
	time := aTime.
	aTime isSymbol  ifTrue: [
		time := PhaROSTimestamp perform: aTime.
	].

	self encodeUint32: time  seconds.
	self encodeUint32: time  nanoSeconds.
	

]

{ #category : #'as yet unclassified' }
PhaROSEncoder >> encodeUint16: aSmallInteger [ 
	"Append to the receiver an Integer as the next two bytes."
	
	| array a b |
	
	a := aSmallInteger bitShift: -8.
	b :=  aSmallInteger bitAnd: 255.
	array := (ByteArray new), b asByteArray , a asByteArray .

	stream nextPutAll: array.

]

{ #category : #'as yet unclassified' }
PhaROSEncoder >> encodeUint32: aSmallInteger [ 
	"Append to the receiver an Integer as the next 4 bytes."
	1 to: 4 do: [:i | stream nextPut: (aSmallInteger digitAt: i)].
]

{ #category : #'as yet unclassified' }
PhaROSEncoder >> encodeUint64: aNumber [

	| val |
	val :=  aNumber asByteArray.
	val := (ByteArray new: (8 - val size)), val.
	val := val reversed.
	stream nextPutAll: val.
	
]

{ #category : #'as yet unclassified' }
PhaROSEncoder >> encodeUint8: aSmallInteger [ 
	"Write a signed integer to the next byte"
	| val |
	(aSmallInteger >= 0 and: [aSmallInteger < 256]) ifTrue:[ val :=  aSmallInteger ].
		
	val ifNil: [ self error: 'out of bounds.'] .
	^self encodeByte: val.

]

{ #category : #'as yet unclassified' }
PhaROSEncoder >> encodefloat32: aFloat [
	| encoded |
	encoded := aFloat asIEEE32BitWord asByteArray reversed.
	encoded :=  (ByteArray new: 4 - encoded size), encoded.
	stream nextPutAll: encoded.
]

{ #category : #'as yet unclassified' }
PhaROSEncoder >> encodefloat64: aFloat [
	| encoded |

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

{ #category : #'as yet unclassified' }
PhaROSEncoder >> flush [
	stream flush.
]

{ #category : #'as yet unclassified' }
PhaROSEncoder >> stream: aStream [ 
	stream := aStream.
	

]
