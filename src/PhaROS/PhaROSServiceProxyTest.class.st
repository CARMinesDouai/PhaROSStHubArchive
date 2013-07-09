Class {
	#name : #PhaROSServiceProxyTest,
	#superclass : #PhaROSBaseCase,
	#instVars : [
		'service',
		'loggers'
	],
	#category : #'PhaROS-Kernel-Test'
}

{ #category : #testing }
PhaROSServiceProxyTest >> setUp [ 

	super setUp.
	"self startUpMaster.
	"
	
]

{ #category : #testing }
PhaROSServiceProxyTest >> testAnswerToServiceCall [
	| answerMessage |
	
	self startUpTurtle.
	
	service := master master lookupService: '/reset' with: self callerId .
	
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
PhaROSServiceProxyTest >> testCallForLoggers [

	service := master lookupService: '/rosout/get_loggers' with: '/andID' .
service md5sum: '32e97e85527d4678a8f9279894bb64b0'.
loggers := service call response.
self assert: (loggers loggers  anySatisfy: [: logger | logger name = 'ros' ]).
self assert: (loggers loggers  anySatisfy: [: logger | logger name = 'ros.roscpp' ]).
self assert: (loggers loggers  anySatisfy: [: logger | logger name = 'ros.roscpp.roscpp_internal' ]).
self assert: (loggers loggers  anySatisfy: [: logger | logger name = 'ros.roscpp.superdebug' ]).

]

{ #category : #testing }
PhaROSServiceProxyTest >> testCallingAServiceWithNoArgs [
	self startUpTurtle.
	service := master lookupService: '/reset' with: self callerId.
	self shouldnt: [service call] raise:  Error
]
