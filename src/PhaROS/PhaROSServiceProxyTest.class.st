Class {
	#name : #PhaROSServiceProxyTest,
	#superclass : #PhaROSBaseCase,
	#instVars : [
		'service'
	],
	#category : #'PhaROS-Kernel-Test'
}

{ #category : #testing }
PhaROSServiceProxyTest >> setUp [ 

	super setUp.
	self startUpMaster.
	self startUpTurtle.
	
]

{ #category : #testing }
PhaROSServiceProxyTest >> testAnswerToServiceCall [
	| answerMessage |
	
	service := master lookupService: '/reset' with: self callerId .
	
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
PhaROSServiceProxyTest >> testCallingAServiceWithNoArgs [
	service := master lookupService: '/reset' with: self callerId.
	self shouldnt: [service call] raise:  Error
]
