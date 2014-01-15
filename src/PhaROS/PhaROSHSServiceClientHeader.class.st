Class {
	#name : #PhaROSHSServiceClientHeader,
	#superclass : #PhaROSHSMessageHeader,
	#category : #'PhaROS-Network-Tcp-Messages'
}

{ #category : #accessing }
PhaROSHSServiceClientHeader class >> verificationDictionary [ 
	^super verificationDictionary addAll: (
		{ 
			#md5Sum -> ByteString .
			#service -> ByteString .
		} asDictionary
	); yourself.
]

{ #category : #accessing }
PhaROSHSServiceClientHeader >> persistent [
	^(self optativeAt:'persistent') ifNil: [false].
]

{ #category : #accessing }
PhaROSHSServiceClientHeader >> persistent: aBoolean [ 
	^self at:'persistent' put: aBoolean .
]

{ #category : #accessing }
PhaROSHSServiceClientHeader >> requestType [
	^self at:'request_type'.
	

]

{ #category : #accessing }
PhaROSHSServiceClientHeader >> requestType: anString [
	^self at:'request_type' put: anString.
	

]

{ #category : #accessing }
PhaROSHSServiceClientHeader >> responseType [
	^self at: 'response_type' 
]

{ #category : #accessing }
PhaROSHSServiceClientHeader >> responseType: aString [
	^self at: 'response_type'  put: aString.
]

{ #category : #accessing }
PhaROSHSServiceClientHeader >> service [
	^self at:'service'.
]

{ #category : #accessing }
PhaROSHSServiceClientHeader >> service: aServiceName [
	^self at:'service' put: aServiceName.
]