Class {
	#name : #RSTBrokerTest,
	#superclass : #RSTTestCase,
	#category : #'rST-Tests'
}

{ #category : #accessing }
RSTBrokerTest >> bigString [
	^'########################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################'
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
RSTBrokerTest >> testComplexRemoteMutualEvaluation [
	
	"Mutual Proxy evaluation test, with proxy as Remote Object"
	
	| proxyFromExtra2DefaultBroker proxyFromDefaultBroker |
	extraBroker export: DummyClass new named: 'dClass'.
	defaultBroker export: DummyClass new named: 'dClass'.
	proxyFromExtra2DefaultBroker := (RSTRemoteObjectID fromString: ('dClass@', self extraIpAndPortString)) asProxy.
	proxyFromDefaultBroker := (RSTRemoteObjectID fromString: ('dClass@', self defaultIpAndPortString)) asLocalObject.
	self assert: (proxyFromExtra2DefaultBroker isRemote).
	self deny: (proxyFromDefaultBroker isRemote).
	self assert: ( (proxyFromExtra2DefaultBroker decrement: 100 withArray: {proxyFromDefaultBroker}) = 0).
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
RSTBrokerTest >> testLocalBlockEvaluation [
	"Noury Bouraqadi 9/21/2006 15:50"

	"a dummy 5000 length string to test Socket>>getObject"
	| remoteObjectIdString proxy |
	extraBroker export: self bigString named: 'bigString'.
	remoteObjectIdString := 'bigString@' , self extraIpAndPortString.
	proxy := remoteObjectIdString asLocalObject.
	self assert: proxy size = 5000.
	
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
RSTBrokerTest >> testLocalObjectObtainedWithLocalHostAsRemoteBrokerId [
	"mp 10/17/2005 11:47"

	| exportedObject remoteIdString retreivedObject |
	exportedObject := Object new.
	defaultBroker export: exportedObject named: 'coucou'.
	remoteIdString := 'coucou@localhost:' , self defaultPort printString.
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
RSTBrokerTest >> testProxyAnswersEqualsItSelfEvenIfUnreachable [
	| actualObject proxy |
	actualObject := Object new.
	extraBroker 
		export: actualObject
		named: 'someObject'.
	proxy := ('someObject@' , self extraIpAndPortString) asLocalObject.
	extraBroker stop.
	self deny: proxy isReachable.
	self 
		shouldnt: [ proxy = proxy ]
		raise: Exception.
	self assert: proxy = proxy.
	self 
		shouldnt: [ proxy = nil ]
		raise: Exception.
	self deny: proxy = nil.
	self 
		shouldnt: [ proxy = (100 @ 200) ]
		raise: Exception.
	self deny: proxy = (100 @ 200).
	self 
		should: [ proxy = Object new ]
		raise: RSTRemoteObjectUnreachable
]

{ #category : #testing }
RSTBrokerTest >> testProxyAnswersEqualsOfOtherObjectsEvenIfUnreachable [
	|  proxy array |
	extraBroker
		export: Object new
		named: 'someObject'.
	proxy := ('someObject@' , self extraIpAndPortString) asLocalObject.
	extraBroker stop.
	self deny: proxy isReachable.
	array := #(1 2 3).
	self shouldnt: [proxy = array] raise: Exception.
	self deny: proxy = array
]

{ #category : #testing }
RSTBrokerTest >> testProxyAnswersEqualsOfOtherProxiesEvenIfUnreachable [
	| proxy otherProxy |
	extraBroker 
		export: Object new
		named: 'someObject'.
	proxy := ('someObject@' , self extraIpAndPortString) asLocalObject.
	extraBroker 
		export: Array new
		named: 'array'.
	otherProxy := ('array@' , self extraIpAndPortString) asLocalObject.
	extraBroker stop.
	self deny: proxy isReachable.
	self deny: otherProxy isReachable.
	self 
		shouldnt: [ proxy = otherProxy ]
		raise: Exception.
	self deny: proxy = otherProxy
]

{ #category : #testing }
RSTBrokerTest >> testProxyStoresHashCode [
	"Noury 1/20/2009 11:37"
	
	| actualObject proxy expectedHashCode |
	actualObject := Object new.
	extraBroker
		export: actualObject
		named: 'someObject'.
	proxy := ('someObject@' , self extraIpAndPortString) asLocalObject.
	expectedHashCode :=  actualObject hash.
	extraBroker stop.
	self deny: proxy isReachable.
	self assert: proxy hash == expectedHashCode

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

{ #category : #testing }
RSTBrokerTest >> testServerShouldNotFailOnSocketFailure [
	|socket|
	socket := Socket newTCP.
	self shouldnt: [extraBroker process: socket] raise: Exception
	 
]

{ #category : #testing }
RSTBrokerTest >> testSimpleRemoteMutualEvaluation [
	
	"Mutual Proxy evaluation test, with proxy as Remote Object"
	
	| proxyFromExtra2DefaultBroker proxyFromDefaultBroker |
	extraBroker export: DummyClass new named: 'dClass'.
	defaultBroker export: DummyClass new named: 'dClass'.
	proxyFromExtra2DefaultBroker := (RSTRemoteObjectID fromString: ('dClass@', self extraIpAndPortString)) asProxy.
	proxyFromDefaultBroker := (RSTRemoteObjectID fromString: ('dClass@', self defaultIpAndPortString)) asLocalObject.
	self assert: (proxyFromExtra2DefaultBroker isRemote).
	self deny: (proxyFromDefaultBroker isRemote).
	self assert: ( (proxyFromExtra2DefaultBroker decrement: 100 with: proxyFromDefaultBroker) = 0).
]

{ #category : #testing }
RSTBrokerTest >> testStartStop [
	"mp 12/16/2005 13:21"

	| expectedBrokerID |
	self assert: defaultBroker isRunning.
	self assert: extraBroker isRunning.
	RSTBroker stop.
	defaultBroker waitForStop.
	self assert: (RSTBroker instVarNamed: 'instance') isNil.
	RSTBroker startOnPort: self defaultPort.
	self assert: RSTBroker instance isRunning.
	self assert: RSTBroker instance portNumber = self defaultPort.
	expectedBrokerID := NetNameResolver localAddressString , ':', self defaultPort printString.
	self assert: RSTBroker instance brokerID = expectedBrokerID.
	RSTBroker stop.
	self assert: (RSTBroker instVarNamed: 'instance') isNil
]
