Class {
	#name : #PhaROSOutPutChannel,
	#superclass : #PhaROSChannel,
	#instVars : [
		'isFirstSubscriber'
	],
	#category : #'PhaROS-Kernel-Channels'
}

{ #category : #'as yet unclassified' }
PhaROSOutPutChannel class >> for: aNode into: aTopic [

	^ self new owner: aNode; topic: aTopic; startUp; yourself.
]

{ #category : #service }
PhaROSOutPutChannel >> close [
	self owner unregisterPublisherFrom: topic name.
	subscribers do: [
		: node |
		node unregisterPublisher: self owner.
	].
	self initialize.
	
]

{ #category : #private }
PhaROSOutPutChannel >> createExternalNodeFor: aMessage with: aSocket [

	
	aSocket setOption: 'TCP_NODELAY' value: (aMessage  tcpNodelay).
	self assert: aMessage topic = topic name.
	
	^ PhaROSExternalNode named: aMessage  callerId subscriberOf: topic with: aSocket. 
	
]

{ #category : #service }
PhaROSOutPutChannel >> initialize [ 
	super initialize.
	isFirstSubscriber := true.
]

{ #category : #private }
PhaROSOutPutChannel >> isFirstSubscriber [ 
	^ 	isFirstSubscriber.

]

{ #category : #testing }
PhaROSOutPutChannel >> isLatchedChannel [
	self flag: #WhatWillDoWithLatches.
	^ true.
	
]

{ #category : #tcp }
PhaROSOutPutChannel >> manageIncomingConnection: aMessage with: aSocket [

	self flag: #TypeIsParsingBadSometimes.

	Transcript show: 'Managing incoming conection!'; cr.
"	self assert: topic md5Sum = aMessage md5Sum."
"	self assert: topic type = aMessage type."

	self subscribe: (self createExternalNodeFor: aMessage with: aSocket).
	
	

]

{ #category : #testing }
PhaROSOutPutChannel >> mustSendPreviousMessagesTo: aNode [
	^ self isFirstSubscriber or: [ self isLatchedChannel ].
]

{ #category : #'message handling' }
PhaROSOutPutChannel >> newMessage [ 
	^ topic newMessage.
]

{ #category : #tcp }
PhaROSOutPutChannel >> printOn: aStream [
	aStream nextPutAll: 'OutputChannel>> ',topic name. 
]

{ #category : #testing }
PhaROSOutPutChannel >> relatedWith: aByteString [ 
	^ owner xmlRpcUrl = aByteString 
	
]

{ #category : #'message handling' }
PhaROSOutPutChannel >> sendAMessage: aMessageConfigurationBlock [
	| message |
	message := self newMessage.
	
	aMessageConfigurationBlock value: message value.
	^ self send: message.

]

{ #category : #'message handling' }
PhaROSOutPutChannel >> sendAMessage: aMessageConfigurationBlock to: aNode [
	| message |
	message := self newMessage.
	
	aMessageConfigurationBlock value: message value.
	^ self send: message to: aNode.

]

{ #category : #service }
PhaROSOutPutChannel >> startUp [ 
	owner registerTo: topic name with: topic type.
	
	
	
	
]

{ #category : #tcp }
PhaROSOutPutChannel >> subscribe: aNode [
	
	| message |	
	
	super subscribe: aNode.
	self owner onSubscribe: aNode to: self. 
	
	aNode subscribedTo: self. 
	
	(self mustSendPreviousMessagesTo: aNode) ifTrue:[  
		sent do:  [ 	:msg | 
				aNode receive: msg  from: self. 
				
		].
	].

	isFirstSubscriber := false.
]

{ #category : #tcp }
PhaROSOutPutChannel >> topic: aTopic [
	super topic: aTopic.
	aTopic registerOutputChannel: self at: owner xmlRpcUrl.
]
