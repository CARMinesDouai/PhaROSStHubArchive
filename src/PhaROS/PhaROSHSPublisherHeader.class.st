Class {
	#name : #PhaROSHSPublisherHeader,
	#superclass : #PhaROSHSTypedHeader,
	#category : #'PhaROS-Network-Tcp-Messages'
}

{ #category : #accessing }
PhaROSHSPublisherHeader class >> verificationDictionary [ 
	
	^super verificationDictionary removeKey: 'callerId';
			yourself. 
]

{ #category : #accessing }
PhaROSHSPublisherHeader >> latching [
	^self optativeAt: 'latching'.
]

{ #category : #accessing }
PhaROSHSPublisherHeader >> latching: aBoolean [ 
	^self at: 'latching' put: aBoolean.
]

{ #category : #comparing }
PhaROSHSPublisherHeader >> topic [
	^self at:'topic'.
]

{ #category : #accessing }
PhaROSHSPublisherHeader >> topic: aTopicName [
	^self at:'topic' put: aTopicName.
]
