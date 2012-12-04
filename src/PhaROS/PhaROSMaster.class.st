Class {
	#name : #PhaROSMaster,
	#superclass : #Object,
	#instVars : [
		'masterXmlRpc',
		'topics',
		'nodes'
	],
	#classVars : [
		'MasterInstances'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #'as yet unclassified' }
PhaROSMaster class >> initialize [ 
	MasterInstances := Dictionary new. 
]

{ #category : #construction }
PhaROSMaster class >> instances [
	^ MasterInstances.
]

{ #category : #service }
PhaROSMaster class >> stopAndUnregisterUrl: anUrlString [
	MasterInstances at: anUrlString ifPresent: [
		: master | 
		master stop.
		MasterInstances removeKey: anUrlString.
	].
	Smalltalk garbageCollect.

]

{ #category : #construction }
PhaROSMaster class >> unregisterUrl: anUrlString [ 
	MasterInstances at: anUrlString ifPresent: [
		MasterInstances removeKey: anUrlString .
	]
]

{ #category : #'as yet unclassified' }
PhaROSMaster class >> url: anUrl [ 
	^MasterInstances at: anUrl ifAbsentPut:[
		self new url: anUrl; yourself.
	]
	

]

{ #category : #construction }
PhaROSMaster >> create: aNodeClass named: name domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort [ 
	| node |
	self verifyName: name.
	node := aNodeClass name: name domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort master: self .
	self registerNode: node.
	^ node.
	
]

{ #category : #construction }
PhaROSMaster >> create: aNodeClass named: name domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort delegate: aReceiverDelegateOrBlock [
	| node |
	self verifyName: name.
	node := aNodeClass name: name domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort master: self delegate: aReceiverDelegateOrBlock.
	self registerNode: node.
	^ node.
	
]

{ #category : #construction }
PhaROSMaster >> create: aSouledNodeClass named: name domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort soul: aBlock [
	| node |
	self verifyName: name.
	node := aSouledNodeClass name: name domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort master: self soul: aBlock.
	self registerNode: node.

	^ node.
	
]

{ #category : #construction }
PhaROSMaster >> create: aSouledNodeClass named: name domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort soul: aBlock delegate: aReceiverDelegateOrBlock [
	| node |
	self verifyName: name.
	node := aSouledNodeClass name: name domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort master: self soul: aBlock delegate: aReceiverDelegateOrBlock.
	self registerNode: node.

	^ node.
	
]

{ #category : #construction }
PhaROSMaster >> create: aNodeClass named: name domain: aDomain xmlRpcPort: aXmlRpcPort [ 
	| node |
	self verifyName: name.
	node := aNodeClass name: name domain: aDomain xmlRpcPort: aXmlRpcPort master: self .
	self registerNode: node.
	
	^ node.
	
]

{ #category : #'API-Data-Mutators' }
PhaROSMaster >> deleteParam: aCallerId named: aParameterName [ 
	^ masterXmlRpc deleteParam: aCallerId named: aParameterName.
	
	
]

{ #category : #'API-Data-Accessors' }
PhaROSMaster >> getParam: aCallerId named: aParameterName [
	^ masterXmlRpc getParam: aCallerId named: aParameterName.
	
	
]

{ #category : #'API-Data-Accessors' }
PhaROSMaster >> getParamNames: aCallerId [
	^ masterXmlRpc getParamNames: aCallerId.


	
]

{ #category : #'API-Data-Accessors' }
PhaROSMaster >> getPublishedTopics: aCallerId [
	^ (self getSystemState: aCallerId) publishedTopics.

	
]

{ #category : #'API-Data-Accessors' }
PhaROSMaster >> getPublisherTopics: aCallerId [
	^ (self getSystemState: aCallerId) publisherTopics.

	
]

{ #category : #'API-Data-Accessors' }
PhaROSMaster >> getSubscriberTopics: aCallerId [
	^ (self getSystemState: aCallerId) subscriberTopics.

	
]

{ #category : #'API-Data-Accessors' }
PhaROSMaster >> getSystemState: aCallerId [
	^PhaROSSystemState from: (masterXmlRpc getSystemState: aCallerId).
]

{ #category : #'API-Data-Accessors' }
PhaROSMaster >> getTopicType: aByteString [ 
	aByteString  = '/scan' ifTrue: [
		^ 'sensor_msgs/LaserScan'.
	].
	aByteString  = '/tf' ifTrue: [
		^ 'tf/tfMessage'.
	].
	aByteString  = '/pose' ifTrue: [
		^ 'geometry_msgs/PoseStamped'.
	].
	^(self getTopicTypes:'/anArbitraryId') at: aByteString ifAbsent: [ 
		self error: 'There''s no topic named ', aByteString 
	].
]

{ #category : #'API-Data-Accessors' }
PhaROSMaster >> getTopicTypes: aCallerId [
	^ masterXmlRpc getTopicTypes: aCallerId.
]

{ #category : #'API-Data-Accessors' }
PhaROSMaster >> getUri: aCallerId [
	^ masterXmlRpc getUri: aCallerId.

]

{ #category : #'API-Data-Accessors' }
PhaROSMaster >> hasParam: aCallerId named: aParameterName [

	^ masterXmlRpc hasParam: aCallerId named: aParameterName


	
]

{ #category : #construction }
PhaROSMaster >> initialize [ 
	super initialize.
	nodes := Dictionary new. 
	topics := Dictionary new.
]

{ #category : #API }
PhaROSMaster >> lookupNode: nodeName [
	^ nodes at: nodeName ifAbsentPut:[
		self error: ' No local node ', nodeName.
	 ].
	
]

{ #category : #API }
PhaROSMaster >> lookupNode: nodeName with: aCallerId [
	^ nodes at: nodeName ifAbsentPut:[
		PhaROSProxy url: (masterXmlRpc lookupNode: nodeName with: aCallerId).	
	 ].
	
]

{ #category : #API }
PhaROSMaster >> lookupService: serviceName with: aCallerId [
	| serviceUriString |
	serviceUriString := masterXmlRpc lookupService: serviceName with: aCallerId.
	^PhaROSServiceProxy serviceName: serviceName uriFrom: serviceUriString
	
]

{ #category : #'API-Data-Accessors' }
PhaROSMaster >> lookupTopic: aTopicName [

	^ topics at: aTopicName ifAbsentPut:[
		PhaROSTopic build: aTopicName asking: self.
	  ].
]

{ #category : #'as yet unclassified' }
PhaROSMaster >> registerNode: aNode [
	nodes at: aNode name put: aNode .
]

{ #category : #'API-Registration' }
PhaROSMaster >> registerPublisher: aCallerId to: aTopicName with: aTopicMessageType andCallerUri: anUri [
	^ masterXmlRpc registerPublisher: aCallerId to: aTopicName with: aTopicMessageType andCallerUri: anUri.

]

{ #category : #'API-Registration' }
PhaROSMaster >> registerSubscriber: aCallerId to: aTopicName with: aTopicMessageType andCallerUri: anUri [
	^ masterXmlRpc registerSubscriber: aCallerId to: aTopicName with: aTopicMessageType andCallerUri: anUri.

]

{ #category : #'API-Data-Mutators' }
PhaROSMaster >> setParam: aCallerId named: aParameterName with: anObject [
	^ masterXmlRpc setParam: aCallerId named: aParameterName with: anObject.
]

{ #category : #service }
PhaROSMaster >> stop [
	nodes valuesDo:#stop.
	topics valuesDo:#stop.
	nodes removeAll.
	topics removeAll.
	
]

{ #category : #accessing }
PhaROSMaster >> typeFactory: aTypeId [ 
	^ PhaROSTypeBrowser instance definition: aTypeId
]

{ #category : #registration }
PhaROSMaster >> unregisterNode: aRoStNode [ 
	nodes removeKey: aRoStNode name ifAbsent: [].
]

{ #category : #'API-Registration' }
PhaROSMaster >> unregisterPublisher: aCallerId from: aTopicName andCallerUri: anUri [
	^ masterXmlRpc unregisterPublisher: aCallerId from: aTopicName andCallerUri: anUri.

]

{ #category : #'API-Registration' }
PhaROSMaster >> unregisterSubscriber: aCallerId from: aTopicName andCallerUri: anUri [
	^ masterXmlRpc unregisterSubscriber: aCallerId from: aTopicName andCallerUri: anUri.

]

{ #category : #accessing }
PhaROSMaster >> url: anUrl [
	masterXmlRpc := PhaROSMasterProxy url: anUrl.
]

{ #category : #'as yet unclassified' }
PhaROSMaster >> verifyName: aName [
	nodes at: aName ifPresent: [
		self error: ' Cannot be two nodes with the same name in a network '.
	] .
]
