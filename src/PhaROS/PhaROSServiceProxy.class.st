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
	^self call: [ : m | ]
]

{ #category : #calling }
PhaROSServiceProxy >> call: aBlock [

	| socketStr messageBytes response request |

	request := requestType newPacket.
	
	aBlock value: request value. 
	
	messageBytes := (PhaROSHSMessageEncoder encode: (self messageHeader)), request dump.
	
	socketStr := SocketStream openConnectionToHostNamed: self hostName port: self port.
	^
	[ 
		|  header stream |

		socketStr sendCommand: messageBytes.
		response := responseType newPacket.
		stream := socketStr upToEnd asByteArray readStream.
		socketStr close.
		header := PhaROSHSMessageHeader newServiceClientMessageFrom: stream.
		
		header persistent ifTrue: [  self error:' Persistent service is not implemented yet'   ].
		
		
		self flag: #thisStreamNextIsABug. "BUG"
		stream next.
		
		response loadStream: stream.
		response value.
	] shootIt asResult.


]

{ #category : #accessing }
PhaROSServiceProxy >> callerId [ 
	^'/anArbitraryId'
]

{ #category : #accessing }
PhaROSServiceProxy >> hostName [
	^ self uri host
]

{ #category : #calling }
PhaROSServiceProxy >> loadType [

	| socketStr messageBytes header types |

	
	messageBytes := (PhaROSHSMessageEncoder encode: (self messageHeaderForBrowseType)), #[0 0 0 0].
	
	socketStr := SocketStream openConnectionToHostNamed: self hostName port: self port.
	socketStr sendCommand: messageBytes.
	header := PhaROSHSMessageHeader newServiceClientMessageFrom: (socketStr upToEnd ) asByteArray readStream.
	socketStr close.

	types := (PhaROSTypeBrowser instance serviceType: header type) .
	"self assert: header md5Sum  = types md5Sum description: 'Incompatible type hash'. "
	requestType :=  types request.
	responseType := types response.
	md5sum := header md5Sum.
	

]

{ #category : #calling }
PhaROSServiceProxy >> md5Sum [
	md5sum  ifNil: [ md5sum := 'd41d8cd98f00b204e9800998ecf8427e' ] .
	^md5sum.
]

{ #category : #calling }
PhaROSServiceProxy >> md5Sum: aSum [
	md5sum := aSum.
]

{ #category : #calling }
PhaROSServiceProxy >> messageHeader [ 
	^ PhaROSHSMessageHeader newServiceClientWith: [
		:header |
		header callerId: self callerId;
				md5Sum: self md5Sum;
				service: self serviceName
	   ].
		

]

{ #category : #calling }
PhaROSServiceProxy >> messageHeaderForBrowseType [

	^ PhaROSHSMessageHeader newServiceClientWith: [
		:header |
		header callerId: self callerId;
				md5Sum: '*';
				probe: '1';
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
