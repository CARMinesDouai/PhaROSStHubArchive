Class {
	#name : #PhaROSHSService,
	#superclass : #PhaROSHSTyped,
	#category : #'PhaROS-Kernel-Tcp'
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
