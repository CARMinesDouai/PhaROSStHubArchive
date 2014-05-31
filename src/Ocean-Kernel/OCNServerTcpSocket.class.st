"
the socket_api protocol is a compatibility layer with old sockets
"
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

{ #category : #'socket_api' }
OCNServerTcpSocket >> acceptFrom: aSocket [
	
	^self networkLibrary acceptFrom: aSocket.
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

{ #category : #'socket_api' }
OCNServerTcpSocket >> isConnected [

	"it makes no sense to have isConnected on listening socket but it is used in the old API"
	^ self networkLibrary isSocketConnected: self
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

{ #category : #'socket_api' }
OCNServerTcpSocket >> listenOn: aPortNumber backlogSize: backlog [
	"Listens on the interface whose IP corresponds to the provided address"
	
	self backlogSize: backlog.
	self listenAllInterfacesOnPort: aPortNumber
]

{ #category : #'state names' }
OCNServerTcpSocket >> listeningStateSymbol [
	^#listening
]
