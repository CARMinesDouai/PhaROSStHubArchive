Class {
	#name : #PhaROSTcpServer,
	#superclass : #TcpService,
	#traits : 'TLogger',
	#classTraits : 'TLogger classTrait',
	#instVars : [
		'owner'
	],
	#classInstVars : [
		'RoStTcpServers'
	],
	#category : #'PhaROS-Kernel-Tcp'
}

{ #category : #constructors }
PhaROSTcpServer class >> initialize [ 
	RoStTcpServers := Dictionary new.

]

{ #category : #constructors }
PhaROSTcpServer class >> listenAt: anAddress port: aPort for: aNode [
	^RoStTcpServers at: anAddress, aPort asString ifAbsentPut: [
		self new address: anAddress port: aPort ; owner: aNode; yourself.
	]

]

{ #category : #constructors }
PhaROSTcpServer class >> startOn: aPort named: aName for: aNode [
	^RoStTcpServers at: aPort ifAbsentPut: [
		(self startOn: aPort named: aName)  
					owner: aNode; 
					start;
					yourself.
	].

]

{ #category : #service }
PhaROSTcpServer class >> stop: aRoStTcpServer [ 

	RoStTcpServers removeKey: aRoStTcpServer portNumber.
	
	aRoStTcpServer stop.
	aRoStTcpServer kill.
	
	self removeService: aRoStTcpServer.
]

{ #category : #accessing }
PhaROSTcpServer >> owner [
	^ owner
]

{ #category : #server }
PhaROSTcpServer >> owner: aNode [
	owner := aNode.
]

{ #category : #server }
PhaROSTcpServer >> serve: aSocket [
	| data message response topic bytesRead|
	

	
	data := String new: 3072.
	
	bytesRead := aSocket receiveDataWithTimeoutInto: data.
	
	
	
	self flag:#makeUpToThisThing.
	message := PhaROSHandShakeMessageDecoder decodeSubscriberMessage: (data copyFrom: 1 to: bytesRead).
	message verify.
	
	self owner manageIncomingConnection: message with: aSocket.
	
	
]
