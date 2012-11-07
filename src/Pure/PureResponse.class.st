Class {
	#name : #PureResponse,
	#superclass : #PureActionMessage,
	#instVars : [
		'errorCode'
	],
	#category : #'Pure-Messages'
}

{ #category : #'initialize-release' }
PureResponse class >> initializeFromArray:  tableau [
	| response |
	response := PureResponse new.
	response responseArray: (self correctResponse: tableau ).
	response idRequete: (response responseArray at: 1).
	response action: (response responseArray at: 2).
	response target: (((response responseArray at: 3), (response responseArray at: 4)asString) ).
	response errorCode: (response responseArray at: 5).
	
	^response
	
	

	
]

{ #category : #'as yet unclassified' }
PureResponse >> correctResponse: tableau [
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

{ #category : #accessing }
PureResponse >> errorCode [
	^ errorCode.
]

{ #category : #accessing }
PureResponse >> errorCode: aNumber [
	errorCode := aNumber
]

{ #category : #'as yet unclassified' }
PureResponse >> errorMessage [
	^ ConstantesRobulab codesErreurs at: self errorCode.
]

{ #category : #accessing }
PureResponse >> received [
	self success ifFalse: [
		Error signal: self errorMessage.
	].
]

{ #category : #accessing }
PureResponse >> success [
	^(self errorCode = '00')
]
