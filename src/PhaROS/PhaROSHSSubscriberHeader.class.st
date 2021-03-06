Class {
	#name : #PhaROSHSSubscriberHeader,
	#superclass : #PhaROSHSTypedHeader,
	#category : #'PhaROS-Network-Tcp-Messages'
}

{ #category : #verification }
PhaROSHSSubscriberHeader class >> verificationDictionary [ 
	^super verificationDictionary addAll: (
		{ 
			#topic -> ByteString 
		} asDictionary
	); removeKey:#type; yourself.
]

{ #category : #accessing }
PhaROSHSSubscriberHeader >> subscribeTo: aTransport with: aSocketStream [
	self flag: #shouldIRefactorSubscriberToReceiveStream.
	^ aTransport subscribe: self callerId with: aSocketStream socket to: self topic.
]

{ #category : #accessing }
PhaROSHSSubscriberHeader >> tcpNodelay [
	self optativeAt:'tcp_nodelay'.
]

{ #category : #accessing }
PhaROSHSSubscriberHeader >> tcpNodelay: aBoolean [
	self at:'tcp_nodelay' put: aBoolean.
]

{ #category : #accessing }
PhaROSHSSubscriberHeader >> topic [
	^self at:'topic'.
]

{ #category : #accessing }
PhaROSHSSubscriberHeader >> topic: aTopicName [
	^self at:'topic' put: aTopicName.
]
