"
This node represent a basic node in the ROS environment. 
	
	It is related with a XMLRPC Server and a TCP server. 
	
	Is thinked to be subclassed, and specialized for each case. 
	
	It counts with messages for publishing and subscribing  
	
	
	publishing:
	
	#sendTo: aTopicID a: [:msg | ""configure here your message ""]
	#sendTo: aTopicID typedAs: aTypeID a: [:msg |  ""configure here your message ""]. 
	
	subscribing:
	
	#interestedIn: aTopicID.
	#interestedIn: aTopicID typedAs: aTypeID. 
	
	In this version, you need to set also a delegate to let the node know what to do when it receives a message from outside. 
	
	#receiverDelegate: [ :msg :chn | ].
"
Class {
	#name : #PhaROSNode,
	#superclass : #Object,
	#instVars : [
		'master',
		'topics',
		'domain',
		'xmlRpcPort',
		'name',
		'slave',
		'publisher',
		'subscriber',
		'receiverDelegate',
		'heartRate',
		'heartbeatActions',
		'heartbeat'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #'as yet unclassified' }
PhaROSNode class >> name: aName domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort master: aMaster [

	^ super new 	name: aName; 
				domain: aDomain ; 
				tcpPort: aTcpPort ; 
				xmlRpcPort: aXmlRpcPort; 
				master: aMaster;
				start; 
				yourself.
	
]

{ #category : #'as yet unclassified' }
PhaROSNode class >> name: aName domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort master: aMaster delegate: aReceiverDelegateOrBlock [
	^super new 	name: aName; 
				domain: aDomain ; 
				tcpPort: aTcpPort ; 
				xmlRpcPort: aXmlRpcPort; 
				master: aMaster;
				receiverDelegate: aReceiverDelegateOrBlock;
				start; 
				yourself.
]

{ #category : #construction }
PhaROSNode class >> name: aName domain: aDomain xmlRpcPort: aXmlRpcPort  master: aMaster [ 
	^self name: aName domain: aDomain xmlRpcPort: aXmlRpcPort  master: aMaster delegate:[].
]

{ #category : #construction }
PhaROSNode class >> name: aName domain: aDomain xmlRpcPort: aXmlRpcPort  master: aMaster delegate: aReceiverDelegateOrBlock [ 
		^super new 	name: aName; 
				domain: aDomain ; 
				xmlRpcPort: aXmlRpcPort; 
				master: aMaster;
				receiverDelegate: aReceiverDelegateOrBlock;
				start; 
				yourself.
]

{ #category : #'as yet unclassified' }
PhaROSNode class >> new [ 
	self error: ' You must used #name:domain:tcpPort:xmlRpcPort:master:  in order to instanciate a PhaROSNode. ' 
]

{ #category : #service }
PhaROSNode >> destroy [
	self stop.
	master unregisterNode: self.
	master := nil.
	topics removeAll. 
	topics := nil. 
	domain := nil. 
	xmlRpcPort := nil.
	name := nil. 
	slave owner: nil.
	slave := nil.
	publisher := nil. 
	subscriber := nil. 
	
	
]

{ #category : #accessing }
PhaROSNode >> domain [
	^ domain.
]

{ #category : #accessing }
PhaROSNode >> domain: anIp [
	domain := anIp.
]

{ #category : #heartbeat }
PhaROSNode >> enableHeartbeatAt: aRate [
	heartRate set: aRate . 
	heartbeat ifNil: [ heartbeat := (self paralellize looping heartbeat) asStickyReference ].
]

{ #category : #heartbeat }
PhaROSNode >> heartbeat [
	heartbeatActions do: [: c | 
		[ c value: self ] on: Error do: [ : e | 
			Transcript show: 'Error calling callback ', e messageText; cr.
		] 
	].
	(Delay forRate: heartRate get) wait.
]

{ #category : #accessing }
PhaROSNode >> initialize [ 
	slave := PhaROSSlave for: self.
	topics := Dictionary new.
	receiverDelegate := [].
	heartbeat := Set new.
	heartRate := 1 asThreadsafeReference.
]

{ #category : #service }
PhaROSNode >> interestedIn: aTopicName [
	^ self subscriber interestedIn: (self lookupTopic: aTopicName)
]

{ #category : #'as yet unclassified' }
PhaROSNode >> interestedIn: aTopicName typedAs: aTypeId [
	^ self subscriber interestedIn: (self lookupTopic: aTopicName typedAs: aTypeId)
]

{ #category : #testing }
PhaROSNode >> isRelatedWith: aTopicName [
	^ topics includesKey: aTopicName.
	
]

{ #category : #lookup }
PhaROSNode >> lookupTopic: aTopicName [
	^ self topics at: aTopicName ifAbsentPut: [
		self master lookupTopic: aTopicName.	
	].

]

{ #category : #'as yet unclassified' }
PhaROSNode >> lookupTopic: aTopicName typedAs: aTypeId [
	^ self topics at: aTopicName ifAbsentPut: [
		self master lookupTopic: aTopicName typedAs: aTypeId.	
	].

]

{ #category : #accessing }
PhaROSNode >> master [
	^ master.
]

{ #category : #accessing }
PhaROSNode >> master: aMaster [ 
	master := aMaster.
]

{ #category : #accessing }
PhaROSNode >> name [ 
	^ name.
]

{ #category : #accessing }
PhaROSNode >> name: aNodeName [ 
	name := aNodeName.
]

{ #category : #'as yet unclassified' }
PhaROSNode >> onSubscribe: aNode to: aChannel [
	"when a node is subscribed to a topic that is broadcasted by this node, you receive this message"
]

{ #category : #output }
PhaROSNode >> printOn: aStream [
	aStream nextPutAll: 'Node-', self name.
]

{ #category : #output }
PhaROSNode >> publisher [ 
	^ publisher ifNil: [ publisher := PhaROSPublisher for: self ].
]

{ #category : #service }
PhaROSNode >> receive: aMessage from: aChannel [
	^ receiverDelegate receive: aMessage from: aChannel.

]

{ #category : #'as yet unclassified' }
PhaROSNode >> receiverDelegate: aReceiverDelegateOrBlock [
	receiverDelegate := aReceiverDelegateOrBlock. 
	
]

{ #category : #heartbeat }
PhaROSNode >> registerHeartbeat: aCallback [
	heartbeatActions add: aCallback.
]

{ #category : #output }
PhaROSNode >> sendTo: aTopicName a: aMessageConfigurationBlock [
	^self publisher sendTo: (self lookupTopic: aTopicName) a: aMessageConfigurationBlock.
	
	
]

{ #category : #output }
PhaROSNode >> sendTo: aTopicName typedAs: aTypeId a: aMessageConfigurationBlock [
	^self publisher sendTo: (self lookupTopic: aTopicName typedAs: aTypeId) a: aMessageConfigurationBlock.
	
	
]

{ #category : #accessing }
PhaROSNode >> slave [ 
	^slave.
]

{ #category : #service }
PhaROSNode >> start [
	self startXmlService.
	self startPieces.
	
	
]

{ #category : #service }
PhaROSNode >> startPieces [
	publisher ifNotNil: [ publisher start.]
]

{ #category : #service }
PhaROSNode >> startXmlService [ 

	XMLRPCService atPort: self xmlRpcPort 
					serve: {
						#getBusInfo -> {self slave -> #getBusInfo: } .
						#getPid -> { self slave -> #getPid: } .
						#requestTopic -> { self slave -> #requestTopic:for:availableFor: } .
						#getPublications -> { self slave -> #getPublications: }
					} asXMLRPCHttpModule 
					at:'/' .
	

	
]

{ #category : #service }
PhaROSNode >> stop [
	self master unregisterNode: self.
	self unregisterFromAllTopics.
	self stopXmlService.
	self stopPublisher.
	
	
	
]

{ #category : #service }
PhaROSNode >> stopPublisher [
	publisher ifNotNil: [ publisher stop. publisher := nil ].
]

{ #category : #service }
PhaROSNode >> stopXmlService [
	self flag:#CouldBeALotOfServicesInTheSamePort.
	XMLRPCService destroy: self xmlRpcPort.
]

{ #category : #accessing }
PhaROSNode >> subscriber [
	^ subscriber ifNil: [ subscriber := PhaROSSubscriber for: self ].
]

{ #category : #accessing }
PhaROSNode >> tcpPort: aSmallInteger [ 
	self publisher tcpPort: aSmallInteger.
]

{ #category : #accessing }
PhaROSNode >> topics [ 
	^topics.
]

{ #category : #service }
PhaROSNode >> unregisterFromAllTopics [
	subscriber ifNotNil: [ subscriber unregisterFromAllTopics].
	publisher ifNotNil: [ publisher unregisterFromAllTopics].
	self topics removeAll.

]

{ #category : #service }
PhaROSNode >> unregisterPublisher: aPublisherNode [
	self halt.
	
]

{ #category : #accessing }
PhaROSNode >> xmlRpcPort [
	^ xmlRpcPort
]

{ #category : #accessing }
PhaROSNode >> xmlRpcPort: aXmlRpcPort [ 
	xmlRpcPort := aXmlRpcPort.
]

{ #category : #accessing }
PhaROSNode >> xmlRpcUrl [
	^ 'http://', domain, ':', xmlRpcPort asString , '/'.
]
