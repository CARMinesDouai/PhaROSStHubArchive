Class {
	#name : #RSTBrokerTest,
	#superclass : #TestCase,
	#instVars : [
		'ip'
	],
	#category : #'rST-Tests'
}

{ #category : #accessing }
RSTBrokerTest >> bigString [
	^'########################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################'
]

{ #category : #'initialize-release' }
RSTBrokerTest >> setUp [
	"mp 10/17/2005 11:47"
	
	ip := NetNameResolver stringFromAddress: NetNameResolver localHostAddress.
	RSTBroker startOnPort: 6666
]

{ #category : #'initialize-release' }
RSTBrokerTest >> tearDown [
	"mp 10/17/2005 11:47"
	
	RSTBroker stop.
	"RSTBroker allInstancesDo: [:each | each stop]."
	"Smalltalk garbageCollect."
]

{ #category : #testing }
RSTBrokerTest >> testConnectToRemoteBroker [
	"mp 12/16/2005 12:49"

	| instance socketStream |
	instance := RSTBroker basicNew initialize startOnPort: 6667 logging: false.
	socketStream := RSTBroker instance connectTo: (ip , ':6667').
	self assert: socketStream isConnected.
	instance unregister
]

{ #category : #testing }
RSTBrokerTest >> testExport [
	"mp 10/17/2005 11:47"
	
	| exportedObjects |
	exportedObjects := RSTBroker instance instVarNamed: 'exportedObjects'.
	self assert: exportedObjects size = 0.
	RSTBroker instance export: 'Coucou' named: 'coucou'.
	self assert: exportedObjects size = 1.
]

{ #category : #testing }
RSTBrokerTest >> testLocalObject [
	"mp 10/17/2005 11:47"
	
	RSTBroker instance export: 'Coucou' named: 'coucou'.
	self assert: ('coucou@' , ip , ':6666') asRemoteObjectID asLocalObject = 'Coucou'
]

{ #category : #testing }
RSTBrokerTest >> testParseBrokerIDString [
	"mp 12/16/2005 12:49"

	self assert: (RSTBroker instance addressAndPort: (ip , ':6666')) = {NetNameResolver addressForName: ip. 6666}
]

{ #category : #testing }
RSTBrokerTest >> testProxyUnicity [
	| instance proxy1 proxy2 |
	instance := RSTBroker basicNew initialize startOnPort: 6667 logging: false.
	instance
		export: (Array with: 12)
		named: 'array'.
	proxy1 := ('array@' , ip , ':6667') asRemoteObjectID asLocalObject.
	proxy2 := ('array@' , ip , ':6667') asRemoteObjectID asLocalObject.
	self assert: proxy1 isRemote.
	self assert: proxy2 isRemote.
	proxy1 size.
	proxy2 size.
	self assert: RSTBroker instance allProxies size = 1.
	instance unregister.
	instance := nil
]

{ #category : #testing }
RSTBrokerTest >> testRemoteObjectByCopy [
	"mp 10/17/2005 14:50"

	| instance proxy |
	instance := RSTBroker basicNew initialize startOnPort: 6667 logging: false.
	instance export: 'hello' named: 'hello'.
	self 
		should: [('hello@' , ip , ':6666') asRemoteObjectID asLocalObject = 'hello']
		raise: RSTObjectNotFound.
	proxy := ('hello@' , ip , ':6667') asRemoteObjectID asLocalObject.
	self assert: proxy isRemote.
	self assert: proxy = 'hello'.
	instance unregister
]

{ #category : #testing }
RSTBrokerTest >> testRemoteObjectByReference [
	"mp 12/16/2005 12:35"

	| instance proxy |
	instance := RSTBroker basicNew initialize startOnPort: 6667 logging: false.
	instance export: (1 to: 10) named: 'array'.
	self 
		should: [('array@' , ip , ':6666') asRemoteObjectID asLocalObject sum = 55]
		raise: RSTObjectNotFound.
	proxy := ('array@' , ip , ':6667') asRemoteObjectID asLocalObject.
	self assert: proxy isRemote.
	self assert: proxy sum = 55.
	instance unregister
]

{ #category : #testing }
RSTBrokerTest >> testSerialization [
	"mp 12/15/2005 16:50"
	
	| originalObject serializedObject deserializedObject |
	originalObject := {1. 2. 3. 4. 5}.
	serializedObject := RSTBroker instance serializeObject: originalObject.
	deserializedObject := RSTBroker instance deserializeObject: serializedObject.
	self assert: deserializedObject = originalObject
]

{ #category : #testing }
RSTBrokerTest >> testStartStop [
	"mp 12/16/2005 13:21"

	RSTBroker stop.
	self assert: (RSTBroker instVarNamed: 'instance') isNil.
	RSTBroker startOnPort: 6666.
	self assert: RSTBroker instance isRunning.
	self assert: RSTBroker instance portNumber = 6666.
	self assert: RSTBroker instance brokerID = (NetNameResolver localAddressString , ':6666').
	RSTBroker stop.
	self assert: (RSTBroker instVarNamed: 'instance') isNil
]

{ #category : #testing }
RSTBrokerTest >> ttestBigRemoteObject [
	"mp 10/17/2005 14:50"

	| instance |
	instance := RSTBroker basicNew initialize startOnPort: 6667 logging: false.
	"a dummy 5000 length string to test Socket>>getObject"
	instance export: self bigString named: 'bigString'.
	self 
		assert: ('bigString@' , ip , ':6667') asRemoteObjectID asLocalObject size 
				= 5000.
	instance unregister
]
