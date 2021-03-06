"
A RoStMasterProxy is the proxy for the ROS Master, that is the node that gives access to all other nodes and to system information.
"
Class {
	#name : #PhaROSMasterProxy,
	#superclass : #PhaROSProxy,
	#instVars : [
		'callerId',
		'tcpserver'
	],
	#classVars : [
		'MasterInstances'
	],
	#category : #'PhaROS-Network-XmlRpc'
}

{ #category : #'as yet unclassified' }
PhaROSMasterProxy class >> id: aCallerId url: anUrl [ 

	| instance |   	
	instance := super url: anUrl .
	^instance.
	

]

{ #category : #'as yet unclassified' }
PhaROSMasterProxy class >> initialize [
	MasterInstances := Dictionary new.
]

{ #category : #'as yet unclassified' }
PhaROSMasterProxy class >> url: anUrl [ 
	^ self id:'anArbitraryId' url: anUrl.
]

{ #category : #'API-Parameter-Server' }
PhaROSMasterProxy >> deleteParam: aParameterName for: aCallerId [ 
	^ self serviceResult: ( self  invokeMethod: 'deleteParam' withArgs: {  aCallerId . aParameterName}).

]

{ #category : #'API-Data-Mutators' }
PhaROSMasterProxy >> deleteParam: aCallerId named: aParameterName [ 
	^ self  invokeMethod: 'deleteParam' withArgs: {aCallerId . aParameterName}.
	
	
]

{ #category : #'API-Parameter-Server' }
PhaROSMasterProxy >> getParam: aParameterName for: aCallerId [ 
	^  self  invokeMethod: 'getParam' withArgs: {  aCallerId . aParameterName}.

]

{ #category : #'API-Data-Accessors' }
PhaROSMasterProxy >> getParam: aCallerId named: aParameterName [
	^ self  invokeMethod: 'getParam' withArgs: {aCallerId . aParameterName}.
	
	
]

{ #category : #'API-Data-Accessors' }
PhaROSMasterProxy >> getParamNames: aCallerId [
	^ self  invokeMethod: 'getParamNames' withArgs: {aCallerId}.


	
]

{ #category : #'API-Parameter-Server' }
PhaROSMasterProxy >> getParamNamesFor: aCallerId [
	^  self serviceResult: ( self  invokeMethod: 'getParamNames' withArgs: { aCallerId  }).
]

{ #category : #'API-Data-Accessors' }
PhaROSMasterProxy >> getPublisherTopics [
	^ self getPublisherTopics: self callerId.

	
]

{ #category : #'API-Data-Accessors' }
PhaROSMasterProxy >> getSystemState: aCallerId [
	^ self  invokeMethod: 'getSystemState' withArgs: {aCallerId}.
]

{ #category : #'API-Data-Accessors' }
PhaROSMasterProxy >> getTopicTypes: aCallerId [
 | topics |
	topics := (self  invokeMethod: 'getTopicTypes' withArgs: {aCallerId} )  .
	^ topics 	inject: (Dictionary new) 
			 	into: [ 
					: dict : aTopicArray |  
					dict at: (aTopicArray at:1) put: (aTopicArray at:2); 
						 yourself .
				].
	
]

{ #category : #'API-Data-Accessors' }
PhaROSMasterProxy >> getUri: aCallerId [
	^self  invokeMethod: 'getUri' withArgs: {aCallerId }.

]

{ #category : #'API-Parameter-Server' }
PhaROSMasterProxy >> hasParam: aParameterName  for: aCallerId [
	^  self  invokeMethod: 'hasParam' withArgs: { aCallerId . aParameterName }.
]

{ #category : #'API-Data-Accessors' }
PhaROSMasterProxy >> hasParam: aCallerId named: aParameterName [

	^ self  invokeMethod: 'hasParam:' withArgs: {aCallerId . aParameterName}.


	
]

{ #category : #API }
PhaROSMasterProxy >> lookupNode: nodeName with: aCallerId [

	^ self invokeMethod: 'lookupNode' withArgs: { aCallerId . nodeName }.
	
]

{ #category : #API }
PhaROSMasterProxy >> lookupService: serviceName with: aCallerId [
	^ self  invokeMethod: 'lookupService' withArgs: { aCallerId . serviceName}.

	
]

{ #category : #'API-Registration' }
PhaROSMasterProxy >> registerPublisher: aCallerId to: aTopicName with: aTopicMessageType andCallerUri: anUri [
	
	^ self  invokeMethod: 'registerPublisher' withArgs: { aCallerId . aTopicName . aTopicMessageType . anUri}.

]

{ #category : #API }
PhaROSMasterProxy >> registerService: serviceName at: aROSRPCUrl for: aXMLRPCUrl with: aCallerId [

	^ self  invokeMethod: 'registerService' withArgs: { aCallerId . serviceName . aROSRPCUrl . aXMLRPCUrl }.

	
]

{ #category : #'API-Registration' }
PhaROSMasterProxy >> registerSubscriber: aCallerId to: aTopicName with: aTopicMessageType andCallerUri: anUri [

	^ self  invokeMethod: 'registerSubscriber' withArgs: { aCallerId . aTopicName . aTopicMessageType . anUri}.

]

{ #category : #'API-Parameter-Server' }
PhaROSMasterProxy >> searchParam: aParameterName for: aCallerId [ 
	^  self serviceResult:  (self  invokeMethod: 'searchParam' withArgs: {  aCallerId . aParameterName}).

]

{ #category : #private }
PhaROSMasterProxy >> serviceResult: aResult [
	^ (aResult at: 1) = 1 ifTrue: [ 
		aResult at: 3.
	 ] ifFalse: [ 
		self error:(aResult at:2 ).
	 ]
]

{ #category : #'API-Data-Mutators' }
PhaROSMasterProxy >> setParam: aCallerId named: aParameterName with: anObject [
	^ self  invokeMethod: 'setParam' withArgs: {aCallerId . aParameterName . anObject}.
]

{ #category : #'API-Parameter-Server' }
PhaROSMasterProxy >> setParam: aParameterName with: aValue for: aCallerId [ 
	^  self  invokeMethod: 'setParam' withArgs: { aCallerId . aParameterName . aValue}.

]

{ #category : #'API-Parameter-Server' }
PhaROSMasterProxy >> subscribeParam: aParameterName callingBack: anXMLRPCUrl for: aCallerId [
	^  self  invokeMethod: 'subscribeParam' withArgs: { aCallerId . anXMLRPCUrl. aParameterName }.
]

{ #category : #'API-Registration' }
PhaROSMasterProxy >> unregisterPublisher: aCallerId from: aTopicName andCallerUri: anUri [
	^ self  invokeMethod: 'unregisterPublisher' withArgs: { aCallerId . aTopicName .  anUri}.

]

{ #category : #'API-Registration' }
PhaROSMasterProxy >> unregisterSubscriber: aCallerId from: aTopicName andCallerUri: anUri [
	^ self  invokeMethod: 'unregisterSubscriber' withArgs: { aCallerId . aTopicName .  anUri}.

]

{ #category : #'API-Parameter-Server' }
PhaROSMasterProxy >> unsubscribeParam: aParameterName callingBack: anXMLRPCUrl for: aCallerId [
	^  self serviceResult:  (self  invokeMethod: 'unsubscribeParam' withArgs: { aCallerId . anXMLRPCUrl. aParameterName }).
]
