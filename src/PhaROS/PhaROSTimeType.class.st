Class {
	#name : #PhaROSTimeType,
	#superclass : #PhaROSType,
	#category : #'PhaROS-Types-Basic'
}

{ #category : #'as yet unclassified' }
PhaROSTimeType class >> dataTypeSize [
	^ 8
]

{ #category : #'as yet unclassified' }
PhaROSTimeType >> defaultValueString [
	^ ' PhaROSTimestamp now'. 
]

{ #category : #'as yet unclassified' }
PhaROSTimeType >> isAPossibleValue: aTime [ 
	^ (aTime isKindOf: PhaROSTimestamp) and: [
		aTime seconds  < 4294967296 and: [
			aTime nanoSeconds  < 4294967296 
		]
	].
]

{ #category : #'as yet unclassified' }
PhaROSTimeType >> newInstance [ 
	^ Time new. 
]

{ #category : #'as yet unclassified' }
PhaROSTimeType >> setEncodeDecodeSelectors [
	encodeSelector := #encodeTime:.
	decodeSelector := #nextEncodedTime.
]
