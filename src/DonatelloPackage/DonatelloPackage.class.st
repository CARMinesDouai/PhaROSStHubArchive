Class {
	#name : #DonatelloPackage,
	#superclass : #PhaROSPackage,
	#instVars : [
		'turtles'
	],
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

{ #category : #'private - configuration' }
DonatelloPackage >> buildController [
	"This message is called by the accessor controller when the variable that stores the controller is pointing to nil.
	 If you want to make some specific configuration, as injecting nodelets, for package level, this is the place to do it. 
	Remember to not call #controller from this method, or inner this method, because #controller is the caller of this message.
	"
	^ self nodeletInjectionExample: super buildController.

]

{ #category : #scripts }
DonatelloPackage >> getOrCreateHandleFor: aTurtleID [

	^ turtles at: aTurtleID ifAbsentPut: [ self nodelets turtlesim spawnTurtle: aTurtleID ].
]

{ #category : #scripts }
DonatelloPackage >> initialize [
	super initialize.
	turtles := Dictionary new.
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
	aController nodelets turtlesim isKindOf: TurtlesimNodelet.
	^ aController.
	

]

{ #category : #scripts }
DonatelloPackage >> registerDefaultHandler [
	turtles at: 'turtle1' put: 	self nodelets turtlesim defaultTurtleHandler.
]

{ #category : #scripts }
DonatelloPackage >> scriptAlgorithmSwitcher [
	"In ROS we do have services. A Service is an async computation that has related a request and a response types. In order to make available a service in ROS world you should execute the following code"
	self log: 'Starting up default turtle(turtle1) handler... '.
	self registerDefaultHandler.
	self log: 'Starting up switch service... '.
	self controller node serve: [ :req :rsp | 
		"this block will be executed when any one calls for this service" 
		self log: ('{1} will behave as {2}' format: {req turtleID . req command} ).
		(self getOrCreateHandleFor: req turtleID)  algorithm: (DonatelloAlgorithms new algorithmFor: req command).		
	] at: '/donatello/switch' typedAs:'donatello/Switch'.
	self log: 'Done.'.

]

{ #category : #scripts }
DonatelloPackage >> scriptSwitchRequest [
	| service turtle algorithm  |
	"In order ask for a service to be executed, you need to ask to the attached node for a service call object. For doing this you should type the following code"
	
	turtle := self askUserFor:  'Please, write the name of turtle you want to switch the algorithm. (The default one is called turtle1) '.	
	algorithm := self askUserFor: 'Please, write the name of one of the following algorithms  ',  DonatelloAlgorithms new list asString.

	service := self controller node service: '/donatello/switch'.
	
	self log: (service call: [: m | 
		m turtleID: turtle.
		m command: algorithm.
	]) asString.
	
	self exit: 0. 
		
	"This service call will ask for the loggers"

]
