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

{ #category : #accesing }
PhaROSHSServiceClientHeader >> probe [
	^ self optativeAt: 'probe' 
]

{ #category : #accessing }
PhaROSHSServiceClientHeader >> probe: anString [
	^self at:'probe' put: anString.
	

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

{ #category : #accesing }
PhaROSHSServiceClientHeader >> subscribeTo: aTransport with: aSocketStream [
	^ aTransport processServiceRequest: self service for: self callerId with: aSocketStream beingPersistent: self persistent forProbe: self probe = '1'.
]

{ #category : #accessing }
PhaROSHSServiceClientHeader >> tcpNodelay [
	self optativeAt:'tcp_nodelay'.
]

{ #category : #accessing }
PhaROSHSServiceClientHeader >> tcpNodelay: aBoolean [
	self at:'tcp_nodelay' put: aBoolean.
]

{ #category : #accesing }
PhaROSHSServiceClientHeader >> type [
	^ header at: #type
]
