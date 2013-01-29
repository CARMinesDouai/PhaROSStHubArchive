Class {
	#name : #PhaROSHSServiceClient,
	#superclass : #PhaROSHSMessage,
	#category : #'PhaROS-Network-Tcp'
}

{ #category : #accessing }
PhaROSHSServiceClient >> persistent [
	^self optativeAt:'persistent'.
]

{ #category : #accessing }
PhaROSHSServiceClient >> persistent: aBoolean [ 
	^self at:'persistent' put: aBoolean .
]

{ #category : #accessing }
PhaROSHSServiceClient >> service [
	^self at:'service'.
]

{ #category : #accessing }
PhaROSHSServiceClient >> service: aServiceName [
	^self at:'service' put: aServiceName.
]

{ #category : #accessing }
PhaROSHSServiceClient >> verificationDictionary [ 
	^super verificationDictionary addAll: (
		{ 
			#md5Sum -> ByteString .
			#service -> ByteString .
		} asDictionary
	); yourself.
]
