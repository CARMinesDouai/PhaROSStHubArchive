Class {
	#name : #OCNServerTcpSocket,
	#superclass : #OCNTcpSocket,
	#instVars : [
		'backlogSize',
		'acceptTimeOutSeconds'
	],
	#category : #'Ocean-Kernel'
}

{ #category : #serving }
OCNServerTcpSocket >> accept [
	
	^self networkLibrary acceptFrom: self.
]

{ #category : #accessing }
OCNServerTcpSocket >> acceptTimeoutSeconds [
	^ acceptTimeOutSeconds
]

{ #category : #accessing }
OCNServerTcpSocket >> acceptTimeoutSeconds: anObject [
	acceptTimeOutSeconds := anObject
]

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
	self acceptTimeoutSeconds: 3. 
]

{ #category : #'state testing' }
OCNServerTcpSocket >> isListening [
	^self state = self listeningStateSymbol 
]

{ #category : #serving }
OCNServerTcpSocket >> listenOn: anIpAddress [
	self bindToAddress: anIpAddress.
	[ self networkLibrary listen: self ]
		on: OCNSocketOperationFailureError
		do: [ :ex | 
			self destroy.
			ex pass ].
	self state: self listeningStateSymbol
]

{ #category : #'state names' }
OCNServerTcpSocket >> listeningStateSymbol [
	^#listening
]
