Class {
	#name : #PhaROSPacket,
	#superclass : #Object,
	#instVars : [
		'type',
		'value'
	],
	#category : #'PhaROS-Network-Tcp'
}

{ #category : #'as yet unclassified' }
PhaROSPacket class >> type: aType value: aValue [
	^ self new 	type: aType;
				value: aValue;
				yourself.
]

{ #category : #'as yet unclassified' }
PhaROSPacket >> = anOtherPacket [
	^( anOtherPacket isKindOf: PhaROSPacket )and: [ 
		value = anOtherPacket value.	
	]
]

{ #category : #'as yet unclassified' }
PhaROSPacket >> decodePacketSizeFrom: aDecoder [
	^ aDecoder nextEncodedUint32.
]

{ #category : #'as yet unclassified' }
PhaROSPacket >> dump [
	| anEncoder stream |

	type check: value.

	stream := WriteStream on: (ByteArray new: (type dataTypeSizeFor: value ) + 4).
	anEncoder  := PhaROSEncoder on: stream.
	self encodePacketSize: (type dataTypeSizeFor: value) into: anEncoder.	
	
	type serialize: value into: anEncoder.
	anEncoder flush.
	^ stream contents.
]

{ #category : #serialize }
PhaROSPacket >> encodePacketSize: aSize into: aRoStEncoder [ 
	
	aRoStEncoder encodeInt32: aSize.
]

{ #category : #'as yet unclassified' }
PhaROSPacket >> load: aByteArray [ 
	| aDecoder  size |

	aByteArray size < 4 ifTrue: [
		PhaROSUnexpextedValue signal:' Unexpected Value'.		
	].

	^ self loadStream: (ReadStream on: aByteArray).

]

{ #category : #'as yet unclassified' }
PhaROSPacket >> loadStream: aStream [ 
	| aDecoder  |


	aDecoder := PhaROSDecoder on: aStream .
	
 	(type isAPossibleSize:( self decodePacketSizeFrom: aDecoder )) ifFalse: [
		PhaROSUnexpextedValue signal:' Unexpected Value'.	
	].
	
	value := type decode: aDecoder.


]

{ #category : #accessing }
PhaROSPacket >> type [
	^ type
]

{ #category : #'as yet unclassified' }
PhaROSPacket >> type: aType [ 
	type := aType 
	
]

{ #category : #'as yet unclassified' }
PhaROSPacket >> value [ 
	^value.
]

{ #category : #'as yet unclassified' }
PhaROSPacket >> value: aValue [
	value := aValue.
]
