Class {
	#name : #OCNSocketTest,
	#superclass : #TestCase,
	#instVars : [
		'socket',
		'library',
		'server',
		'serverAddress'
	],
	#category : #'Ocean-Kernel-Test'
}

{ #category : #'as yet unclassified' }
OCNSocketTest class >> allTestSelectors [ 
	^self superclass testSelectors, self testSelectors
]

{ #category : #testing }
OCNSocketTest class >> isAbstract [
	^true
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
	| randomStringGenerator |
	randomStringGenerator := OCNBench new.
	^ randomStringGenerator createRandomStringOfSize: dataSize.

]

{ #category : #accessing }
OCNSocketTest >> server [
	^ server 
]

{ #category : #accessing }
OCNSocketTest >> serverAddress [
	^ serverAddress 
]

{ #category : #'setUp-tearDown' }
OCNSocketTest >> serverClass [
	^self subclassResponsibility 
]

{ #category : #accessing }
OCNSocketTest >> serverPort [
	^9123
]

{ #category : #'setUp-tearDown' }
OCNSocketTest >> setUp [
	super setUp.
	library := OCNNetworkLibraryProxyFactory proxyForLibraryClass: self networkLibraryClass.
	socket := self socketClass newWithNetworkLibrary: self library.
	serverAddress := OCNIPV4SocketAddress loopbackAddressWithPort:  self serverPort.

]

{ #category : #'setUp-tearDown' }
OCNSocketTest >> setUpServer [
	server:= self serverClass onPortNumber: self serverPort 
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
OCNSocketTest >> startServer [
	self setUpServer.
	server start.
	(Delay forMilliseconds: 50) wait
]

{ #category : #'setUp-tearDown' }
OCNSocketTest >> tearDown [
	super tearDown.
	server stop.
	socket destroy.
]
