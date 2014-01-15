Class {
	#name : #PhaROSServiceProxyTestGraph,
	#superclass : #PhaROSBaseCase,
	#instVars : [
		'service',
		'loggers'
	],
	#category : #'PhaROSTestROS-Kernel-Graphical'
}

{ #category : #testing }
PhaROSServiceProxyTestGraph >> setUp [ 

	super setUp.
	
]

{ #category : #testing }
PhaROSServiceProxyTestGraph >> testAnswerToServiceCall [
	| answerMessage |
	
	self startUpTurtle.
	
	service :=  master lookupService: '/reset' with: self callerId .
	
	answerMessage := service call.
	answerMessage withHeader: [ 
		: header | 
		self assert: header callerId =  '/turtlesim'.
		self assert: header md5Sum = 'd41d8cd98f00b204e9800998ecf8427e'.
		self assert: header requestType = 'std_srvs/EmptyRequest'.
		self assert: header responseType = 'std_srvs/EmptyResponse'.
		self assert: header type = 'std_srvs/Empty'.
	]
]

{ #category : #testing }
PhaROSServiceProxyTestGraph >> testCallingAServiceWithNoArgs [
	self startUpTurtle.
	service :=  master lookupService: '/reset' with: self callerId.
	self shouldnt: [service call] raise:  Error
]

{ #category : #testing }
PhaROSServiceProxyTestGraph >> testCallingServiceWithParam [
	| response |
	self startUpTurtle.
	service :=  master lookupService: '/spawn' with: self callerId.
	response := service call: [ : m | m x: 2.0; y: 2.0; name: 'turtleTest' ].
	1 second asDelay wait.
	self assert: (response) name = 'turtleTest'
	
]
