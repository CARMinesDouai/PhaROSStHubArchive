"
""Code for the talk on networking @ Deep Into Smalltalk Spring School 2011""
""Slides and other materials online http://car.mines-douai.fr/noury/docs""
""Noury Bouraqadi march 2011""

Abstract class for simple TCP server.
A simple server is multi-threaded. It waits for connection in a dedicated process and handles client interactions in different processes (one per client).
Subclasses should implement method #interactThrough: aSocketStream. The argument is a socket stream connected to a client.

To create a server, send the #onPortNumber: message to a concrete server class. The argument is the number of port where the server will wait for client connections. 

Usefull messages:
#start -- starts the server
#stop -- stop the server
#isRunning -- answers true if the server is started



"
Class {
	#name : #OCNTcpServerForTest,
	#superclass : #Object,
	#instVars : [
		'isRunning',
		'stateLock',
		'connectionSocket',
		'portNumber',
		'process'
	],
	#category : #'Ocean-Kernel-TestSupport'
}

{ #category : #'instance creation' }
OCNTcpServerForTest class >> onPortNumber: anInteger [
	^self new
		portNumber: anInteger;
		yourself  
]

{ #category : #accessing }
OCNTcpServerForTest >> connectionSocket [
	^ connectionSocket
]

{ #category : #accessing }
OCNTcpServerForTest >> connectionSocket: anObject [
	connectionSocket := anObject
]

{ #category : #running }
OCNTcpServerForTest >> handleConnections [
	| interactionSocket interactionStream |
	interactionSocket := self connectionSocket 
		waitForAcceptFor: 30  
		ifTimedOut: [^self].
	interactionStream := SocketStream on: interactionSocket.
	[self interactThenClose: interactionStream] fork

]

{ #category : #'initialize-release' }
OCNTcpServerForTest >> initialize [ 
	super initialize.
	stateLock := Mutex new.
	self isRunning: false.
	
]

{ #category : #running }
OCNTcpServerForTest >> interactThenClose: aSocketStream [
	[
		self interactThrough: aSocketStream
	] ensure: [
		aSocketStream close.
	] 

]

{ #category : #running }
OCNTcpServerForTest >> interactThrough: aSocketStream [
	receivedDataStream nextPutAll: aSocketStream upToEnd
]

{ #category : #accessing }
OCNTcpServerForTest >> isRunning [
	stateLock critical: [^isRunning]
]

{ #category : #accessing }
OCNTcpServerForTest >> isRunning: aBoolean [
	stateLock critical: [isRunning := aBoolean]
]

{ #category : #running }
OCNTcpServerForTest >> kill [
	process terminate
]

{ #category : #accessing }
OCNTcpServerForTest >> portNumber [
	^ portNumber
]

{ #category : #accessing }
OCNTcpServerForTest >> portNumber: anInteger [
	portNumber := anInteger
]

{ #category : #accessing }
OCNTcpServerForTest >> receivedData [
	^receivedDataStream contents 
]

{ #category : #running }
OCNTcpServerForTest >> serve [
	self connectionSocket: Socket newTCP.
	[
		self connectionSocket listenOn: self portNumber backlogSize: 10.
		[self isRunning] whileTrue: [self handleConnections].
	] ensure: [
		self connectionSocket closeAndDestroy].
	
]

{ #category : #running }
OCNTcpServerForTest >> start [
	stateLock
		critical: [ 
			self isRunning
				ifTrue: [ ^ self ].
			self isRunning: true ].
	process := [self serve] newProcess.
	process priority: Processor lowIOPriority.
	process resume
]

{ #category : #running }
OCNTcpServerForTest >> stop [
	self isRunning: false
]
