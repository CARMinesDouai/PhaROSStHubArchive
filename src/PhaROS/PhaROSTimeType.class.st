Class {
	#name : #PhaROSTimeType,
	#superclass : #PhaROSType,
	#category : #'PhaROS-Types-Basic'
}

{ #category : #accessing }
PhaROSTimeType class >> dataTypeSize [
	^ 8
]

{ #category : #'pseudo-dsl' }
PhaROSTimeType class >> registerAlterName [
	" Name collision. DSL constructor name is at Time class as extention method "
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

{ #category : #'as yet unclassified' }
PhaROSTimeType >> typeName [ 
	^ 'time'
]
