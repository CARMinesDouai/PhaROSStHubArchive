Class {
	#name : #PureResponse,
	#superclass : #PureActionMessage,
	#instVars : [
		'errorCode'
	],
	#category : #'Pure-Messages'
}

{ #category : #'initialize-release' }
PureResponse class >> initializeFromArray:  aByteArray [
	| response decoder id |
	response := PureResponse new.
	response responseArray: (aByteArray ).
	
	decoder := response decoder.
	id := decoder nextEncodedByte.
"	response idRequete: (response responseArray at: 1)."
	
	response action: decoder nextEncodedByte.
	response target: decoder nextEncodedUInt16.
	response errorCode: decoder nextEncodedByte.
	
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
	^ ConstantesRobulab errorMessages at: self errorCode.
]

{ #category : #accessing }
PureResponse >> received [

	self success ifFalse: [
		Error signal: self errorMessage.
	].
]

{ #category : #accessing }
PureResponse >> success [
	^(self errorCode = 0).
]
