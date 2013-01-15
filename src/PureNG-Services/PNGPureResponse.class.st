Class {
	#name : #PNGPureResponse,
	#superclass : #PNGPureActionMessage,
	#instVars : [
		'responseCode'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'instance creation' }
PNGPureResponse class >> newWithRawData: rawData forRobot: aRobulab [
	
	| response |
	response := self new.
	response 
		stream: (ReadStream on: rawData); 
		nextEncodedByte ; "consume id"
		action: response nextEncodedByte ;
		target: response nextEncodedUInt16 ;
		responseCode: response nextEncodedByte;
		robot: aRobulab.
	^response
]

{ #category : #accessing }
PNGPureResponse >> received [

	self success ifFalse: [
		Error signal: self responseMessage 
	].
]

{ #category : #accessing }
PNGPureResponse >> responseCode [
	^ responseCode
]

{ #category : #accessing }
PNGPureResponse >> responseCode: aNumber [
	responseCode := aNumber
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
PNGPureResponse >> responseMessage [
	^ self responseLabelFromCode: self responseCode 
]

{ #category : #accessing }
PNGPureResponse >> success [
	^(self responseCode = 0).
]
