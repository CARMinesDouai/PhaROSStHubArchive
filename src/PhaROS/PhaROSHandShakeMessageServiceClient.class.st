Class {
	#name : #PhaROSHandShakeMessageServiceClient,
	#superclass : #PhaROSHandShakeMessage,
	#category : #'PhaROS-Kernel-Tcp'
}

{ #category : #accessing }
PhaROSHandShakeMessageServiceClient >> persistent [
	^self optativeAt:'persistent'.
]

{ #category : #accessing }
PhaROSHandShakeMessageServiceClient >> persistent: aBoolean [ 
	^self at:'persistent' put: aBoolean .
]

{ #category : #accessing }
PhaROSHandShakeMessageServiceClient >> service [
	^self at:'service'.
]

{ #category : #accessing }
PhaROSHandShakeMessageServiceClient >> service: aServiceName [
	^self at:'service' put: aServiceName.
]

{ #category : #accessing }
PhaROSHandShakeMessageServiceClient >> verificationDictionary [ 
	^super verificationDictionary union: (
		{ 
			#md5Sum -> ByteString .
			#service -> ByteString .
		} asDictionary
	).
]
