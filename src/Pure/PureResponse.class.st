Class {
	#name : #PureResponse,
	#superclass : #PureActionMessage,
	#instVars : [
		'errorCode'
	],
	#category : #'Pure-Messages'
}

{ #category : #'as yet unclassified' }
PureResponse class >> initializeFromArray:  aByteArray forRobot: robot [
	| response decoder  |
	response := self new.

	decoder := PureDecoder forArray: aByteArray.
	
	response action: decoder nextEncodedByte.
	response target: (robot instanceRelatedTo: decoder nextEncodedUInt16).
	response errorCode: decoder nextEncodedByte.

	response data: decoder upToEnd.
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
PureResponse >> decoder [
	^ PureDecoder for: (ReadStream on: self data).
	
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
	^ PureConstants errorMessages at: self errorCode.
]

{ #category : #accessing }
PureResponse >> receivedBy: aRobot [

	self success ifFalse: [
		Error signal: self errorMessage.
	].
]

{ #category : #accessing }
PureResponse >> success [
	^(self errorCode = 0).
]
