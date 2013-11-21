Class {
	#name : #PhaROSTopicTests,
	#superclass : #PhaROSBaseCase,
	#category : #'PhaROS-Kernel-Graphical-Test'
}

{ #category : #'as yet unclassified' }
PhaROSTopicTests >> setUp [ 

	super setUp.	
	self startUpMaster.
	self startUpTurtle.
	
]

{ #category : #'as yet unclassified' }
PhaROSTopicTests >> testMessageType [
	| publisherNode  type |

	publisherNode := controller  create: PhaROSBlockNode named: '/PublisherTestNode' domain: '127.0.0.1' tcpPort:  9999  xmlRpcPort:  6127 soul: [
		: me |
		me sendTo: '/turtle1/command_velocity' typedAs: 'turtlesim/Velocity' a: [ : msg |
			type := msg class. 
		].
	].
	publisherNode execute. 
	
	self assert: type = TurtlesimVelocity.
]

{ #category : #'as yet unclassified' }
PhaROSTopicTests >> testTopicInOutputChannelConfiguration [
	| node  itopic ichannel otopic ochannel semaphore publisherNode |

	semaphore := Semaphore new.
	
	node := controller create: PhaROSTestNode  named: '/TestNode' domain: '127.0.0.1' tcpPort: 9930 xmlRpcPort:  6123.	
	


	publisherNode := controller  create: PhaROSBlockNode named: '/PublisherTestNode' domain: '127.0.0.1' tcpPort:  9999  xmlRpcPort:  6127 soul: [
		: me |
		me sendTo: '/turtle1/pose'  typedAs: 'turtlesim/Pose' a: [ : msg |
			otopic := controller master lookupTopic: '/turtle1/pose'.
			ochannel := otopic outputchannels detect: [ : o | o xmlurl = 'http://127.0.0.1:6127/' ].
		].
	].

	publisherNode execute. 
	
	
	node subscriberBehavior: [
		:aMessage :aChannel  |
		ichannel := aChannel.
		itopic := controller master lookupTopic: '/turtle1/pose'.
		semaphore signal.
	].

	node subscriber: '/turtle1/pose' typedAs: 'turtlesim/Pose' .

	1 second asDelay wait. 
	
	publisherNode execute. 
	
	semaphore waitTimeoutSeconds: 5.

	
	(Delay forMilliseconds: 1500) wait.

	self assert: itopic == otopic. 

	self assert: ochannel subscribers size = 1.
	self assert: ichannel publishers size = 2.
	
	self assert: ochannel owner = publisherNode.
	self assert: (ochannel subscribers anyOne isKindOf: PhaROSInternalNodeLink).
	self assert: ( ochannel subscribers allSatisfy: [: s | s channel owner = node ]).
	 
	self assert: ichannel owner name =  '/TestNode'.
	self assert:( ichannel owner isKindOf: PhaROSTestNode )
	
	
]

{ #category : #'as yet unclassified' }
PhaROSTopicTests >> testTopicInputChannelConfiguration [
	| node  topic channel semaphore |

	semaphore := Semaphore new.
	
	node := controller create: PhaROSTestNode  named: '/TestNode' domain: '127.0.0.1' tcpPort: 9983 xmlRpcPort:  6123.	
	
	node subscriberBehavior: [
		:aMessage :aChannel  |
		channel := aChannel.
		topic := controller master lookupTopic: '/turtle1/pose'.
		semaphore signal.
	].

	node subscriber: '/turtle1/pose' typedAs: 'turtlesim/Pose' .
	semaphore waitTimeoutSeconds: 5.


	self assert: topic = channel topic.
	self assert: (channel owner isKindOf: PhaROSTestNode ).
	self assert: (channel isKindOf: PhaROSInPutChannel ).
	self assert: topic inputchannels size = 1. 
	self assert: channel publishers size = 1.
	self assert: channel owner  name = '/TestNode'.
	

]

{ #category : #'as yet unclassified' }
PhaROSTopicTests >> testTopicOutputChannelConfiguration [
	| publisherNode  topic channel |

	publisherNode := controller  create: PhaROSBlockNode named: '/PublisherTestNode' domain: '127.0.0.1' tcpPort:98298  xmlRpcPort: 64465 soul: [
		: me |
		
		me sendTo: '/turtle1/command_velocity'  typedAs: 'turtlesim/Velocity' a: [ : msg |
			topic := controller master lookupTopic: '/turtle1/command_velocity'.
			channel := topic outputchannels detect: [ : o | o xmlurl = 'http://127.0.0.1:64465/' ].
		].
	].
	publisherNode execute. 
	
	
	
	(Delay forMilliseconds: 1500) wait.
	
	publisherNode execute. 
	
	
	self assert: topic notNil.
	self assert: topic outputchannels size = 1.
	self assert: (channel isKindOf: PhaROSOutPutChannel) .
	self assert: channel owner == publisherNode .
	self assert: channel subscribers  size = 1.
	self assert: (channel subscribers anyOne isKindOf: PhaROSExternalSubscriberNode ).
	self assert: channel subscribers anyOne topic == topic.
	self assert: channel subscribers anyOne name = '/turtlesim'.
	
	
]
