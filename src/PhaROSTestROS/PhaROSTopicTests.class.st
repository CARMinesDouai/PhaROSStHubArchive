Class {
	#name : #PhaROSTopicTests,
	#superclass : #PhaROSBaseCase,
	#category : #'PhaROSTestROS-Kernel-Graphical'
}

{ #category : #'as yet unclassified' }
PhaROSTopicTests >> setUp [ 

	super setUp.	
	self startUpTurtle.
	
]

{ #category : #'as yet unclassified' }
PhaROSTopicTests >> testMessageType [
	| publisherNode  type  pub |

publisherNode := PhaROSBlockNode name: '/PublisherTestNode' domain: 'localhost' tcpPort:9157  xmlRpcPort: 6206 master: master soul: [].

	master registerNode: publisherNode .
	
	pub := publisherNode publisher:  '/turtle1/cmd_vel'  typedAs: 'geometry_msgs/Twist' .
	
	pub send: [ : msg |
			self halt.
			type := msg class
	].
	(Delay forMilliseconds: 1500) wait.
	pub send: [ : msg |
			self halt.
			type := msg class
	].
	
	
	
	
	
	
	self assert: type = (Smalltalk at: #Geometry_msgsTwist).
]

{ #category : #'as yet unclassified' }
PhaROSTopicTests >> testTopicInOutputChannelConfiguration [
	| node  itopic ichannel otopic ochannel semaphore publisherNode |

	semaphore := Semaphore new.
	
	node :=  PhaROSTestNode  name: '/TestNode' domain: '127.0.0.1' tcpPort: 9930 xmlRpcPort:  6123 master: master. 	
	master registerNode: node.


	publisherNode :=PhaROSBlockNode name: '/PublisherTestNode' domain: '127.0.0.1' tcpPort:  9999  xmlRpcPort:  6127 master: master soul: [
		: me |
		me sendTo: '/turtle1/pose'  typedAs: 'turtlesim/Pose' a: [ : msg |
			otopic :=  master lookupTopic: '/turtle1/pose'.
			ochannel := otopic outputchannels detect: [ : o | o xmlurl = 'http://127.0.0.1:6127/' ].
		].
	].

	master registerNode: publisherNode.
	publisherNode execute. 
	
	
	node subscriberBehavior: [
		:aMessage :aChannel  |
		ichannel := aChannel.
		itopic :=  master lookupTopic: '/turtle1/pose'.
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
	
	node := PhaROSTestNode  name: '/TestNode' domain: '127.0.0.1' tcpPort: 9983 xmlRpcPort: 63423 master: master.	
	master registerNode: node.
	node subscriberBehavior: [
		:aMessage :aChannel  |
		channel := aChannel.
		topic :=  master lookupTopic: '/turtle1/pose'.
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
	| publisherNode  topic channel pub |

	publisherNode := PhaROSBlockNode name: '/PublisherTestNode' domain: 'localhost' tcpPort:9157  xmlRpcPort: 62506 master: master soul: [].

	master registerNode: publisherNode .
	
	pub := publisherNode publisher:  '/turtle1/cmd_vel'  typedAs: 'geometry_msgs/Twist' .
	
	(Delay forMilliseconds: 1500) wait.
	
	pub send: [ : msg |
			topic :=  master lookupTopic: '/turtle1/cmd_vel'.
			channel := topic outputchannels detect: [ : o | o xmlurl = 'http://localhost:62506/' ] ifNone: [ nil ].
	].
	
	
	self assert: topic notNil.
	self assert: topic outputchannels size = 1.
	self assert: (channel isKindOf: PhaROSOutPutChannel) .
	self assert: channel owner == publisherNode .
	self assert: channel subscribers  size = 1.
	self assert: (channel subscribers anyOne isKindOf: PhaROSExternalSubscriberNode ).
	self assert: channel subscribers anyOne topic == topic.
	self assert: channel subscribers anyOne name = '/turtlesim'.
	
	
]
