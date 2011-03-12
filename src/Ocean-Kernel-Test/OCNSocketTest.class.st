Class {
	#name : #OCNSocketTest,
	#superclass : #TestCase,
	#instVars : [
		'socket',
		'library',
		'serverShell'
	],
	#category : #'Ocean-Kernel-Test'
}

{ #category : #testing }
OCNSocketTest class >> isAbstract [
	^true
]

{ #category : #accessing }
OCNSocketTest >> serverPort [
	^9123
]

{ #category : #accessing }
OCNSocketTest >> serverShellClass [ 
	^OCNFileStdOutShell
]

{ #category : #'setUp-tearDown' }
OCNSocketTest >> setUp [
	super setUp.
	library := OCNNetworkLibraryProxyFactory proxyForLibraryClass: self networkLibraryClass.
	self setUpServerShell
]

{ #category : #'setUp-tearDown' }
OCNSocketTest >> setUpServerShell [
	serverShell := self serverShellClass onStdOutFileNamed: 'test.log'
]

{ #category : #'server management' }
OCNSocketTest >> startServer [
	serverShell exec: 'nc -4 -l ' , String space , self serverPort printString.
	(Delay forMilliseconds: 50) wait
]

{ #category : #'setUp-tearDown' }
OCNSocketTest >> tearDown [
	super tearDown.
	serverShell deleteStdOutFile.
	serverShell kill.
	socket destroy.
]
