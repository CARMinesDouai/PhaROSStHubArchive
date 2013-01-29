Class {
	#name : #PhaROSHSService,
	#superclass : #PhaROSHSTyped,
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
PhaROSHSService >> verificationDictionary [
	^ {
	
	   }
]
