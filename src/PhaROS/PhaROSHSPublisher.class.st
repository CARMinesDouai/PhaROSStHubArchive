Class {
	#name : #PhaROSHSPublisher,
	#superclass : #PhaROSHSTyped,
	#category : #'PhaROS-Network-Tcp-Messages'
}

{ #category : #accessing }
PhaROSHSPublisher class >> verificationDictionary [ 
	
	^super verificationDictionary removeKey: 'callerId';
			yourself. 
]

{ #category : #accessing }
PhaROSHSPublisher >> latching [
	^self optativeAt: 'latching'.
]

{ #category : #accessing }
PhaROSHSPublisher >> latching: aBoolean [ 
	^self at: 'latching' put: aBoolean.
]

{ #category : #comparing }
PhaROSHSPublisher >> topic [
	^self at:'topic'.
]

{ #category : #accessing }
PhaROSHSPublisher >> topic: aTopicName [
	^self at:'topic' put: aTopicName.
]
