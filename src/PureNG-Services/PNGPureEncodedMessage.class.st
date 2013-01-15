Class {
	#name : #PNGPureEncodedMessage,
	#superclass : #Object,
	#instVars : [
		'stream',
		'target',
		'robot'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'instance creation' }
PNGPureEncodedMessage class >> createResponseOrNotificationForData: rawData andRobot: aRobulab [

	| responseType responseClass |
	responseType := rawData at: 1.
	
	responseClass := PNGPureResponse.
	
	((responseType = 0) or: [ responseType = 1]) ifTrue: [ responseClass := PNGNotification ].
	
	^responseClass newWithRawData: rawData forRobot: aRobulab

]

{ #category : #'instance creation' }
PNGPureEncodedMessage class >> newWithRawData: rawData forRobot: aRobulab [

	
	^self subclassResponsibility 

]

{ #category : #testing }
PNGPureEncodedMessage >> hasData [
	^ stream atEnd not.
]

{ #category : #testing }
PNGPureEncodedMessage >> isNotification [
	^false
]

{ #category : #decoder }
PNGPureEncodedMessage >> nextEncodedByte [
	^ stream next. 
	
]

{ #category : #decoder }
PNGPureEncodedMessage >> nextEncodedBytes: anAmountOfBytes [
	^ stream next: anAmountOfBytes. 
	
]

{ #category : #decoder }
PNGPureEncodedMessage >> nextEncodedFloat32 [
	^ (stream next:4) floatAt: 1 bigEndian: false.
]

{ #category : #decoder }
PNGPureEncodedMessage >> nextEncodedFloat64 [
	^ (stream next:8) doubleAt: 1 bigEndian: false.
]

{ #category : #decoder }
PNGPureEncodedMessage >> nextEncodedInt16 [
	^(stream next:2) shortAt: 1 bigEndian: false.
]

{ #category : #decoder }
PNGPureEncodedMessage >> nextEncodedInt32 [
	^  (stream next: 4) longAt: 1 bigEndian: false.
]

{ #category : #decoder }
PNGPureEncodedMessage >> nextEncodedUInt16 [
	^ ( stream next:2 ) unsignedShortAt: 1 bigEndian: false.
]

{ #category : #decoder }
PNGPureEncodedMessage >> nextEncodedUint32 [

	^  (stream next: 4) unsignedLongAt: 1 bigEndian: false.
]

{ #category : #decoder }
PNGPureEncodedMessage >> nextEncodedUint64 [

	^  (stream next: 8) unsignedLongAt: 1 bigEndian: false.
]

{ #category : #accessing }
PNGPureEncodedMessage >> robot [
	^robot
	
]

{ #category : #accessing }
PNGPureEncodedMessage >> robot: aRobulab [
	robot := aRobulab 
	
]

{ #category : #accessing }
PNGPureEncodedMessage >> stream: aStream [
	stream := aStream.
]

{ #category : #accessing }
PNGPureEncodedMessage >> target [
	^target
]

{ #category : #accessing }
PNGPureEncodedMessage >> target: anObject [
	target := anObject
]

{ #category : #decoder }
PNGPureEncodedMessage >> upToEnd [ 

	^ stream upToEnd.
]
