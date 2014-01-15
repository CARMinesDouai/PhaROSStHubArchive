Class {
	#name : #PhaROSHSServiceHeader,
	#superclass : #PhaROSHSTypedHeader,
	#instVars : [
		'response'
	],
	#category : #'PhaROS-Network-Tcp-Messages'
}

{ #category : #verification }
PhaROSHSServiceHeader class >> verificationDictionary [
	^ {
	
	   }
]

{ #category : #comparing }
PhaROSHSServiceHeader >> ok [
	^self optativeAt:'ok'.
]

{ #category : #comparing }
PhaROSHSServiceHeader >> ok: aBoolean [ 
	^self at:'ok' put: aBoolean.
]

{ #category : #accessing }
PhaROSHSServiceHeader >> requestType [
	^self at:'request_type'.
	

]

{ #category : #accessing }
PhaROSHSServiceHeader >> requestType: anString [
	^self at:'request_type' put: anString.
	

]

{ #category : #verification }
PhaROSHSServiceHeader >> response [ 
	^ response .
]

{ #category : #verification }
PhaROSHSServiceHeader >> response: aResponse [ 
	response := aResponse 
]

{ #category : #accessing }
PhaROSHSServiceHeader >> responseType [
	^self at: 'response_type' 
]

{ #category : #accessing }
PhaROSHSServiceHeader >> responseType: aString [
	^self at: 'response_type'  put: aString.
]
