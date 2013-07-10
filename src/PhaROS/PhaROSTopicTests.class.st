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
	self startUpTurtle .
	publisherNode := master  create: PhaROSBlockNode named: '/PublisherTestNode' domain: '127.0.0.1' tcpPort:  9999  xmlRpcPort:  6127 soul: [
		: me |
		me sendTo: '/turtle1/command_velocity' a: [ : msg |
			type := msg class. 
		].
	].
	publisherNode execute. 
	
	self assert: type = TurtlesimVelocity.
]
