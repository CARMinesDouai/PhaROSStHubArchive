"
A RoStServiceProxy is a placeholder for a service provided by some node. Usually, you don't create directly service proxies. Instead, they are obtained from the master node (see RoStMasterProxy>>#lookupService: serviceName)

"
Class {
	#name : #PhaROSServiceProxy,
	#superclass : #Object,
	#instVars : [
		'uri',
		'serviceName',
		'md5sum',
		'requestType',
		'responseType'
	],
	#category : #'PhaROS-Network-XmlRpc'
}

{ #category : #'instance creation' }
PhaROSServiceProxy class >> serviceName: serviceName uriFrom: uriString [
	^self new
		serviceName: serviceName;
		uriFrom: uriString;
		loadType;
		yourself
]

{ #category : #calling }
PhaROSServiceProxy >> bytesForMessageWithArgs: args [
	^ PhaROSHSMessageEncoder encode: (self messageWithArgs: args).
]

{ #category : #calling }
PhaROSServiceProxy >> call [
	^self callWithArgs: #()
]

{ #category : #calling }
PhaROSServiceProxy >> callWithArgs: args [
	| socketStr messageBytes response |
	args size > 0 ifTrue: [
		Error signal: ' Un implemented call to service with arguments '	.
	].
	
	messageBytes := self bytesForMessageWithArgs: args.
	socketStr := SocketStream openConnectionToHostNamed: self hostName port: self port.
	^
	[ 
		socketStr sendCommand: messageBytes, #[0 0 0 0].
		response := socketStr upToEnd.
		socketStr close.
		PhaROSHSMessage newServiceMessageFrom: response asByteArray readStream
	] doIt asResult.


]

{ #category : #accessing }
PhaROSServiceProxy >> callerId [ 
	^'/anArbitraryId'
]

{ #category : #accessing }
PhaROSServiceProxy >> hostName [
	^ self uri host
]

{ #category : #ros }
PhaROSServiceProxy >> loadType [
	|socketStr typeBrowse response |
	socketStr := SocketStream openConnectionToHostNamed: self hostName port: self port.
	
	typeBrowse := PhaROSHSMessage newServiceClientWith: [
		:header |
		header callerId: self callerId;
				md5Sum: '*';
				probe;
				service: self serviceName
	   ].
	socketStr sendCommand:( PhaROSHSMessageEncoder encode: typeBrowse), #[0 0 0 0].
	response := socketStr upToEnd.
	socketStr close.
	response := PhaROSHSMessage newServiceMessageFrom: response asByteArray readStream.
	md5sum := response md5sum.
	requestType := response requestType.
	responseType := response responseType.
]

{ #category : #calling }
PhaROSServiceProxy >> md5Sum [
	md5sum  ifNil: [ md5sum := 'd41d8cd98f00b204e9800998ecf8427e' ] .
	^md5sum.
]

{ #category : #calling }
PhaROSServiceProxy >> md5sum: aSum [
	md5sum := aSum.
]

{ #category : #calling }
PhaROSServiceProxy >> messageWithArgs: args [

	^ PhaROSHSMessage newServiceClientWith: [
		:header |
		header callerId: self callerId;
				md5Sum: self md5Sum;
				service: self serviceName
	   ].
		

]

{ #category : #accessing }
PhaROSServiceProxy >> port [
	^ self uri port
]

{ #category : #accessing }
PhaROSServiceProxy >> serviceName [
	^ serviceName
]

{ #category : #accessing }
PhaROSServiceProxy >> serviceName: anObject [
	serviceName := anObject
]

{ #category : #accessing }
PhaROSServiceProxy >> uri [
	^ uri
]

{ #category : #accessing }
PhaROSServiceProxy >> uri: anObject [
	uri := anObject
]

{ #category : #'initialize-release' }
PhaROSServiceProxy >> uriFrom: aString [
	| newUri |
	newUri := URI fromString: aString.
	self uri: newUri
]
