Class {
	#name : #PhaROSHandShakeMessageService,
	#superclass : #PhaROSTypedHandShakeMessage,
	#category : #'PhaROS-Kernel-Tcp'
}

{ #category : #comparing }
PhaROSHandShakeMessageService >> ok [
	^self optativeAt:'ok'.
]

{ #category : #comparing }
PhaROSHandShakeMessageService >> ok: aBoolean [ 
	^self at:'ok' put: aBoolean.
]

{ #category : #verification }
PhaROSHandShakeMessageService >> verificationDictionary [
	^ {
	
	   }
]
