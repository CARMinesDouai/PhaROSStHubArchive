Class {
	#name : #OCNUdpServerForTest,
	#superclass : #Object,
	#instVars : [
		'isRunning',
		'stateLock',
		'listenSocket',
		'listenAddress',
		'portNumber',
		'process'
	],
	#category : #'Ocean-Kernel-Test-Support'
}

{ #category : #'instance creation' }
OCNUdpServerForTest class >> onPortNumber: anInteger [
	^self new
		portNumber: anInteger;
		yourself  
]

{ #category : #accessing }
OCNUdpServerForTest >> initialize [ 
	super initialize.
	stateLock := Mutex new.
	self isRunning: false.
	
]

{ #category : #running }
OCNUdpServerForTest >> interactThrough [
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

{ #category : #running }
OCNUdpServerForTest >> kill [
	process terminate
]

{ #category : #accessing }
OCNUdpServerForTest >> listenSocket [
	^ listenSocket
]

{ #category : #accessing }
OCNUdpServerForTest >> listenSocket: anObject [
	listenSocket := anObject
]

{ #category : #accessing }
OCNUdpServerForTest >> portNumber [
	^ portNumber
]

{ #category : #accessing }
OCNUdpServerForTest >> portNumber: anObject [
	portNumber := anObject
]

{ #category : #running }
OCNUdpServerForTest >> serve [
	
	[
		self setUpListenSocket.
		[self isRunning] whileTrue: [self interactThrough].
	] ensure: [
		self listenSocket closeAndDestroy].
]

{ #category : #accessing }
OCNUdpServerForTest >> setUpListenSocket [
	listenSocket:= Socket newUDP
	
]

{ #category : #running }
OCNUdpServerForTest >> start [
	stateLock
		critical: [ 
			self isRunning
				ifTrue: [ ^ self ].
			self isRunning: true ].
	process := [self serve] newProcess.
	"process priority: Processor lowIOPriority."
	process resume
]

{ #category : #running }
OCNUdpServerForTest >> stop [
	self isRunning: false
]
