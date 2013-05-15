Class {
	#name : #PhaROSHSSubscriber,
	#superclass : #PhaROSHSTyped,
	#category : #'PhaROS-Network-Tcp-Messages'
}

{ #category : #verification }
PhaROSHSSubscriber class >> verificationDictionary [ 
	^super verificationDictionary addAll: (
		{ 
			#topic -> ByteString 
		} asDictionary
	); removeKey:#type; yourself.
]

{ #category : #accessing }
PhaROSHSSubscriber >> tcpNodelay [
	self optativeAt:'tcp_nodelay'.
]

{ #category : #accessing }
PhaROSHSSubscriber >> tcpNodelay: aBoolean [
	self at:'tcp_nodelay' put: aBoolean.
]

{ #category : #accessing }
PhaROSHSSubscriber >> topic [
	^self at:'topic'.
]

{ #category : #accessing }
PhaROSHSSubscriber >> topic: aTopicName [
	^self at:'topic' put: aTopicName.
]
