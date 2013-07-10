Class {
	#name : #PhaROSTopicTests,
	#superclass : #PhaROSBaseCase,
	#category : #'PhaROS-Kernel-Test'
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
		me sendTo: '/turtle1/command_velocity' a: [ : msg |
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
	
	node := controller create: PhaROSTestNode  named: '/TestNode' domain: '127.0.0.1' xmlRpcPort:  6123.	
	


	publisherNode := controller  create: PhaROSBlockNode named: '/PublisherTestNode' domain: '127.0.0.1' tcpPort:  9999  xmlRpcPort:  6127 soul: [
		: me |
		me sendTo: '/turtle1/pose' a: [ : msg |
			otopic := me topics at: '/turtle1/pose'.
			ochannel := otopic outputChannels at: me xmlRpcUrl.
		].
	].

	publisherNode execute. 
	node subscriberBehavior: [
		:aMessage :aChannel  |
		ichannel := aChannel.
		itopic := node topics at: '/turtle1/pose'.
		semaphore signal.
	].

	node interestedIn: '/turtle1/pose'.

	semaphore waitTimeoutSeconds: 5.

	
	(Delay forMilliseconds: 1500) wait.

	self assert: itopic == otopic. 

	self assert: ochannel subscribers size = 1.
	self assert: ichannel subscribers size = 1.
	
	self assert: ochannel owner = publisherNode publisher.
	self assert: ochannel subscribers anyOne = node subscriber.
	 
	self assert: ichannel owner name =  '/turtlesim'.
	self assert:( ichannel owner isKindOf: PhaROSExternalNode )
	
	
]

{ #category : #'as yet unclassified' }
PhaROSTopicTests >> testTopicInputChannelConfiguration [
	| node  topic channel semaphore |

	semaphore := Semaphore new.
	
	node := controller create: PhaROSTestNode  named: '/TestNode' domain: '127.0.0.1' xmlRpcPort:  6123.	
	
	node subscriberBehavior: [
		:aMessage :aChannel  |
		channel := aChannel.
		topic := node topics at: '/turtle1/pose'.
		semaphore signal.
	].

	node interestedIn: '/turtle1/pose'.
	semaphore waitTimeoutSeconds: 5.


	self assert: topic = channel topic.
	self assert: channel owner  topic = topic.
	self assert: (channel owner isKindOf: PhaROSExternalNode ).
	self assert: (channel isKindOf: PhaROSInPutChannel ).
	self assert: topic inputChannels size = 1. 
	self assert: channel subscribers size = 1.
	self assert: channel owner  name = '/turtlesim'.
	self assert: channel subscribers anyOne = node subscriber.

]

{ #category : #'as yet unclassified' }
PhaROSTopicTests >> testTopicOutputChannelConfiguration [
	| publisherNode  topic channel |

	publisherNode := controller  create: PhaROSBlockNode named: '/PublisherTestNode' domain: '127.0.0.1' tcpPort:  9999  xmlRpcPort:  6127 soul: [
		: me |
		me sendTo: '/turtle1/command_velocity' a: [ : msg |
			topic := me topics at: '/turtle1/command_velocity'.
			channel := topic outputChannels at: me xmlRpcUrl.
		].
	].
	publisherNode execute. 
	
	(Delay forMilliseconds: 1500) wait.
	
	self assert: topic notNil.
	self assert: topic outputChannels size = 1.
	self assert: (channel isKindOf: PhaROSOutPutChannel) .
	self assert: channel owner == publisherNode publisher.
	self assert: channel subscribers size = 1.
	self assert: (channel subscribers anyOne isKindOf: PhaROSExternalNode ).
	self assert: channel subscribers anyOne topic == topic.
	self assert: channel subscribers anyOne name = '/turtlesim'.
	
	
]
