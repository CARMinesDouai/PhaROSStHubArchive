Class {
	#name : #OCNServerTcpSocket,
	#superclass : #OCNTcpSocket,
	#instVars : [
		'backlogSize',
		'timeOutSeconds'
	],
	#category : #'Ocean-Kernel'
}

{ #category : #accessing }
OCNServerTcpSocket >> backlogSize [
	^backlogSize
]

{ #category : #accessing }
OCNServerTcpSocket >> backlogSize: anInteger [
	backlogSize := anInteger
]

{ #category : #'initialize-release' }
OCNServerTcpSocket >> initialize [	
	super initialize.
	self backlogSize: 10.
	self timeOutSeconds: 3.
]

{ #category : #'state testing' }
OCNServerTcpSocket >> isListening [
	^self state = self listeningStateSymbol 
]

{ #category : #accessing }
OCNServerTcpSocket >> listenOn: anIpAddress [ 

	self isClean ifFalse: [ 
		OCNSocketOperationForbiddenError signal: self state asString capitalized, ' socket can not listen' ].
	[
		self networkLibrary listen: self on: anIpAddress
	] on: OCNSocketOperationFailureError do: [:ex|
		self destroy.
		ex pass.
	].

	self state: self listeningStateSymbol.
	
	^self networkLibrary acceptFrom: self.
	
	
]

{ #category : #accessing }
OCNServerTcpSocket >> listenOn: anIpAddress onAcceptDo: acceptBlock [
	self isClean ifFalse: [ 
		OCNSocketOperationForbiddenError signal: self state asString capitalized, ' socket can not listen' ].
	[
		self networkLibrary listen: self on: anIpAddress
	] on: OCNSocketOperationFailureError do: [:ex|
		self destroy.
		ex pass.
	].

	self state: self listeningStateSymbol.
	
	[self isListening] whileTrue: [ |conversationSocket|
		conversationSocket := self networkLibrary acceptFrom: self.
		acceptBlock value: conversationSocket
	].
	
	
	
	
]

{ #category : #'state names' }
OCNServerTcpSocket >> listeningStateSymbol [
	^#listening
]

{ #category : #accessing }
OCNServerTcpSocket >> timeOutSeconds [
	^timeOutSeconds
]

{ #category : #accessing }
OCNServerTcpSocket >> timeOutSeconds: seconds [
	timeOutSeconds := seconds
]
