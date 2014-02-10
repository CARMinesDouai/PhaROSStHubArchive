"
A PhaROSDurationType is type that represents interval  of time
"
Class {
	#name : #PhaROSDurationType,
	#superclass : #PhaROSType,
	#category : #'PhaROS-Types-Basic'
}

{ #category : #accessing }
PhaROSDurationType class >> dataTypeSize [
	^ 8
]

{ #category : #'pseudo-dsl' }
PhaROSDurationType class >> registerAlterName [
	" Name collision. DSL constructor name is at Duration class as extention method "
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

{ #category : #'as yet unclassified' }
PhaROSDurationType >> typeName [ 
	^ 'duration'
]
