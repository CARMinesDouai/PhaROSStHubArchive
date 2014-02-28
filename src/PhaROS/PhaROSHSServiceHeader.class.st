Class {
	#name : #PhaROSHSServiceHeader,
	#superclass : #PhaROSHSTypedHeader,
	#category : #'PhaROS-Network-Tcp-Messages'
}

{ #category : #verification }
PhaROSHSServiceHeader class >> verificationDictionary [
		^super verificationDictionary addAll: (
		{ 
			#service -> ByteString 
		} asDictionary
	); yourself.
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
PhaROSHSServiceHeader >> probe [
	^ self optativeAt: 'probe' 
]

{ #category : #accessing }
PhaROSHSServiceHeader >> probe: anString [
	^self at:'probe' put: anString.
	

]

{ #category : #accessing }
PhaROSHSServiceHeader >> requestType [
	^self at:'request_type'.
	

]

{ #category : #accessing }
PhaROSHSServiceHeader >> requestType: anString [
	^self at:'request_type' put: anString.
	

]

{ #category : #accessing }
PhaROSHSServiceHeader >> responseType [
	^self at: 'response_type' 
]

{ #category : #accessing }
PhaROSHSServiceHeader >> responseType: aString [
	^self at: 'response_type'  put: aString.
]

{ #category : #accessing }
PhaROSHSServiceHeader >> service [
	^ self at: 'service'
]

{ #category : #accessing }
PhaROSHSServiceHeader >> service: aServiceName [
	self at: 'service' put: aServiceName
]
