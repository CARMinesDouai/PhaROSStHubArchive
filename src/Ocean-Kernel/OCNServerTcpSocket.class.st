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
OCNServerTcpSocket >> listenAllInterfacesOnPort: portNumber [
	"Listens on the given port for all interfaces of the machine"

	|ipAddress|
	ipAddress := OCNIpv4Address new.
	ipAddress
	 	ip: #[0 0 0 0];
		port: portNumber.
	self listenOn: ipAddress.
]

{ #category : #serving }
OCNServerTcpSocket >> listenOn: anIpAddress [
	"Listens on the interface whose IP corresponds to the provided address"
	
	[ self networkLibrary listen: self on: anIpAddress  ]
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
