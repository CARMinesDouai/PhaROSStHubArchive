Class {
	#name : #PhaROSNodeTest,
	#superclass : #PhaROSBaseCase,
	#instVars : [
		'node',
		'commandVelocity'
	],
	#category : #'PhaROSTest-Kernel-Graphical'
}

{ #category : #'as yet unclassified' }
PhaROSNodeTest >> setUp [ 

	super setUp.	
	self startUpMaster.
	self startUpTurtle.
	
	node := controller create: PhaROSTestNode  named: '/TestNode' domain: '127.0.0.1' tcpPort: 92837 xmlRpcPort:  634987.	
]

{ #category : #'as yet unclassified' }
PhaROSNodeTest >> testInterestedNode [
	| asserts semaphore |
	
	
	semaphore := Semaphore new.
	asserts := { false . false . false }.
	
	
	node subscriberBehavior: [
		:aMessage :aChannel  |
		
		asserts at:1 put: ( aChannel topic name = '/turtle1/pose').
		asserts at:2 put: ( aMessage value isKindOf: ( Smalltalk at:#TurtlesimPose ) ).
		asserts at:3 put: ( aChannel isKindOf: PhaROSInPutChannel ).
		
		semaphore signal.
	].

	node interestedIn: '/turtle1/pose' typedAs: 'turtlesim/Pose'.
	semaphore waitTimeoutSeconds: 5.

	asserts do: [ :b | self assert: b ].

]

{ #category : #'as yet unclassified' }
PhaROSNodeTest >> testPublisherNode [
	| publisherNode  asserts semaphore |

	asserts := { false . false . false . false }.
	
	semaphore := Semaphore new.
	
	publisherNode := controller  create: PhaROSBlockNode named: '/PublisherTestNode' domain: '127.0.0.1' tcpPort:  9456  xmlRpcPort:  6098 soul: [
		: me |
		me sendTo: '/turtle1/command_velocity' typedAs:'turtlesim/Velocity' a: [ :msg |
			msg linear: 1.0. 
			msg angular: 1.1. 
		].
	].

	node subscriberBehavior: [
		:aMessage :aChannel  |
		asserts at:1 put: ( aChannel topic name = '/turtle1/command_velocity').
		asserts at:2 put: ( aMessage value isKindOf: ( Smalltalk at:#TurtlesimVelocity ) ).
		asserts at:3 put: ( aChannel isKindOf: PhaROSInPutChannel ).
		asserts at:4 put: (
			aMessage value linear = 1.0 and: [
				aMessage value angular = 1.1	
			]		
		).
		semaphore signal. 
	].


	publisherNode execute.

	node subscriber: '/turtle1/command_velocity' typedAs: 'turtlesim/Velocity' .	

	1 second asDelay wait.	


	publisherNode execute.
	publisherNode execute.	
	
	semaphore waitTimeoutSeconds: 10.
	
	asserts do: [ :b | self assert: b ].

	








]
