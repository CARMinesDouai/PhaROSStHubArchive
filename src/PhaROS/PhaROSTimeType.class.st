Class {
	#name : #PhaROSTimeType,
	#superclass : #PhaROSType,
	#category : #'PhaROS-Kernel-Types'
}

{ #category : #'as yet unclassified' }
PhaROSTimeType class >> dataTypeSize [
	^ 8
]

{ #category : #'as yet unclassified' }
PhaROSTimeType >> defaultValueString [
	^ ' Time now'. 
]

{ #category : #'as yet unclassified' }
PhaROSTimeType >> isAPossibleValue: aTime [ 
	^ (aTime isKindOf: Time) and: [
		aTime secondsField  < 4294967296 and: [
			aTime nanoSecondsField  < 4294967296 
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
