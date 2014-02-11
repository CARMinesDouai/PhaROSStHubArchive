Class {
	#name : #DonatelloPackage,
	#superclass : #PhaROSPackage,
	#category : #DonatelloPackage
}

{ #category : #types }
DonatelloPackage class >> switchCommandServiceType [
	^
	ROSType service named: #Switch package: #donatello request:{
		String constant:#random value: 'random'.
		String constant:#quiet value: 'quiet'.
		String constant:#pharo value: 'pharo'.
		String constant:#pursuiter value: 'pursuiter'.
		String constant:#circular value: 'circular'.
		String named: #command.
		String named: #turtleID.
	} response: { 
	}.
]

{ #category : #types }
DonatelloPackage class >> types [ 
	^ super types, { 
		self switchCommandServiceType.

	 }
]

{ #category : #'private - algorithms' }
DonatelloPackage >> algorithmFor: aCommand [
	

	aCommand lowercase = 'random' ifTrue:[ ^ self randomHandler ].
	aCommand lowercase = 'quiet' ifTrue:[ ^ self idleHandler ].
	aCommand lowercase = 'circular' ifTrue:[ ^ self circularHandler ].
	aCommand lowercase = 'pharo' ifTrue:[ ^ self pharoHandler ].
	aCommand lowercase = 'pursuiter' ifTrue:[ ^ self pursuiterHandler ].
	
	
	^ self idleHandler.
]

{ #category : #'private - configuration' }
DonatelloPackage >> buildController [
	"This message is called by the accessor controller when the variable that stores the controller is pointing to nil.
	 If you want to make some specific configuration, as injecting nodelets, for package level, this is the place to do it. 
	Remember to not call #controller from this method, or inner this method, because #controller is the caller of this message.
	"
	^ self nodeletInjectionExample: super buildController.

]

{ #category : #'private - algorithms' }
DonatelloPackage >> circularHandler [ 

^ [ : handler |
		handler forwardAt: 1.0.
		1 seconds asDelay wait.
		[  true ] whileTrue: [handler rotate: 1.0. 1 seconds asDelay wait.].
	].
]

{ #category : #'private - algorithms' }
DonatelloPackage >> idleHandler [ 

^ [ : handler | 
		handler forwardAt: 0.0.
].
]

{ #category : #'private - configuration' }
DonatelloPackage >> nodeletInjectionExample: aController [
	"
		Nodelets are units objects responsible for solving common problems, meaning that there are reusable. 
	In order to access to a nodelet from a package we use a simple mechanism of dependency injection, so we 
	can easily change one implementation for other. 
		The main problem is the management of name for registration. Try to be clean and obvious with names. Comment and make them visible.
	For know more about nodelets go to the reference or check subclasses (PhaROSTransformationNodelet is a cool place to go)"

	aController nodelets use: TurtlesimNodelet as:#turtlesim.
	aController nodelets example isKindOf: TurtlesimNodelet.
	^ aController.
	

]

{ #category : #'private - algorithms' }
DonatelloPackage >> pharoHandler [

^ [ : handler |
		handler moveAt: 30.0 and:20.0. 
		1.5 seconds asDelay wait.
		handler moveAt: 30.0 and:20.0. 
		1.5 seconds asDelay wait.
		handler moveAt: 30.0 and:20.0. 
		1.5 seconds asDelay wait.
		handler moveAt: 30.0 and:20.0. 
		1.5 seconds asDelay wait.
		handler moveAt: 30.0 and:20.0. 
		1.5 seconds asDelay wait.
		handler moveAt:0.0 and: -0.3.
		1 seconds asDelay wait.
		handler moveAt:1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:0.0 and: 1.3.
		1 seconds asDelay wait.
		handler moveAt: 1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:0.0 and: -1.5.
		1 seconds asDelay wait.
		handler moveAt: 0.8 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:0.0 and: -1.65.
		1 seconds asDelay wait.
		handler moveAt: 1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:0.0 and: -1.5.
		1 seconds asDelay wait.
		handler moveAt: 0.8 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:0.0 and: -1.5.
		1 seconds asDelay wait.
		handler moveAt: 1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:0.0 and: 1.3.
		1 seconds asDelay wait.
		handler moveAt:1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:1.0 and: 0.0.
		1 seconds asDelay wait.
		handler moveAt:0.0 and: 0.3.
	].
]

{ #category : #'private - algorithms' }
DonatelloPackage >> pursuiterHandler [
	
	^ [ : handle | 
		| default  |
		default := self nodelets turtlesim defaultTurtleHandler.
		[ true ] whileTrue: [
			| trs linear angular |
			[			
				trs :=  self controller nodelets transformation transformBetween: default  frame and: handle  frame.
				Transcript show: trs; cr.
				linear := (trs position module2d) * 0.5.
				angular :=4 * ( trs position y arcTan: trs position x).
				handle moveAt:  linear and: angular.	
			] on: Error do: [].

			(Delay forMilliseconds: 100) wait.
		].
	]	
]

{ #category : #'private - algorithms' }
DonatelloPackage >> randomHandler [

	^ [ : handle |
		| linear angular |
		
		[ true ] whileTrue: [
			linear := (Random seed: DateAndTime now asUnixTime)  next; next; nextInt:20 + ((Random seed: DateAndTime now asUnixTime)  next; nextInt:9) / 10.
			angular := (Random seed: DateAndTime now asUnixTime)  next;next; next; nextInt:9 + ((Random seed: DateAndTime now asUnixTime)  next; next; nextInt:9) / 10.
			handle moveAt: linear and: angular. 			
			( (Random seed: DateAndTime now asUnixTime) next; nextInt: 3) seconds asDelay wait.
		].
 	].
]

{ #category : #scripts }
DonatelloPackage >> scriptAlgorithmSwitcher [
	"In ROS we do have services. A Service is an async computation that has related a request and a response types. In order to make available a service in ROS world you should execute the following code"

	self controller node serve: [ :req :rsp | 
		"this block will be executed when any one calls for this service" 
		(self nodelets turtlesim existantTurtleHandleFor: req turtleID) algorithm: (self algorithmFor: req command). 
		
	] at: '/donatello/switch' typedAs:'donatello/Switch'.
	

]

{ #category : #scripts }
DonatelloPackage >> scriptServiceInvoking [
	| service |
	"In order ask for a service to be executed, you need to ask to the attached node for a service call object. For doing this you should type the following code"
	service := self controller node service: '/donatello/switch'.
	service call.
	
	"This service call will ask for the loggers"

]

{ #category : #scripts }
DonatelloPackage >> scriptSwitchRequest [
	| service |
	"In order ask for a service to be executed, you need to ask to the attached node for a service call object. For doing this you should type the following code"
	service := self controller node service: '/donatello/switch'.
	service call: [: m | 
		self halt .
	].
	
	"This service call will ask for the loggers"

]

{ #category : #scripts }
DonatelloPackage >> scriptTopicPublishingExample [
	| publisher |
	"For publishing into a topic,you just need a publisher object. You can obtain it asking to the related node like in the following code".
	
	publisher := self controller node 
						topicPublisher: '/example/string' 
						typedAs: 'std_msgs/String'.
						
	publisher send:[ : string | string data: 'this is an example' ].

]

{ #category : #scripts }
DonatelloPackage >> scriptTopicSubscribingExample [
	
	"For subscribing to a topic, you just need a subscriber to configure it with a callback (block). You can obtain it asking to the related node like in the following code".
	(self controller node buildConnectionFor: '/example/string' ) 
								typedAs: 'std_msgs/String'; 
								for: [ : string |  "this is a callback" Transcript show: string data ];
								connect .
														
	"As you can see, buildConnectionFor: aTopicID, returns an object configurable. This is a builder, you can configure it as much as you want, and when you send connect message it will make the proper connection. For better usage of the builder check the documentation "

]
