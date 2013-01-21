Class {
	#name : #PureMessage,
	#superclass : #Object,
	#instVars : [
		'data',
		'target'
	],
	#category : #'PureNoLog-Messages'
}

{ #category : #'initialize-release' }
PureMessage class >> correctResponse: tableau [
	| correction index |
	correction := Array  new: (tableau size ) .
	index :=1.
	tableau do: [:contenu | 
				correction at:index put: ((contenu asInteger )printStringBase:16).
				index:= index+1. 
				].
	index :=1.
	correction := correction do: [:contenu | 
				(contenu size=1) ifTrue: [correction at: index put: ('0',contenu value) asString ]ifFalse: [correction at: index put: (contenu value)asString ] .
				index:= index+1.
			].
	^correction 
]

{ #category : #'as yet unclassified' }
PureMessage >> data [
	^ data.
]

{ #category : #'as yet unclassified' }
PureMessage >> data: aDataObject [
	data := aDataObject.
]

{ #category : #accessing }
PureMessage >> target [
	^  target
	
]

{ #category : #accessing }
PureMessage >> target: anObject [
	target := anObject
]
