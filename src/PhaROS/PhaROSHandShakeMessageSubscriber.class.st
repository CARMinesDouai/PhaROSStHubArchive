Class {
	#name : #PhaROSHandShakeMessageSubscriber,
	#superclass : #PhaROSTypedHandShakeMessage,
	#category : #'PhaROS-Kernel-Tcp'
}

{ #category : #accessing }
PhaROSHandShakeMessageSubscriber >> tcpNodelay [
	self optativeAt:'tcp_nodelay'.
]

{ #category : #accessing }
PhaROSHandShakeMessageSubscriber >> tcpNodelay: aBoolean [
	self at:'tcp_nodelay' put: aBoolean.
]

{ #category : #accessing }
PhaROSHandShakeMessageSubscriber >> topic [
	^self at:'topic'.
]

{ #category : #accessing }
PhaROSHandShakeMessageSubscriber >> topic: aTopicName [
	^self at:'topic' put: aTopicName.
]

{ #category : #verification }
PhaROSHandShakeMessageSubscriber >> verificationDictionary [ 
	^super verificationDictionary union: (
		{ 
			#topic -> ByteString 
		} asDictionary
	).
]
