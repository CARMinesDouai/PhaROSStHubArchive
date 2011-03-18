Class {
	#name : #SimpleUdpServer,
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
SimpleUdpServer class >> onPortNumber: anInteger [
	^self new
		portNumber: anInteger;
		yourself  
]

{ #category : #accessing }
SimpleUdpServer >> connectionSocket [
	^ connectionSocket
]

{ #category : #accessing }
SimpleUdpServer >> connectionSocket: anObject [
	connectionSocket := anObject
]

{ #category : #running }
SimpleUdpServer >> handleConnections [
	| interactionSocket interactionStream |
	interactionSocket := self connectionSocket 
		waitForAcceptFor: 30  
		ifTimedOut: [^self].
	interactionStream := SocketStream on: interactionSocket.
	[self interactThenClose: interactionStream] fork

]

{ #category : #accessing }
SimpleUdpServer >> initialize [ 
	super initialize.
	stateLock := Mutex new.
	self isRunning: false.
	self connectionSocket: (OCNUdpSocket newWithNetworkLibrary: OCNSocketPluginLibrary)
]

{ #category : #running }
SimpleUdpServer >> interactThenClose: aSocketStream [
	[
		self interactThrough: aSocketStream
	] ensure: [
		aSocketStream close.
	] 

]

{ #category : #running }
SimpleUdpServer >> interactThrough: aSocketStream [
	self subclassResponsibility
]

{ #category : #accessing }
SimpleUdpServer >> isRunning [
	stateLock critical: [^isRunning]
]

{ #category : #accessing }
SimpleUdpServer >> isRunning: aBoolean [
	stateLock critical: [isRunning := aBoolean]
]

{ #category : #accessing }
SimpleUdpServer >> portNumber [
	^ portNumber
]

{ #category : #accessing }
SimpleUdpServer >> portNumber: anInteger [
	portNumber := anInteger
]

{ #category : #running }
SimpleUdpServer >> serve [
	[
		self connectionSocket listenOn: self portNumber backlogSize: 10.
		[self isRunning] whileTrue: [self handleConnections].
	] ensure: [
		self connectionSocket closeAndDestroy].
	
]

{ #category : #running }
SimpleUdpServer >> start [
	stateLock
		critical: [ 
			self isRunning
				ifTrue: [ ^ self ].
			self isRunning: true ].
	[self serve] fork
]

{ #category : #running }
SimpleUdpServer >> stop [
	self isRunning: false
]
