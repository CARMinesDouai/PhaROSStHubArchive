"
in OCNZnNetworkingUtils class>>#install

eventually add: 

self default socketStreamClass: OCNZdcSocketStream.
""custom version of ZdcSocketStream that used OCNSockets""

self default secureSocketStreamClass: OCNZdcSecureSocketStream.
""custom version of ZdcSecureSocketStream""
"
Class {
	#name : #OCNetworkingUtils,
	#superclass : #ZnNetworkingUtils,
	#category : #'Ocean-ZincZodiacIntegration'
}

{ #category : #acccessing }
OCNetworkingUtils >> netNameResolverClass [
	self flag: #todo.
	^ NetNameResolver
]

{ #category : #acccessing }
OCNetworkingUtils >> serverSocketClass [
	^ OCNServerTcpSocket 
]

{ #category : #public }
OCNetworkingUtils >> serverSocketOn: port [
	| socket |
	socket := self serverSocketClass new.
	self setServerSocketOptions: socket.
	socket listenOn: port backlogSize: self class listenBacklogSize.
	socket isValid
		ifFalse: [ self error: 'Cannot create socket on port ', port printString ].
	^ socket
]

{ #category : #public }
OCNetworkingUtils >> serverSocketOn: port interface: address [
	| socket |
	socket := self serverSocketClass new.
	self setServerSocketOptions: socket.
	socket 
		listenOn: port 
		backlogSize: self class listenBacklogSize 
		interface: address.
	socket isValid
		ifFalse: [ self error: 'Cannot create socket on port ', port printString ].
	^ socket
]

{ #category : #public }
OCNetworkingUtils >> socketStreamToUrlDirectly: url [
	| stream address |
	address := self netNameResolverClass addressForName: url host timeout: self timeout.
	stream := (self streamClassForScheme: url scheme)
		openConnectionToHost: address
		port: url portOrDefault
		timeout: self timeout.
	self setSocketStreamParameters: stream.
	(#(#https #wss) includes: url scheme)
		ifTrue: [ stream connect ].
	^ stream
]
