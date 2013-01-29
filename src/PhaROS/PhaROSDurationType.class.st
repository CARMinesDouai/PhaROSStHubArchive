Class {
	#name : #PhaROSDurationType,
	#superclass : #PhaROSType,
	#category : #'PhaROS-Types-Basic'
}

{ #category : #'as yet unclassified' }
PhaROSDurationType class >> dataTypeSize [
	^ 8
]

{ #category : #'as yet unclassified' }
PhaROSDurationType >> defaultValueString [
	^ ' Duration seconds: 0'. 
]

{ #category : #'as yet unclassified' }
PhaROSDurationType >> isAPossibleValue: aDuration [
	^ (aDuration isKindOf: Duration) and: [
		aDuration secondsField  < 4294967296 and: [
			aDuration nanoSecondsField  < 4294967296 
		]
	].
]

{ #category : #'as yet unclassified' }
PhaROSDurationType >> newInstance [ 
	^ Duration new. 
]

{ #category : #'as yet unclassified' }
PhaROSDurationType >> setEncodeDecodeSelectors [
	encodeSelector := #encodeDuration:.
	decodeSelector := #nextEncodedDuration.
]
