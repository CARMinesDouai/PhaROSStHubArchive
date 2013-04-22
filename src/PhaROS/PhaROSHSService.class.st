Class {
	#name : #PhaROSHSService,
	#superclass : #PhaROSHSTyped,
	#instVars : [
		'response'
	],
	#category : #'PhaROS-Network-Tcp'
}

{ #category : #comparing }
PhaROSHSService >> ok [
	^self optativeAt:'ok'.
]

{ #category : #comparing }
PhaROSHSService >> ok: aBoolean [ 
	^self at:'ok' put: aBoolean.
]

{ #category : #verification }
PhaROSHSService >> response [ 
	^ response .
]

{ #category : #verification }
PhaROSHSService >> response: aResponse [ 
	response := aResponse 
]

{ #category : #verification }
PhaROSHSService >> verificationDictionary [
	^ {
	
	   }
]
