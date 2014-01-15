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
	^self optativeAt:'persistent'.
]

{ #category : #accessing }
PhaROSHSServiceClientHeader >> persistent: aBoolean [ 
	^self at:'persistent' put: aBoolean .
]

{ #category : #accessing }
PhaROSHSServiceClientHeader >> service [
	^self at:'service'.
]

{ #category : #accessing }
PhaROSHSServiceClientHeader >> service: aServiceName [
	^self at:'service' put: aServiceName.
]
