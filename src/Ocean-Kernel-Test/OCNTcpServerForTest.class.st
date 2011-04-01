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
	process resume
]

{ #category : #running }
OCNTcpServerForTest >> stop [
	self isRunning: false
]
