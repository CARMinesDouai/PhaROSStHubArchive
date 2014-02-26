Class {
	#name : #PhaROSHSServiceClient,
	#superclass : #PhaROSHSMessage,
	#category : #'PhaROS-Network-Tcp-Messages'
}

{ #category : #accessing }
PhaROSHSServiceClient class >> verificationDictionary [ 
	^super verificationDictionary addAll: (
		{ 
			#md5Sum -> ByteString .
			#service -> ByteString .
		} asDictionary
	); yourself.
]

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
