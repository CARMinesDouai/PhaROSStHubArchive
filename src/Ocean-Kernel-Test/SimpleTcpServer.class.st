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
	#name : #SimpleTcpServer,
	#superclass : #Object,
	#instVars : [
		'isRunning',
		'stateLock',
		'connectionSocket',
		'portNumber'
	],
	#category : #'Ocean-Kernel-TestSupport'
}

{ #category : #'instance creation' }
SimpleTcpServer class >> onPortNumber: anInteger [
	^self new
		portNumber: anInteger;
		yourself  
]

{ #category : #accessing }
SimpleTcpServer >> connectionSocket [
	^ connectionSocket
]

{ #category : #accessing }
SimpleTcpServer >> connectionSocket: anObject [
	connectionSocket := anObject
]

{ #category : #running }
SimpleTcpServer >> handleConnections [
	| interactionSocket interactionStream |
	interactionSocket := self connectionSocket 
		waitForAcceptFor: 30  
		ifTimedOut: [^self].
	interactionStream := SocketStream on: interactionSocket.
	[self interactThenClose: interactionStream] fork

]

{ #category : #'initialize-release' }
SimpleTcpServer >> initialize [ 
	super initialize.
	stateLock := Mutex new.
	self isRunning: false  
]

{ #category : #running }
SimpleTcpServer >> interactThenClose: aSocketStream [
	[
		self interactThrough: aSocketStream
	] ensure: [
		aSocketStream close.
	] 

]

{ #category : #running }
SimpleTcpServer >> interactThrough: aSocketStream [
	self subclassResponsibility
]

{ #category : #accessing }
SimpleTcpServer >> isRunning [
	stateLock critical: [^isRunning]
]

{ #category : #accessing }
SimpleTcpServer >> isRunning: aBoolean [
	stateLock critical: [isRunning := aBoolean]
]

{ #category : #accessing }
SimpleTcpServer >> portNumber [
	^ portNumber
]

{ #category : #accessing }
SimpleTcpServer >> portNumber: anInteger [
	portNumber := anInteger
]

{ #category : #running }
SimpleTcpServer >> serve [
	self connectionSocket: Socket newTCP.
	[
		self connectionSocket listenOn: self portNumber backlogSize: 10.
		[self isRunning] whileTrue: [self handleConnections].
	] ensure: [
		self connectionSocket closeAndDestroy].
	
]

{ #category : #running }
SimpleTcpServer >> start [
	stateLock
		critical: [ 
			self isRunning
				ifTrue: [ ^ self ].
			self isRunning: true ].
	[self serve] fork
]

{ #category : #running }
SimpleTcpServer >> stop [
	self isRunning: false
]
