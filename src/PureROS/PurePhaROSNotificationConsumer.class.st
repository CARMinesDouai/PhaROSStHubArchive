Class {
	#name : #PurePhaROSNotificationConsumer,
	#superclass : #PurePhaROSNode,
	#category : #PureROS
}

{ #category : #'as yet unclassified' }
PurePhaROSNotificationConsumer >> receive: aMessage from: aChannel [ 
	PNGEncodedMessage deliverData: aMessage value to: robot. 
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationConsumer >> setUp [ 
	self interestedIn: '/pure_stream' typedAs:'pharos/Stream'.
]
