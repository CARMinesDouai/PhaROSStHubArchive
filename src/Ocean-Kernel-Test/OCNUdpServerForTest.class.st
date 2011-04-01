Class {
	#name : #OCNUdpServerForTest,
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
OCNUdpServerForTest class >> onPortNumber: anInteger [
	^self new
		portNumber: anInteger;
		yourself  
]

{ #category : #accessing }
OCNUdpServerForTest >> connectionSocket [
	^ connectionSocket
]

{ #category : #accessing }
OCNUdpServerForTest >> connectionSocket: anObject [
	connectionSocket := anObject
]

{ #category : #running }
OCNUdpServerForTest >> handleConnections [
	| interactionSocket interactionStream |
	interactionSocket := self connectionSocket 
		waitForAcceptFor: 30  
		ifTimedOut: [^self].
	interactionStream := SocketStream on: interactionSocket.
	[self interactThenClose: interactionStream] fork

]

{ #category : #accessing }
OCNUdpServerForTest >> initialize [ 
	super initialize.
	stateLock := Mutex new.
	self isRunning: false.
	self connectionSocket: Socket newUDP.
]

{ #category : #running }
OCNUdpServerForTest >> interactThenClose: aSocketStream [
	[
		self interactThrough: aSocketStream
	] ensure: [
		aSocketStream close.
	] 

]

{ #category : #running }
OCNUdpServerForTest >> interactThrough: aSocketStream [
	self subclassResponsibility
]

{ #category : #accessing }
OCNUdpServerForTest >> isRunning [
	stateLock critical: [^isRunning]
]

{ #category : #accessing }
OCNUdpServerForTest >> isRunning: aBoolean [
	stateLock critical: [isRunning := aBoolean]
]

{ #category : #accessing }
OCNUdpServerForTest >> portNumber [
	^ portNumber
]

{ #category : #accessing }
OCNUdpServerForTest >> portNumber: anInteger [
	portNumber := anInteger
]

{ #category : #running }
OCNUdpServerForTest >> serve [
	[
		self connectionSocket listenOn: self portNumber backlogSize: 10.
		[self isRunning] whileTrue: [self handleConnections].
	] ensure: [
		self connectionSocket closeAndDestroy].
	
]

{ #category : #running }
OCNUdpServerForTest >> start [
	stateLock
		critical: [ 
			self isRunning
				ifTrue: [ ^ self ].
			self isRunning: true ].
	[self serve] fork
]

{ #category : #running }
OCNUdpServerForTest >> stop [
	self isRunning: false
]
