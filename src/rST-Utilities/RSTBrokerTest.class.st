Class {
	#name : #RSTBrokerTest,
	#superclass : #TestCase,
	#instVars : [
		'ip'
	],
	#category : 'rST-Tests'
}

{ #category : #'initialize-release' }
RSTBrokerTest >> setUp [
	"mp 10/17/2005 11:47"
	
	ip := NetNameResolver stringFromAddress: NetNameResolver localHostAddress.
	RSTBroker startOnPort: 6666
]

{ #category : #'initialize-release' }
RSTBrokerTest >> tearDown [
	"mp 10/17/2005 11:47"
	
	RSTBroker stop
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
RSTBrokerTest >> testRemoteObject [
	"mp 10/17/2005 14:50"
	
	| instance |
	instance := (RSTBroker basicNew initialize) 
			startOnPort: 6667
			logging: false.
	instance export: 'Hello' named: 'hello'.
	self 
		should: [('hello@' , ip , ':6666') asRemoteObjectID asLocalObject] 
		raise: RSTObjectNotFound.
	self assert: ('hello@' , ip , ':6667') asRemoteObjectID asLocalObject = 'Hello'.
	instance stop
]
