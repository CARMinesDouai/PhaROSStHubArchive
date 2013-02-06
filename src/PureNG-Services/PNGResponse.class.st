Class {
	#name : #PNGResponse,
	#superclass : #PNGActionMessage,
	#instVars : [
		'responseCode'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #delivery }
PNGResponse class >> deliverWithDecoder: dataDecoder to: aRobot [ 
	|response|
	response := self new 
		initializeWithDecoder: dataDecoder;
		yourself.
	aRobot receiveCommandResult: response
]

{ #category : #'initialize-release' }
PNGResponse >> initializeWithDecoder: aDecoder [
	
	self decoder: aDecoder; 
		action: aDecoder nextEncodedByte ;
		target: aDecoder nextEncodedUInt16 ;
		responseCode: aDecoder nextEncodedByte.
]

{ #category : #accessing }
PNGResponse >> isSuccess [
	^(self responseCode = 0).
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
PNGResponse >> responseMessage [

	^ {   16r0 -> 'Success'.
		  16r1->'Target does not exist'.
		  16r2 ->'Action is not supported'.
		  16r3 ->'Unknown action'.
		  16r4 ->'Invalid length'.
		  16r5 ->'Invalid data' .
		16r10 -> 'Notification limit reached'.  
		16r11 -> 'Already bound to this notification'
		} asDictionary at: self responseCode 
]
