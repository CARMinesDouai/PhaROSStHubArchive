Class {
	#name : #OCNSocketTest,
	#superclass : #TestCase,
	#instVars : [
		'socket',
		'library',
		'serverShell',
		'serverAddress'
	],
	#category : #'Ocean-Kernel-Test'
}

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
OCNSocketTest >> serverAddress [
	^ serverAddress 
]

{ #category : #'server management' }
OCNSocketTest >> serverCommandString [
	^ self subclassResponsibility 
]

{ #category : #accessing }
OCNSocketTest >> serverPort [
	^9123
]

{ #category : #accessing }
OCNSocketTest >> serverShell [ 
	^serverShell 
]

{ #category : #accessing }
OCNSocketTest >> serverShellClass [ 
	^OCNFileStdOutShell
]

{ #category : #'setUp-tearDown' }
OCNSocketTest >> setUp [
	super setUp.
	library := OCNNetworkLibraryProxyFactory proxyForLibraryClass: self networkLibraryClass.
	socket := self socketClass newWithNetworkLibrary: self library.
	serverAddress := OCNIPV4SocketAddress loopbackAddressWithPort:  self serverPort.
	self setUpServerShell
]

{ #category : #'setUp-tearDown' }
OCNSocketTest >> setUpServerShell [
	serverShell := self serverShellClass onStdOutFileNamed: 'test.log'
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
	serverShell exec: self serverCommandString , String space , self serverPort printString.
	(Delay forMilliseconds: 50) wait
]

{ #category : #'setUp-tearDown' }
OCNSocketTest >> tearDown [
	super tearDown.
	serverShell deleteStdOutFile.
	serverShell kill.
	socket destroy.
]
