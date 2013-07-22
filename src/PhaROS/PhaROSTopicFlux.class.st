"
PhaROSTopicFlux is an object that represents the receiving time of a message. It allows too choose which messages process and also allows an easy previous transformation from the basic type of the message to what the callback needs for execute. 
Basing the mechanism of callback executing in the following method

receive: aMessage from: aChannel
	(self imInterestedIn: aMessage from: aChannel) ifTrue: [
		lastTimeStamp := DateAndTime now.
		self redirect: (self adapt: aMessage ) from: aChannel at: (self fetchStamp: aMessage).
	].


#imInterestedIn:from:
	Is based on a given conditional block.

#adapt:
	It takes the message and return a transformation. 
	It is based on a given adaption.  < PhaROSMessageAdapter | PhaROSFilter | PhaROSConverter >
	
#redirect:from:at:
	It takes the adapted message, the channel and the timestamp if it exists and give them to the callback
	It is based on the given callback
	



"
Class {
	#name : #PhaROSTopicFlux,
	#superclass : #Object,
	#instVars : [
		'adapter',
		'condition',
		'callback',
		'lastTimeStamp'
	],
	#classInstVars : [
		'defaultAdapter',
		'defaultConditional'
	],
	#category : #'PhaROS-TopicHandlers'
}

{ #category : #'as yet unclassified' }
PhaROSTopicFlux class >> defaultAdapter [ 
	^ defaultAdapter.
]

{ #category : #'as yet unclassified' }
PhaROSTopicFlux class >> defaultConditional [ 
	^ defaultConditional 
]

{ #category : #'as yet unclassified' }
PhaROSTopicFlux class >> initialize [ 
	defaultAdapter :=  #value.
	defaultConditional := [ true ]. 
]

{ #category : #dispatching }
PhaROSTopicFlux >> adapt: aMessage [
	^ adapter adapt: aMessage.
]

{ #category : #accessing }
PhaROSTopicFlux >> adapter [
	^ adapter.
]

{ #category : #accessing }
PhaROSTopicFlux >> adapter: anAdaption [
	adapter ifNil: [
		adapter := anAdaption adaptToAdapter.		
	] ifNotNil: [
		adapter \> anAdaption.
	]
	
]

{ #category : #accessing }
PhaROSTopicFlux >> callback: aCallback [
	callback := aCallback
]

{ #category : #accessing }
PhaROSTopicFlux >> condition [ 
	^ condition 
]

{ #category : #accessing }
PhaROSTopicFlux >> condition: aCondition [
	condition := aCondition.
]

{ #category : #dispatching }
PhaROSTopicFlux >> fetchStamp: aMessage [
	^ (aMessage hasAttribute: #header) ifTrue: [ aMessage header stamp asDateAndTime ] ifFalse: [ DateAndTime now ].
]

{ #category : #accessing }
PhaROSTopicFlux >> for: aBlockClosure [ 
	self callback: aBlockClosure.
	
]

{ #category : #dispatching }
PhaROSTopicFlux >> imInterestedIn: aMessage from: aChannel [
	^ condition cull: aMessage cull: aChannel.
]

{ #category : #dispatching }
PhaROSTopicFlux >> lastTimeStamp [ 
	^lastTimeStamp 
	
]

{ #category : #dispatching }
PhaROSTopicFlux >> printOn: aStream [

	aStream nextPutAll: ' For all messages that '.
	condition printOn: aStream.
	aStream nextPutAll: String cr.
	aStream nextPutAll: ' with value defined as '.
	adapter printOn: aStream.
	aStream nextPutAll: String cr.
	aStream nextPutAll: ' is executed '.
	callback printOn: aStream.
]

{ #category : #dispatching }
PhaROSTopicFlux >> receive: aMessage from: aChannel [
	(self imInterestedIn: aMessage from: aChannel) ifTrue: [
		lastTimeStamp := DateAndTime now.
		self redirect: (self adapt: aMessage ) from: aChannel at: (self fetchStamp: aMessage).
	].



]

{ #category : #dispatching }
PhaROSTopicFlux >> redirect: anAdaptedMessage from: aChannel at: aTimeStamp [ 
	^ callback receive: anAdaptedMessage from: aChannel at: aTimeStamp .

]
