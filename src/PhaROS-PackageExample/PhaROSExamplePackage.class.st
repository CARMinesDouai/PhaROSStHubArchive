Class {
	#name : #PhaROSExamplePackage,
	#superclass : #PhaROSPackage,
	#category : #'PhaROS-PackageExample'
}

{ #category : #'private - configuration' }
PhaROSExamplePackage >> buildController [
	"This message is called by the accessor controller when the variable that stores the controller is pointing to nil.
	 If you want to make some specific configuration, as injecting nodelets, for package level, this is the place to do it. 
	Remember to not call #controller from this method, or inner this method, because #controller is the caller of this message.
	"
	^ self nodeletInjectionExample: super buildController.

]

{ #category : #'private - configuration' }
PhaROSExamplePackage >> nodeletInjectionExample: aController [
	"
		Nodelets are units objects responsible for solving common problems, meaning that there are reusable. 
	In order to access to a nodelet from a package we use a simple mechanism of dependency injection, so we 
	can easily change one implementation for other. 
		The main problem is the management of name for registration. Try to be clean and obvious with names. Comment and make them visible.
	For know more about nodelets go to the reference or check subclasses (PhaROSTransformationNodelet is a cool place to go)"

	aController nodelets use: PhaROSExampleNodelets as: #example.
	^ aController
	

]

{ #category : #scripts }
PhaROSExamplePackage >> scriptExample [
	"Any method that starts with a script is deployed as script Here you can start doing stuff".
]

{ #category : #scripts }
PhaROSExamplePackage >> scriptParameterBinding [
	| integer |
	"A parameter is a value registered in the master. The idea is to give the chance to 3rd agents to change the value of this parameter. In order to ask for a parameter instance we call the following code"
	
	integer := self controller node parameter: 'integer' initialized: 1. 
	
	" The variable integer now points to a binding. This binding understands #set: and #get messages. Is related with the ROS running environment. "
	
	

]

{ #category : #scripts }
PhaROSExamplePackage >> scriptServiceDefining [
	"In ROS we do have services. A Service is an async computation that has related a request and a response types. In order to make available a service in ROS world you should execute the following code"
	self controller node serve: [ :req :rsp | 
		"this block will be executed when any one calls for this service" 
		Transcript show: 'Service has been called.'; cr.  
	] at: '/pharos/service' typedAs:'roscpp/Empty'.
	

]

{ #category : #scripts }
PhaROSExamplePackage >> scriptServiceInvoking [
	| service |
	"In order ask for a service to be executed, you need to ask to the attached node for a service call object. For doing this you should type the following code"
	service := self controller node service: '/rosout/get_loggers'.
	service call.
	
	"This service call will ask for the loggers"

]

{ #category : #scripts }
PhaROSExamplePackage >> scriptTopicPublishingExample [
"	
	How to use:
	  1) in PhaROS, execute: 	self new scriptTopicPublishingExample
	  2) in a terminal, execute:   rostopic echo /example 
"
	| publisher |

	"For publishing into a topic,you just need a publisher object. 
	You can obtain it asking to the related node like in the following code".
	
	publisher := self controller node 
						topicPublisher: 'example'
						typedAs: 'std_msgs/String'.

	"When data is actually sent you''l see a sequence of ping and pong. Otherwise you'' see pong alone"						
	[[
		2 second wait.
		publisher send:[ : string | 
			string data: 'You are receiving data :-)'.
			self log: 'ping'
		].
		self log: '  pong'
	] repeat] forkAt: Processor userBackgroundPriority.

]

{ #category : #scripts }
PhaROSExamplePackage >> scriptTopicSubscribingExample [
"
	This example shows how to subscribe to a ROS topic.
	
	How to use:
	  1) in PhaROS, execute: 	self new scriptTopicSubscribingExample
	  2) in a terminal, execute:   rostopic pub -r 10 /example std_msgs/String ''hello there''
	
	
	You just need a subscriber object (created using buildConnectionFor: aTopicID) and configure it with a callback (block).
	Then, when you send it the #connect message it will make the proper connections. 

	cf. PhaROSExamplePackage for more scripts example
"
	
	(self controller node buildConnectionFor: 'example' ) 
								typedAs: 'std_msgs/String'; 
								for: [ : string |  "this is a callback" 
									Transcript show: string data.
									self log: string data ];
								connect .
														

]
