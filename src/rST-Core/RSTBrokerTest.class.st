Class {
	#name : #RSTBrokerTest,
	#superclass : #TestCase,
	#instVars : [
		'ip',
		'defaultBroker',
		'extraBroker'
	],
	#category : #'rST-Tests'
}

{ #category : #accessing }
RSTBrokerTest >> bigString [
	^'########################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################'
]

{ #category : #accessing }
RSTBrokerTest >> defaultIpAndPortString [
	"Noury Bouraqadi 9/21/2006 15:31"
	
	^self ip, ':', self defaultPort printString
]

{ #category : #accessing }
RSTBrokerTest >> defaultPort [
	"Noury Bouraqadi 9/21/2006 15:31"
	
	^6666
]

{ #category : #accessing }
RSTBrokerTest >> extraIpAndPortString [
	"Noury Bouraqadi 9/21/2006 15:31"
	
	^self ip, ':', self extraPort printString
]

{ #category : #accessing }
RSTBrokerTest >> extraPort [
	"Noury Bouraqadi 9/21/2006 15:31"
	
	^7777
]

{ #category : #testing }
RSTBrokerTest >> testBigRemoteObject [
	"Noury Bouraqadi 9/21/2006 15:50"

	"a dummy 5000 length string to test Socket>>getObject"
	| remoteObjectIdString proxy |
	extraBroker export: self bigString named: 'bigString'.
	remoteObjectIdString := 'bigString@' , self extraIpAndPortString.
	proxy := remoteObjectIdString asLocalObject.
	self assert: proxy size = 5000.
	
]

{ #category : #testing }
RSTBrokerTest >> testConnectToRemoteBroker [
	"Noury Bouraqadi 9/21/2006 15:32"

	| socketStream |
	socketStream := defaultBroker connectTo: self extraIpAndPortString.
	self assert: socketStream isConnected.

]

{ #category : #testing }
RSTBrokerTest >> testExport [
	"Noury Bouraqadi 9/21/2006 15:47"
	
	| exportedObjects |
	exportedObjects := defaultBroker instVarNamed: 'exportedObjects'.
	self assert: exportedObjects size = 0.
	defaultBroker export: 'Coucou' named: 'coucou'.
	self assert: exportedObjects size = 1.
]

{ #category : #testing }
RSTBrokerTest >> testExportedRemoteObjectByCopy [
	"Noury Bouraqadi 9/21/2006 16:04"

	| exportedObject copy exportedObjectName |
	exportedObject := 'hello'.
	exportedObjectName := 'exported'.
	extraBroker export: exportedObject named: exportedObjectName.
	copy := (exportedObjectName, '@' , self extraIpAndPortString) asLocalObject.
	self assert: copy = exportedObject.
	self deny: copy isRemote.
	self deny: copy == exportedObject.
]

{ #category : #testing }
RSTBrokerTest >> testLocalObjectObtainedWithActualIP [
	"mp 10/17/2005 11:47"

	| exportedObject remoteIdString retreivedObject |
	exportedObject := Object new.
	defaultBroker export: exportedObject named: 'coucou'.
	remoteIdString := 'coucou@' , self defaultIpAndPortString.
	retreivedObject := remoteIdString asLocalObject.
	self assert: retreivedObject == exportedObject
]

{ #category : #testing }
RSTBrokerTest >> testLocalObjectObtainedWithLoopBackIP [
	"mp 10/17/2005 11:47"

	| exportedObject remoteIdString retreivedObject |
	exportedObject := Object new.
	defaultBroker export: exportedObject named: 'coucou'.
	remoteIdString := 'coucou@127.0.0.1:' , self defaultPort printString.
	retreivedObject := remoteIdString asLocalObject.
	self assert: retreivedObject == exportedObject
]

{ #category : #testing }
RSTBrokerTest >> testParseBrokerIDString [
	"mp 12/16/2005 12:49"

	| expectedAnswer actualAnswer |
	expectedAnswer := {NetNameResolver addressForName: self ip. self defaultPort}.
	actualAnswer := defaultBroker addressAndPort: self defaultIpAndPortString.
	self assert: actualAnswer = expectedAnswer.

]

{ #category : #testing }
RSTBrokerTest >> testProxyUnicity [
	"Noury Bouraqadi 9/21/2006 15:41"
	
	| proxy1 proxy2 |
	extraBroker
		export: (Array with: 12)
		named: 'array'.
	proxy1 := ('array@' , self extraIpAndPortString) asLocalObject.
	proxy2 := ('array@' , self extraIpAndPortString) asLocalObject.
	self assert: proxy1 == proxy2.
	self assert: proxy1 isRemote.
	self assert: defaultBroker allProxies size = 1.

]

{ #category : #testing }
RSTBrokerTest >> testRemoteObjectByCopy [
	"Noury Bouraqadi 9/21/2006 16:04"

	| copy exportedObjectName exportedArray proxy |
	exportedArray := #('hello').
	exportedObjectName := 'exported'.
	extraBroker export: exportedArray named: exportedObjectName.
	proxy := (exportedObjectName, '@' , self extraIpAndPortString) asLocalObject.
	copy := proxy at: 1.
	self assert: copy = exportedArray first.
	self deny: copy isRemote.
	self deny: copy == exportedArray first.
]

{ #category : #testing }
RSTBrokerTest >> testSerialization [
	"Noury Bouraqadi 9/21/2006 16:02"
	
	| originalObject serializedObject deserializedObject |
	originalObject := {1. 2. 3. 4. 5}.
	serializedObject := defaultBroker serializeObject: originalObject.
	deserializedObject := defaultBroker deserializeObject: serializedObject.
	self assert: deserializedObject = originalObject.
	self deny:  deserializedObject == originalObject.
]