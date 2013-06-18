Class {
	#name : #PhaROSPublisher,
	#superclass : #Object,
	#instVars : [
		'owner',
		'channels',
		'tcpserver',
		'tcpPort'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #'as yet unclassified' }
PhaROSPublisher class >> for: aNode [
	^ self new owner: aNode ; yourself.
]

{ #category : #accessing }
PhaROSPublisher >> initialize [ 
	channels := Dictionary new.
]

{ #category : #'as yet unclassified' }
PhaROSPublisher >> lookupChannelFor: aTopic [
	^ channels at: aTopic name ifAbsentPut: [
		aTopic outputChannelFor: self.
	]
]

{ #category : #accessing }
PhaROSPublisher >> manageIncomingConnection: aMessage with: aSocket [ 
	self flag: #lookThisDelay.
	(Delay forMilliseconds: 500) wait.

	^ (self lookupChannelFor: (owner lookupTopic: aMessage topic)) manageIncomingConnection: aMessage with: aSocket.
	
	

]

{ #category : #events }
PhaROSPublisher >> onSubscribe: aPhaROSExternalNode to: aPhaROSOutPutChannel [ 
	owner onSubscribe: aPhaROSExternalNode to: aPhaROSOutPutChannel. 
]

{ #category : #accessing }
PhaROSPublisher >> owner: aNode [ 
	owner := aNode.
]

{ #category : #accessing }
PhaROSPublisher >> printOn: aStream [
	 aStream nextPutAll: owner name
]

{ #category : #service }
PhaROSPublisher >> registerTo: aTopicName with: aTopicType [ 
	^ owner master registerPublisher: owner name to: aTopicName with: aTopicType andCallerUri: owner xmlRpcUrl. 
]

{ #category : #'as yet unclassified' }
PhaROSPublisher >> sendTo: aTopic a: aMessageConfigurationBlock [
	( self lookupChannelFor: aTopic ) sendAMessage: aMessageConfigurationBlock.
]

{ #category : #service }
PhaROSPublisher >> start [
	tcpserver := PhaROSTcpServer startOn: self tcpPort named: owner name, ' related TCP Service- Port:', self tcpPort asString for: self.
]

{ #category : #service }
PhaROSPublisher >> stop [

	channels valuesDo: #close.
	self stopTcpService.
	self initialize.
]

{ #category : #service }
PhaROSPublisher >> stopTcpService [
	tcpserver ifNotNil:[
		PhaROSTcpServer stop: tcpserver.
		tcpserver := nil.
	].
	
]

{ #category : #accessing }
PhaROSPublisher >> tcpPort [
	^ tcpPort.
]

{ #category : #accessing }
PhaROSPublisher >> tcpPort: aTcpPort [
	tcpPort := aTcpPort.
	
]

{ #category : #accessing }
PhaROSPublisher >> tcpserver [

	^ tcpserver.

]

{ #category : #accessing }
PhaROSPublisher >> unregisterFromAllTopics [ 
	channels do: [ : ch | ch unsubscribe: self ].
	channels removeAll.

]

{ #category : #service }
PhaROSPublisher >> unregisterPublisherFrom: aTopicName [ 
	owner master unregisterPublisher: owner name from: aTopicName andCallerUri: owner xmlRpcUrl.
]

{ #category : #accessing }
PhaROSPublisher >> xmlRpcUrl [
	^ owner xmlRpcUrl.
]
