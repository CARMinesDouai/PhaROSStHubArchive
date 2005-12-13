"
This class implements the socks 4 and partially socks 5 connection protocol.
For backward compatibility the socks protocol is disabled by default, so subclasses still work.
For further documentation check out:

Socks4: http://spiderman.socks.nec.com/protocol/socks4.protocol

Socks5: http://spiderman.socks.nec.com/rfc/rfc1928.txt
"
Class {
	#name : #SocksSocket,
	#superclass : #Socket,
	#instVars : [
		'vers',
		'method',
		'socksIP',
		'socksPort',
		'dstPort',
		'dstIP',
		'dstName'
	],
	#classVars : [
		'DefaultSocksVersion'
	],
	#category : #'Network-Kernel'
}

{ #category : #accessing }
SocksSocket class >> defaultSocksHostAddress [

	^NetNameResolver addressForName: HTTPSocket httpProxyServer
]

{ #category : #accessing }
SocksSocket class >> defaultSocksPort [
	^HTTPSocket httpProxyPort
]

{ #category : #accessing }
SocksSocket class >> defaultSocksVersion [
	"nil means no socks"
	^DefaultSocksVersion
]

{ #category : #accessing }
SocksSocket class >> defaultSocksVersion: anInteger [
	"nil means no socks"
	DefaultSocksVersion _ anInteger
]

{ #category : #private }
SocksSocket >> connectCommandCode [
	^1
]

{ #category : #socks4 }
SocksSocket >> connectSocks4 [
	self
		sendSocks4ConnectionRequestUserId: '';
		waitForSocks4ConnectionReply.

]

{ #category : #socks5 }
SocksSocket >> connectSocks5 [
	self
		socks5MethodSelection;
		sendSocks5ConnectionRequest;
		socks5RequestReply

]

{ #category : #'connection open/close' }
SocksSocket >> connectTo: hostAddress port: port [
	self initializeNetwork.
	self shouldUseSocks
		ifFalse: [^super connectTo: hostAddress port: port].
	super connectTo: socksIP port: socksPort.
	self waitForConnectionUntil: Socket standardDeadline.
	dstIP _ hostAddress.
	dstPort _ port.
	vers == 4
		ifTrue: [self connectSocks4]
		ifFalse: [self connectSocks5]
	
]

{ #category : #'connection open/close' }
SocksSocket >> connectToHostNamed: hostName port: port [
	super connectTo: socksIP port: socksPort.
	self waitForConnectionUntil: Socket standardDeadline.
	dstName _ hostName.
	dstPort _ port.
	vers == 4
		ifTrue: [self connectSocks4]
		ifFalse: [self connectSocks5]
	
]

{ #category : #private }
SocksSocket >> defaultTimeOutDuration [
	^20000
]

{ #category : #private }
SocksSocket >> dstIP [
	^dstIP
]

{ #category : #private }
SocksSocket >> dstPort [
	^dstPort
]

{ #category : #socks5 }
SocksSocket >> hostIP6Code [
	^4
]

{ #category : #socks5 }
SocksSocket >> hostIPCode [
	^1
]

{ #category : #methods }
SocksSocket >> noAutorizationMethod [
	^0
]

{ #category : #socks5 }
SocksSocket >> qualifiedHostNameCode [
	^3
]

{ #category : #private }
SocksSocket >> requestGrantedCode [
	^90
]

{ #category : #socks4 }
SocksSocket >> sendSocks4ConnectionRequestUserId: userId [
	"The client connects to the SOCKS server and sends a CONNECT request when
it wants to establish a connection to an application server. The client
includes in the request packet the IP address and the port number of the
destination host, and userid, in the following format.

	+----+----+----+----+----+----+----+----+----+----+....+----+
	| VN | CD | DSTPORT |      DSTIP        | USERID       |NULL|
	+----+----+----+----+----+----+----+----+----+----+....+----+
	   1    1      2              4           variable       1
	"

	| requestString |
	requestString _ WriteStream on: ByteArray new.
	dstIP
		ifNil: [dstIP _ NetNameResolver addressForName: dstName].
	requestString
		nextPut: 4;
		nextPut: self connectCommandCode;
		nextWordPut: dstPort;
		nextPutAll: self dstIP;
		nextPutAll: userId asByteArray;
		nextPut: 0.
	self sendData: requestString contents
]

{ #category : #socks5 }
SocksSocket >> sendSocks5ConnectionRequest [
	"Once the method-dependent subnegotiation has completed, the client
   sends the request details."

	| requestString |
	requestString _ WriteStream on: ByteArray new.
	requestString
		nextPut: 5;
		nextPut: self connectCommandCode;
		nextPut: 0. "Reserved slot"
	dstName isNil
		ifTrue: [
			requestString
				nextPutAll: self hostIPCode;
				nextPutAll: dstIP]
		ifFalse: [
			requestString
				nextPut: self qualifiedHostNameCode;
				nextPut: dstName size;
				nextPutAll: dstName asByteArray].
	requestString nextWordPut: dstPort.
	self sendData: requestString contents
]

{ #category : #private }
SocksSocket >> shouldUseSocks [
	^vers notNil
]

{ #category : #socks5 }
SocksSocket >> skipQualifiedHostName [

	| startTime response bytesRead |
	startTime _ Time millisecondClockValue.
	response _ ByteArray new: 1.

	[(bytesRead _ self receiveDataInto: response) < 1
		and: [(Time millisecondClockValue - startTime) < self defaultTimeOutDuration]] whileTrue.

	bytesRead < 1
		ifTrue: [self socksError: 'Time out reading data'].

	self waitForReply: (response at: 1) + 2 for: self defaultTimeOutDuration
]

{ #category : #initialize }
SocksSocket >> socks4 [
	vers _ 4.
	method _ nil.
	socksIP _ self class defaultSocksHostAddress.
	socksPort _ self class defaultSocksPort
]

{ #category : #initialize }
SocksSocket >> socks5 [
	vers _ 5.
	method _ self class noAutorizationMethod.
	socksIP _ self class defaultSocksHostAddress.
	socksPort _ self class defaultSocksPort
]

{ #category : #socks5 }
SocksSocket >> socks5MethodSelection [
	"The client connects to the server, and sends a version
   identifier/method selection message.
	The server selects from one of the methods given in METHODS, and
   sends a METHOD selection message."

	| requestString response |
	requestString _ WriteStream on: ByteArray new.
	requestString
		nextPut: 5;
		nextPut: 1;
		nextPut: 0.
	self sendData: requestString contents.

	response _ self waitForReply: 2 for: self defaultTimeOutDuration.
	(response at: 2) == 16rFF
		ifTrue: [self socksError: 'No acceptable methods.']
		ifFalse: [method _ response at: 2]
]

{ #category : #socks5 }
SocksSocket >> socks5RequestReply [

	| response |
	response _ self waitForReply: 4 for: self defaultTimeOutDuration.
	"Skip rest for now."
	(response at: 4) = self hostIPCode
		ifTrue: [self waitForReply: 6 for: self defaultTimeOutDuration].
	(response at: 4) = self qualifiedHostNameCode
		ifTrue: [self skipQualifiedHostName].
	(response at: 4) = self hostIP6Code
		ifTrue: [self waitForReply: 18 for: self defaultTimeOutDuration].
	(response at: 2) ~= 0
		ifTrue: [^self socksError: 'Connection failed: ', (response at: 2) printString].

]

{ #category : #private }
SocksSocket >> socksError: errorString [
	self close; destroy.
	self error: errorString
]

{ #category : #private }
SocksSocket >> waitForReply: replySize for: timeOutDuration [
	| startTime response delay bytesRead |
	startTime _ Time millisecondClockValue.
	response _ ByteArray new: replySize.
	bytesRead _ 0.
	delay _ Delay forMilliseconds: 500.
	[bytesRead < replySize
		and: [(Time millisecondClockValue - startTime) < timeOutDuration]] whileTrue: [
		bytesRead _ bytesRead + (self receiveDataInto: response).
		delay wait.
		Transcript show: '.'].
	bytesRead < replySize
		ifTrue: [self close; destroy.
				^ (ConnectionRefused host: self dstIP port: self dstPort) signal].
	^response
]

{ #category : #socks4 }
SocksSocket >> waitForSocks4ConnectionReply [

	| response |
	response _ self waitForReply: 8 for: self defaultTimeOutDuration.

	(response at: 2) = self requestGrantedCode
		ifFalse: [^self socksError: 'Connection failed: ' , (response at: 2) printString].
]
