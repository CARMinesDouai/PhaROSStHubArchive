Class {
	#name : #PNGResponse,
	#superclass : #PNGActionMessage,
	#instVars : [
		'responseCode'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'instance creation' }
PNGResponse class >> newWithDecoder: aDecoder forRobot: aRobulab [
	
	| response |
	response := self new.
	response 
		decoder: aDecoder; 
		action: aDecoder nextEncodedByte ;
		target: aDecoder nextEncodedUInt16 ;
		responseCode: aDecoder nextEncodedByte;
		robot: aRobulab.
	^response
]

{ #category : #accessing }
PNGResponse >> received [

	self success ifFalse: [
		Error signal: self responseMessage 
	].
]

{ #category : #accessing }
PNGResponse >> responseCode [
	^ responseCode
]

{ #category : #accessing }
PNGResponse >> responseCode: aNumber [
	responseCode := aNumber
]

{ #category : #accessing }
PNGResponse >> responseLabelFromCode: responseCode [
	
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
PNGResponse >> responseMessage [
	^ self responseLabelFromCode: self responseCode 
]

{ #category : #accessing }
PNGResponse >> success [
	^(self responseCode = 0).
]
