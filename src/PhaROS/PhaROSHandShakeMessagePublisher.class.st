Class {
	#name : #PhaROSHandShakeMessagePublisher,
	#superclass : #PhaROSTypedHandShakeMessage,
	#category : #'PhaROS-Kernel-Tcp'
}

{ #category : #accessing }
PhaROSHandShakeMessagePublisher >> latching [
	^self optativeAt: 'latching'.
]

{ #category : #accessing }
PhaROSHandShakeMessagePublisher >> latching: aBoolean [ 
	^self at: 'latching' put: aBoolean.
]

{ #category : #comparing }
PhaROSHandShakeMessagePublisher >> topic [
	^self at:'topic'.
]

{ #category : #accessing }
PhaROSHandShakeMessagePublisher >> topic: aTopicName [
	^self at:'topic' put: aTopicName.
]

{ #category : #accessing }
PhaROSHandShakeMessagePublisher >> verificationDictionary [ 
	
	^super verificationDictionary removeKey: 'callerId';
			yourself. 
]
