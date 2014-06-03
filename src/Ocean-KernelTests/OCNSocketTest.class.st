Class {
	#name : #OCNSocketTest,
	#superclass : #TestCase,
	#instVars : [
		'socket',
		'library'
	],
	#category : #'Ocean-KernelTests'
}

{ #category : #testing }
OCNSocketTest class >> isAbstract [
	^true
]

{ #category : #accessing }
OCNSocketTest class >> lookupHierarchyRoot [
	^self superclass
]

{ #category : #coverage }
OCNSocketTest class >> packageNamesUnderTest [
	^ #('Ocean-Kernel' 'Ocean-LibraryPlugin')
]

{ #category : #accessing }
OCNSocketTest class >> shouldBeSubclassedForBackendTesting [
	^false
]

{ #category : #'asserting lifecycle' }
OCNSocketTest >> assertSocket: aSocket state: aSelectorToAssert [

	| selectorsToDeny |
	
	self assert: (aSocket perform: aSelectorToAssert).
	
	selectorsToDeny := self stateTestingSelectors copyWithout: aSelectorToAssert.
	
	selectorsToDeny do: [ :aSelectorToDeny | 
		self deny: (aSocket perform: aSelectorToDeny)
	]

	
]

{ #category : #'asserting lifecycle' }
OCNSocketTest >> assertSocketState: aSelectorToAssert [
	self assertSocket: socket state: aSelectorToAssert
]

{ #category : #accessing }
OCNSocketTest >> library [
	^library 
]

{ #category : #accessing }
OCNSocketTest >> networkLibraryClass [
	^self subclassResponsibility
]

{ #category : #'data for tests' }
OCNSocketTest >> randomAsciiStringOfSize: dataSize [
 	^OCNStringGenerator randomStringOfSize: dataSize

]

{ #category : #'server management' }
OCNSocketTest >> serverClass [ 
	self subclassResponsibility 
]

{ #category : #'setUp-tearDown' }
OCNSocketTest >> setUp [
	super setUp.
	library := OCNNetworkLibraryProxyFactory proxyForLibraryClass: self networkLibraryClass.
	self setUpSocketWithLibrary: self library.
]

{ #category : #'setUp-tearDown' }
OCNSocketTest >> setUpSocketWithLibrary: aLibrary [
	socket := self socketClass newWithNetworkLibrary: aLibrary
]

{ #category : #accessing }
OCNSocketTest >> socket [ 
	^socket
]

{ #category : #accessing }
OCNSocketTest >> socketClass [ 
	^self subclassResponsibility 
]

{ #category : #'server management' }
OCNSocketTest >> startServerAndValue: block [
	self startServerOnPort: 9876 andValue: block
]

{ #category : #'server management' }
OCNSocketTest >> startServerOnPort: port andValue: block [
	|server serverReadySemaphore|
	serverReadySemaphore := Semaphore new. 
	server:= (self serverClass onPortNumber: port)
		afterStartDo: [serverReadySemaphore signal];
		yourself.
	[
		server start.
		(serverReadySemaphore waitTimeoutSeconds: 3) ifTrue: [
			self signalFailure: 'Server did not start'].
		block cull: server
	] ensure: [server kill]
]

{ #category : #accessing }
OCNSocketTest >> stateTestingSelectors [ 
	^self subclassResponsibility 
]

{ #category : #'setUp-tearDown' }
OCNSocketTest >> tearDown [
	super tearDown.
	socket ifNotNil: [socket destroy].
]

{ #category : #testing }
OCNSocketTest >> testDestroyDestroyedSocket [
	self testDestroyUnconnectedSocket.
	self assertSocketState: #isDestroyed.
	self shouldnt: [socket destroy] raise: Error.
	self assertSocketState: #isDestroyed.
	
]

{ #category : #testing }
OCNSocketTest >> testDestroyUnconnectedSocket [
	self assertSocketState: #isClean.
	socket destroy.
	self assertSocketState: #isDestroyed.

]
