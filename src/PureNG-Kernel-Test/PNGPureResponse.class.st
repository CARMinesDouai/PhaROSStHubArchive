Class {
	#name : #PNGPureResponse,
	#superclass : #PureActionMessage,
	#instVars : [
		'errorCode'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'as yet unclassified' }
PNGPureResponse class >> initializeFromArray:  aByteArray forRobot: robot [
	| response encodedResponse  |
	response := self new.

	encodedResponse := PNGEncodedResponse forArray: aByteArray.
	
	response action: encodedResponse nextEncodedByte.
	response target: (robot instanceRelatedTo: encodedResponse nextEncodedUInt16).
	response errorCode: encodedResponse nextEncodedByte.

	response data: encodedResponse upToEnd.
	^response
	
	
]

{ #category : #'as yet unclassified' }
PNGPureResponse >> correctResponse: tableau [
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
PNGPureResponse >> decoder [
	^ PNGPureDecoder for: (ReadStream on: self data).
	
]

{ #category : #accessing }
PNGPureResponse >> errorCode [
	^ errorCode.
]

{ #category : #accessing }
PNGPureResponse >> errorCode: aNumber [
	errorCode := aNumber
]

{ #category : #'as yet unclassified' }
PNGPureResponse >> errorMessage [
	^ self responseLabelFromCode: self errorCode.
]

{ #category : #accessing }
PNGPureResponse >> received [

	self success ifFalse: [
		Error signal: self errorMessage.
	].
]

{ #category : #accessing }
PNGPureResponse >> responseLabelFromCode: responseCode [
	
	^ {   16r0 -> 'Success'.
		  16r1->'Target does not exist'.
		  16r2 ->'Action is not supported'.
		  16r3 ->'Unknown action'.
		  16r4 ->'Invalid length'.
		  16r5 ->'Invalid data' .
		16r10 -> 'Notification limit reached'.  
		16r11 -> 'Already bound to this notification'
		} at: responseCode
]

{ #category : #accessing }
PNGPureResponse >> success [
	^(self errorCode = 0).
]
