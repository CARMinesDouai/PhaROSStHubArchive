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

{ #category : #'private - color management' }
DonatelloPackage >> bindRed: aRedColorBind green: aGreenColorBind  blue: aBlueColorBind with: aTurtleHandle  rate: aRate [

	aRate get hz wait. 
	aRedColorBind set: ((aTurtleHandle pose position x * 100) % 255) asInteger.
	aGreenColorBind set: ((aTurtleHandle pose position y* 100) % 255) asInteger.
	aBlueColorBind set: 255 - ((aTurtleHandle pose orientation z* 100) % 255) asInteger.
	self nodelets turtlesim clear.
]

{ #category : #'private - color management' }
DonatelloPackage >> bindRed: aRedColorBind green: aGreenColorBind  blue: aBlueColorBind with: aTurtleHandle tickingOn: aService rate: aRate [

	aRate get hz wait. 
	aRedColorBind set: ((aTurtleHandle pose position x * 100) % 255) asInteger.
	aGreenColorBind set: ((aTurtleHandle pose position y* 100) % 255) asInteger.
	aBlueColorBind set: 255 - ((aTurtleHandle pose orientation z* 100) % 255) asInteger.
	aService call.
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
DonatelloPackage >> convertToGeometryVector3: aTriplet [

	^ Geometry_msgsVector3 new
		x: aTriplet first;
		y: aTriplet second;
		z: aTriplet third;
		yourself			

]

{ #category : #'private - auxiliar' }
DonatelloPackage >> getOrCreateHandleFor: aTurtleID [

	^ turtles at: aTurtleID ifAbsentPut: [ self nodelets turtlesim spawnTurtle: aTurtleID ].
]

{ #category : #'initialize-release' }
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

{ #category : #'private - auxiliar' }
DonatelloPackage >> rate [
	^ self node parameter:'/color/rate' initialized: 0.5
]

{ #category : #'private - auxiliar' }
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
DonatelloPackage >> scriptColor [
	| version distro red green blue  rate |
	
	self registerDefaultHandler.
	
	version := self node parameter:'/rosversion' initialized:''.
	distro := self node parameter: '/rosdistro'	initialized:''.

	self log: (' Running Donatello color node at ROS {1} ({2})' format: { version get . distro get }).
	
	red :=  self nodelets turtlesim bgcRed.
	green :=  self nodelets turtlesim bgcGreen.
	blue :=  self nodelets turtlesim bgcBlue.
	
	rate :=  self rate.

	self log: 'Donatello color node is a node that change the background color of the running TurtleSIM node with the behaviour of a turlte'.
	
	self paralellize looping 
					bindRed: red 
					green: green 
					blue: blue 
					with: (self getOrCreateHandleFor: (self askUserFor: 'Which turtle you want to define the background color? - Remember default turtle''s name is turtle1 ')) 
					rate: rate.
	
	self log: ('Color node running at: {1} hz' format: { rate get }).
	
	rate onChange: [ :newRate :oldRate | 
		self log: ('Changeing color rate update from{1} to {2}' format: { oldRate . newRate }).	
	 ].
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

{ #category : #scripts }
DonatelloPackage >> scriptTurtleBot [
	|  publisher   |
	"In order ask for a service to be executed, you need to ask to the attached node for a service call object. For doing this you should type the following code"
	
	self log: 'Moving the turtle'.
	publisher := self controller node topicPublisher: '/achao' typedAs: 'geometry_msgs/Twist'.
	publisher send: [ :msg | 
		msg linear: (self convertToGeometryVector3: #(1.0 0.0 0.0)).
		msg angular: (self convertToGeometryVector3: #(0.0 0.0 0.0)).
		
		1 seconds asDelay wait.
		[  true ] whileTrue: [
			self log:'hello'.
			msg linear: (self convertToGeometryVector3: #(0.4  0.0 0.0)).
			msg angular: (self convertToGeometryVector3: #(0.0 0.0 1.0)).
			1 seconds asDelay wait.
		].
	].
	

]
