"
A ROS based system relies on a special node called master. The ROS master is the entry point for all other nodes, since it allows them discover each other. Because ROS master is playing a so central role, it must be launched before all other nodes. This is done by executing the roscore command line.
The ROS master acts as a naming registry. It stores topics and services registra- tion information for ROS nodes. Nodes communicate with the master to report their registration information. As these nodes communicate with the master, they can re- ceive information about other registered nodes and make connections as appropriate. The master will also make callbacks to these nodes when this registration information changes, which allows nodes to dynamically create connections as new nodes are run.
Nevertheless, nodes ""talk"" to each other directly. Indeed, the master only provides lookup information, much like a DNS server.

PhaROSMaster is the main object to interact with the ROS master, providing a clear API to:

	1- Deal with parameters 
	2- Lookup nodes
	3- Lookup topic publishers / subscribers.
	4- Lookup service providers.
	5- Register nodes into the system.
	

	In order to achive this goal, this objects count with a proxy based on the XMLRPC-Client framework, that gives a direct API to the XMLRPC service provided by the ROS Master node. 
	
      
"
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
	MasterInstances := WeakArray new
]

{ #category : #service }
PhaROSMaster class >> localhost [
	^ self url: 'http://127.0.0.1:11311/'.
]

{ #category : #'as yet unclassified' }
PhaROSMaster class >> url: anUrl [ 
	^ self new url: anUrl; yourself 

]

{ #category : #'API-Data-Mutators' }
PhaROSMaster >> deleteParam: aCallerId named: aParameterName [ 
	^ masterXmlRpc deleteParam: aCallerId named: aParameterName.
	
	
]

{ #category : #registration }
PhaROSMaster >> finalize [
	super finalize.
	self stop.
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

	aByteString  = '/odom' ifTrue: [
		^ 'nav_msgs/Odometry'.
	].

	^(self getTopicTypes:'/anArbitraryId') at: aByteString ifAbsent: [ 
		nil
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

{ #category : #'initialize-release' }
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

	^ topics at: aTopicName .
]

{ #category : #'as yet unclassified' }
PhaROSMaster >> lookupTopic: aTopicName typedAs: aTypeId [
	| topic |
	topic :=  topics at: aTopicName ifAbsentPut:[
		PhaROSTopic new name: aTopicName; type: aTypeId; typeFactory:( self typeFactory: aTypeId ) yourself.
	  ].

	topic type ifNil: [ 
		topic type: aTypeId .
		topic typeFactory:( self typeFactory: aTypeId )
	].
	self assert: topic type = aTypeId.
	^ topic.
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
	topics valuesDo:#finalize.
	nodes valuesDo:#finalize.
	nodes removeAll.
	topics removeAll.
	Smalltalk garbageCollectMost.
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
