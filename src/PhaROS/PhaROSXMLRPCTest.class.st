Class {
	#name : #PhaROSXMLRPCTest,
	#superclass : #PhaROSBaseCase,
	#instVars : [
		'expectedSystemState'
	],
	#category : #'PhaROS-Kernel-Test'
}

{ #category : #testing }
PhaROSXMLRPCTest >> expectedFailures [
	" Must be implemented first "
	^#(
		testRegisterService 
		testUnregisterService 
	)
]

{ #category : #testing }
PhaROSXMLRPCTest >> expectedTopicTypes [ 
	^ {
		'/rosout' -> 'rosgraph_msgs/Log' .
		'/rosout_agg' -> 'rosgraph_msgs/Log'.
	   } asDictionary.
	

]

{ #category : #'as yet unclassified' }
PhaROSXMLRPCTest >> setUp [ 
	super setUp.
	self startUpMaster.
	
	expectedSystemState := PhaROSSystemState new.
	expectedSystemState
		addPublishers: {'/rosout'} forTopic: '/rosout_agg' ;
		addSubscribers: {'/rosout'} forTopic: '/rosout' ;
		addProviders: {'/rosout'} forService: '/rosout/set_logger_level';
		addProviders: {'/rosout'} forService: '/rosout/get_loggers'.

]

{ #category : #'as yet unclassified' }
PhaROSXMLRPCTest >> tearDown [ 
	super tearDown.
	self spin: 5.
]

{ #category : #testing }
PhaROSXMLRPCTest >> testGetPublishedTopics [	
	| currentPublisherTopics |
	currentPublisherTopics := master master getPublishedTopics: self callerId.
	self assert: currentPublisherTopics = expectedSystemState publishedTopics.
 
]

{ #category : #testing }
PhaROSXMLRPCTest >> testGetSystemState [
	| currentSystemState |
	currentSystemState := master master getSystemState: self callerId .	
	self assert: currentSystemState = expectedSystemState
	
	


]

{ #category : #testing }
PhaROSXMLRPCTest >> testGetTopicTypes [
	| currentTopicTypes | 
	
	currentTopicTypes := master master getTopicTypes: self callerId .
	self assert: self expectedTopicTypes = currentTopicTypes.
]

{ #category : #testing }
PhaROSXMLRPCTest >> testGetUri [
	self assert: (master master getUri: self callerId) =  (masterUrl, '/')
]

{ #category : #testing }
PhaROSXMLRPCTest >> testLookupNode [
	|node|
	node := master master lookupNode: '/rosout' with: self callerId.
	self assert: (node url  authority  = masterUrl asUrl authority )
]

{ #category : #testing }
PhaROSXMLRPCTest >> testLookupService [
	|service expectedServiceName|
	expectedServiceName := '/rosout/get_loggers'.
	service := master master lookupService: expectedServiceName with: self callerId.
	self assert: service hostName = masterUrl asUrl authority.
	self assert: service serviceName = expectedServiceName 
]

{ #category : #testing }
PhaROSXMLRPCTest >> testRegisterPublisher [
	| currentData callerURI |

	callerURI := 'http://127.0.0.1:9090/'.
	currentData := master master registerPublisher: self callerId  to: 'rosout' with: 'rosgraph_msgs/Log'  andCallerUri: callerURI .
	
	self assert: currentData size > 0.
	self assert: (currentData anySatisfy: [ :each | (each indexOfSubCollection: self defaultMasterIp) > 0]) 
		


]

{ #category : #testing }
PhaROSXMLRPCTest >> testRegisterService [
"registerService(caller_id, service, service_api, caller_api)

    Register the caller as a provider of the specified service.


    Parameters

        caller_id (str)
            ROS caller ID 

        service (str)
            Fully-qualified name of service 

        service_api (str)
            ROSRPC Service URI 

        caller_api (str)
            XML-RPC URI of caller node 

    Returns (int, str, int)
        (code, statusMessage, ignore)"

	self fail
]

{ #category : #testing }
PhaROSXMLRPCTest >> testRegisterSubscriber [
	| currentData callerURI |
	
	callerURI := 'http://127.0.0.1:9090/'.
	currentData := master master registerSubscriber: self callerId  to: 'rosout' with: 'rosgraph_msgs/Log'  andCallerUri: callerURI.
	self deny: currentData isNil
	
]

{ #category : #testing }
PhaROSXMLRPCTest >> testUnregisterPublisher [
	| currentData callerURI |
	
	self testRegisterPublisher.
	
	callerURI :=  'http://127.0.0.1:9090/'.
	currentData := master master unregisterPublisher: self callerId  from: 'rosout'  andCallerUri: callerURI.
	self assert: currentData = 1.
	
	currentData := master master unregisterPublisher: self callerId  from: 'rosout'  andCallerUri: callerURI.
	self assert: currentData = 0.
	
	
]

{ #category : #testing }
PhaROSXMLRPCTest >> testUnregisterService [
"unregisterService(caller_id, service, service_api)

    Unregister the caller as a provider of the specified service.


    Parameters

        caller_id (str)
            ROS caller ID 

        service (str)
            Fully-qualified name of service 

        service_api (str)
            API URI of service to unregister. Unregistration will only occur if current registration matches. 

    Returns (int, str, int)
        (code, statusMessage, numUnregistered).


        Number of unregistrations (either 0 or 1). If this is zero it means that the caller was not registered as a service provider. The call still succeeds as the intended final state is reached. "
	self fail
]

{ #category : #testing }
PhaROSXMLRPCTest >> testUnregisterSubscriber [
	| currentData |
	self testRegisterSubscriber.
	currentData := master master  unregisterSubscriber: self callerId  from: 'rosout'  andCallerUri: 'http://127.0.0.1:9090/'.
	self assert: currentData = 1.
	currentData := master master unregisterSubscriber: self callerId  from: 'rosout'  andCallerUri: 'http://127.0.0.1:9090/'.
	self assert: currentData = 0.
	


]
