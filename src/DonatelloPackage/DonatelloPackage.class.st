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
		String named: #command .
	} response: { 
	}.
]

{ #category : #types }
DonatelloPackage class >> types [ 
	^ super types, { 
		self switchCommandServiceType.
	
	 }
]

{ #category : #'private - configuration' }
DonatelloPackage >> buildController [
	"This message is called by the accessor controller when the variable that stores the controller is pointing to nil.
	 If you want to make some specific configuration, as injecting nodelets, for package level, this is the place to do it. 
	Remember to not call #controller from this method, or inner this method, because #controller is the caller of this message.
	"
	^ self nodeletInjectionExample: super buildController.

]

{ #category : #'private - configuration' }
DonatelloPackage >> nodeletInjectionExample: aController [
	"
		Nodelets are units objects responsible for solving common problems, meaning that there are reusable. 
	In order to access to a nodelet from a package we use a simple mechanism of dependency injection, so we 
	can easily change one implementation for other. 
		The main problem is the management of name for registration. Try to be clean and obvious with names. Comment and make them visible.
	For know more about nodelets go to the reference or check subclasses (PhaROSTransformationNodelet is a cool place to go)"

	aController nodelets use: TurtlesimNodelet as:#example.
	aController nodelets example isKindOf: TurtlesimNodelet.
	^ aController.
	

]

{ #category : #scripts }
DonatelloPackage >> scriptServiceDefining [
	"In ROS we do have services. A Service is an async computation that has related a request and a response types. In order to make available a service in ROS world you should execute the following code"
	self controller node serve: [ :req :rsp | 
		"this block will be executed when any one calls for this service" 
		Transcript show: 'Service has been called.'; cr.  
	] at: '/donatello/switch' typedAs:'donatello/Switch'.
	

]

{ #category : #scripts }
DonatelloPackage >> scriptServiceInvoking [
	| service |
	"In order ask for a service to be executed, you need to ask to the attached node for a service call object. For doing this you should type the following code"
	service := self controller node service: '/rosout/get_loggers'.
	service call.
	
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
