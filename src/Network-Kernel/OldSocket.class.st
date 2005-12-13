"
A Socket represents a network connection point. Current sockets are designed to support the TCP/IP and UDP protocols

Subclasses of socket provide support for network protocols such as POP, NNTP, HTTP, and FTP. Sockets also allow you to implement your own custom services and may be used to support Remote Procedure Call or Remote Method Invocation some day.

JMM June 2nd 2000 Macintosh UDP support was added if you run open transport.

"
Class {
	#name : #OldSocket,
	#superclass : #Object,
	#instVars : [
		'semaphore',
		'socketHandle',
		'readSemaphore',
		'writeSemaphore',
		'primitiveOnlySupportsOneSemaphore'
	],
	#classVars : [
		'InvalidSocket',
		'ThisEndClosed',
		'WaitingForConnection',
		'UDPSocketType',
		'Registry',
		'TCPSocketType',
		'OtherEndClosed',
		'Connected',
		'Unconnected',
		'RegistryThreshold',
		'DeadServer'
	],
	#category : #'Network-Kernel'
}

{ #category : #'instance creation' }
OldSocket class >> acceptFrom: aSocket [
	^[ super new acceptFrom: aSocket ]
		repeatWithGCIf: [ :sock | sock isValid not ]
]

{ #category : #examples }
OldSocket class >> clientServerTestUDP [
	"Socket clientServerTestUDP"

	"Performa 6400/200, Linux-PPC 2.1.24:
		client/server UDP test done; time = 2820
		2500 packets, 10000000 bytes sent (3546 kBytes/sec)
		2500 packets, 10000000 bytes received (3546 kBytes/sec)
		4000 bytes/packet, 886 packets/sec, 0 packets dropped"

	| sock1 sock2 bytesToSend sendBuf receiveBuf done bytesSent bytesReceived packetsSent packetsReceived t |
	Transcript show: 'starting client/server UDP test'; cr.
	Transcript show: 'initializing network ... '.
	Socket initializeNetworkIfFail: [^Transcript show:'failed'].
	Transcript show:'ok';cr.
	Transcript show: 'creating endpoints'; cr.
	sock1 _ Socket newUDP.	"the sender"
	sock2 _ Socket newUDP.	"the recipient"
	sock2 setPort: 54321.
	sock1 setPeer: (NetNameResolver localHostAddress) port: (sock2 port).
	Transcript show: 'endpoints created'; cr.

	bytesToSend _ 10000000.
	sendBuf _ String new: 4000 withAll: $x.
	receiveBuf _ String new: 50000.
	done _ false.
	bytesSent _ bytesReceived _ packetsSent _ packetsReceived _ 0.
	t _ Time millisecondsToRun: [
		[done] whileFalse: [
			(sock1 sendDone and: [bytesSent < bytesToSend]) ifTrue: [
				packetsSent _ packetsSent + 1.
				bytesSent _ bytesSent + (sock1 sendData: sendBuf)].
			sock2 dataAvailable ifTrue: [
				packetsReceived _ packetsReceived + 1.
				bytesReceived _ bytesReceived +
					(sock2 receiveDataInto: receiveBuf)].
			done _ (bytesSent >= bytesToSend)].
		sock1 waitForSendDoneUntil: self standardDeadline.
		bytesReceived _ bytesReceived + sock2 discardReceivedData].

	Transcript show: 'closing endpoints'; cr.
	sock1 close.
	sock2 close.
	sock1 destroy.
	sock2 destroy.
	Transcript show: 'client/server UDP test done; time = ', t printString; cr.
	Transcript show: packetsSent printString, ' packets, ',
						bytesSent printString, ' bytes sent (',
						(bytesSent * 1000 // t) printString, ' Bytes/sec)'; cr.
	Transcript show: packetsReceived printString, ' packets, ',
						bytesReceived printString, ' bytes received (',
						(bytesReceived * 1000 // t) printString, ' Bytes/sec)'; cr.
	Transcript show: (bytesSent // packetsSent) printString, ' bytes/packet, ',
						(packetsReceived * 1000 // t) printString, ' packets/sec, ',
						(packetsSent - packetsReceived) printString, ' packets dropped'; cr.
]

{ #category : #examples }
OldSocket class >> clientServerTestUDP2 [
	"Socket clientServerTestUDP2"

	| sock1 sock2 bytesToSend sendBuf receiveBuf done bytesSent bytesReceived packetsSent packetsReceived t datagramInfo |
	Transcript show: 'starting client/server UDP test'; cr.
	Transcript show: 'initializing network ... '.
	Socket initializeNetworkIfFail: [^Transcript show:'failed'].
	Transcript show:'ok';cr.
	Transcript show: 'creating endpoints'; cr.
	sock1 _ Socket newUDP.	"the sender"
	sock2 _ Socket newUDP.	"the recipient"
	sock2 setPort: 54321.
	Transcript show: 'endpoints created'; cr.

	bytesToSend _ 100000000.
	sendBuf _ String new: 4000 withAll: $x.
	receiveBuf _ String new: 2000.
	done _ false.
	bytesSent _ bytesReceived _ packetsSent _ packetsReceived _ 0.
	t _ Time millisecondsToRun: [
		[done] whileFalse: [
			(sock1 sendDone and: [bytesSent < bytesToSend]) ifTrue: [
				packetsSent _ packetsSent + 1.
				bytesSent _ bytesSent + (sock1 sendData: sendBuf toHost: (NetNameResolver localHostAddress) port: (sock2 port))].	
			sock2 dataAvailable ifTrue: [
				packetsReceived _ packetsReceived + 1.
				datagramInfo _ sock2 receiveUDPDataInto: receiveBuf.
				bytesReceived _ bytesReceived + (datagramInfo at: 1)].
			done _ (bytesSent >= bytesToSend)].
		sock1 waitForSendDoneUntil: self standardDeadline.
		bytesReceived _ bytesReceived + sock2 discardReceivedData].

	Transcript show: 'closing endpoints'; cr.
	sock1 close.
	sock2 close.
	sock1 destroy.
	sock2 destroy.
	Transcript show: 'client/server UDP test done; time = ', t printString; cr.
	Transcript show: packetsSent printString, ' packets, ',
						bytesSent printString, ' bytes sent (',
						(bytesSent * 1000 // t) printString, ' Bytes/sec)'; cr.
	Transcript show: packetsReceived printString, ' packets, ',
						bytesReceived printString, ' bytes received (',
						(bytesReceived * 1000 // t) printString, ' Bytes/sec)'; cr.
	Transcript show: (bytesSent // packetsSent) printString, ' bytes/packet, ',
						(packetsReceived * 1000 // t) printString, ' packets/sec, ',
						(packetsSent - packetsReceived) printString, ' packets dropped'; cr.
]

{ #category : #'instance creation' }
OldSocket class >> createIfFail: failBlock [
	"Attempt to create a new socket. If successful, return the new socket. Otherwise, return the result of evaluating the given block. Socket creation can fail if the network isn't available or if there are not sufficient resources available to create another socket."
	"Note: The default creates a TCP socket"
	^self tcpCreateIfFail: failBlock
]

{ #category : #utilities }
OldSocket class >> deadServer [

	^ DeadServer
]

{ #category : #utilities }
OldSocket class >> deadServer: aStringOrNil [
	"Keep the machine name of the most recently encoutered non-responding machine.  Next time the user can move it to the last in a list of servers to try."

	DeadServer _ aStringOrNil
]

{ #category : #utilities }
OldSocket class >> deadlineSecs: secs [
	"Return a deadline time the given number of seconds from now."

	^ Time millisecondClockValue + (secs * 1000)

]

{ #category : #'network initialization' }
OldSocket class >> ensureNetworkConnected [
	"Try to ensure that an intermittent network connection, such as a dialup or ISDN line, is actually connected. This is necessary to make sure a server is visible in order to accept an incoming connection."
	"Socket ensureNetworkConnected"

	Socket initializeNetwork.
	Utilities
		informUser: 'Contacting domain name server...'
		during: [
			NetNameResolver
				addressForName: 'bogusNameToForceDNSToBeConsulted.org'
				timeout: 30].

]

{ #category : #'class initialization' }
OldSocket class >> initialize [
	"Socket initialize"

	"Socket Types"
	TCPSocketType _ 0.
	UDPSocketType _ 1.

	"Socket Status Values"
	InvalidSocket _ -1.
	Unconnected _ 0.
	WaitingForConnection _ 1.
	Connected _ 2.
	OtherEndClosed _ 3.
	ThisEndClosed _ 4.

	RegistryThreshold _ 100. "# of sockets"
]

{ #category : #'network initialization' }
OldSocket class >> initializeNetwork [
	"Initialize the network drivers and the NetNameResolver. Do nothing if the network is already initialized."
	"Note: The network must be re-initialized every time Squeak starts up, so applications that persist across snapshots should be prepared to re-initialize the network as needed. Such applications should call 'Socket initializeNetwork' before every network transaction. "

	NetNameResolver initializeNetwork
]

{ #category : #'network initialization' }
OldSocket class >> initializeNetworkIfFail: failBlock [
	"Initialize the network drivers. Do nothing if the network is already initialized. Evaluate the given block if network initialization fails, perhaps because this computer isn't currently connected to a network."

	NetNameResolver initializeNetwork
]

{ #category : #tests }
OldSocket class >> loopbackTest [
	"Send data from one socket to another on the local machine. Tests most of the socket primitives."
	"100 timesRepeat: [Socket loopbackTest]"

	| sock1 sock2 bytesToSend sendBuf receiveBuf done bytesSent bytesReceived t extraBytes packetsSent packetsRead |
	Transcript cr; show: 'starting loopback test'; cr.

	Transcript show: '---------- Connecting ----------'; cr.
	Socket initializeNetwork.
	sock1 _ Socket new.
	sock2 _ Socket new.
	sock1 listenOn: 54321.
	sock2 connectTo: (NetNameResolver localHostAddress) port: 54321.
	sock1 waitForConnectionUntil: self standardDeadline.
	sock2 waitForConnectionUntil: self standardDeadline.
	(sock1 isConnected) ifFalse: [self error: 'sock1 not connected'].
	(sock2 isConnected) ifFalse: [self error: 'sock2 not connected'].
	Transcript show: 'connection established'; cr.

	bytesToSend _ 5000000.
	sendBuf _ String new: 5000 withAll: $x.
	receiveBuf _ String new: 50000.
	done _ false.
	packetsSent _ packetsRead _ bytesSent _ bytesReceived _ 0.
	t _ Time millisecondsToRun: [
		[done] whileFalse: [
			(sock1 sendDone and: [bytesSent < bytesToSend]) ifTrue: [
				packetsSent _ packetsSent + 1.
				bytesSent _ bytesSent + (sock1 sendSomeData: sendBuf)].
			sock2 dataAvailable ifTrue: [
				packetsRead _ packetsRead + 1.
				bytesReceived _ bytesReceived +
					(sock2 receiveDataInto: receiveBuf)].
			done _ (bytesSent >= bytesToSend) and: [bytesReceived = bytesSent]]].
	
	Transcript show: 'closing connection'; cr.
	sock1 waitForSendDoneUntil: self standardDeadline.
	sock1 close.
	sock2 waitForDisconnectionUntil: self standardDeadline.
	extraBytes _ sock2 discardReceivedData.
	extraBytes > 0 ifTrue: [
		Transcript show: ' *** received ', extraBytes size printString, ' extra bytes ***'; cr.
	].
	sock2 close.
	sock1 waitForDisconnectionUntil: self standardDeadline.
	(sock1 isUnconnectedOrInvalid) ifFalse: [self error: 'sock1 not closed'].
	(sock2 isUnconnectedOrInvalid) ifFalse: [self error: 'sock2 not closed'].
	Transcript show: '---------- Connection Closed ----------'; cr.

	sock1 destroy.
	sock2 destroy.
	Transcript show: 'loopback test done; time = ', t printString; cr.
	Transcript show: ((bytesToSend asFloat / t) roundTo: 0.01) printString, ' 1000Bytes/sec'; cr.
	Transcript endEntry.

]

{ #category : #utilities }
OldSocket class >> nameForWellKnownTCPPort: portNum [
	"Answer the name for the given well-known TCP port number. Answer a string containing the port number if it isn't well-known."

	| portList entry |
	portList _ #(
		(7 'echo') (9 'discard') (13 'time') (19 'characterGenerator')
		(21 'ftp') (23 'telnet') (25 'smtp')
		(80 'http') (110 'pop3') (119 'nntp')).
	entry _ portList detect: [:pair | pair first = portNum] ifNone: [^ 'port-', portNum printString].
	^ entry last

]

{ #category : #'instance creation' }
OldSocket class >> new [
	"Return a new, unconnected Socket. Note that since socket creation may fail, it is safer to use the method createIfFail: to handle such failures gracefully; this method is primarily for backward compatibility and may be disallowed in a future release."
	"Note: The default creates a TCP socket - this is also backward compatibility."
	^self newTCP
]

{ #category : #tests }
OldSocket class >> newAcceptCheck [
"
Socket newAcceptCheck
"
	| socket |

	self initializeNetwork.
	socket _ self newTCP.
	socket listenOn: 44444 backlogSize: 4.
	socket isValid ifTrue: [
		self inform: 'Everything looks OK for the BSD style accept()'
	] ifFalse: [
		self inform: 'It appears that you DO NOT have support for the BSD style accept()'
	].
	socket destroy.

]

{ #category : #'instance creation' }
OldSocket class >> newTCP [
	"Create a socket and initialise it for TCP"
	^[ super new initialize: TCPSocketType ]
		repeatWithGCIf: [ :socket | socket isValid not ]
]

{ #category : #'instance creation' }
OldSocket class >> newUDP [
	"Create a socket and initialise it for UDP"
	^[ super new initialize: UDPSocketType ]
		repeatWithGCIf: [ :socket | socket isValid not ]
]

{ #category : #utilities }
OldSocket class >> ping: hostName [
	"Ping the given host. Useful for checking network connectivity. The host must be running a TCP echo server."
	"Socket ping: 'squeak.cs.uiuc.edu'"

	| tcpPort sock serverAddr startTime echoTime |
	tcpPort _ 7.  "7 = echo port, 13 = time port, 19 = character generator port"
	Socket initializeNetwork.
	serverAddr _ NetNameResolver addressForName: hostName timeout: 10.
	serverAddr = nil ifTrue: [
		^ self inform: 'Could not find an address for ', hostName].

	sock _ Socket new.
	sock connectTo: serverAddr port: tcpPort.
	[sock waitForConnectionUntil: (Socket deadlineSecs: 10).
	 sock isConnected] whileFalse: [
		(self confirm: 'Continue to wait for connection to ', hostName, '?') ifFalse: [
			sock destroy.
			^ self]].

	sock sendData: 'echo!'.
	startTime _ Time millisecondClockValue.
	[sock waitForDataUntil: (Socket deadlineSecs: 15).
	 sock dataAvailable] whileFalse: [
		(self confirm: 'Packet sent but no echo yet; keep waiting?') ifFalse: [
			sock destroy.
			^ self]].
	echoTime _ Time millisecondClockValue - startTime.

	sock destroy.
	self inform: hostName, ' responded in ', echoTime printString, ' milliseconds'.

]

{ #category : #utilities }
OldSocket class >> pingPorts: portList on: hostName timeOutSecs: timeOutSecs [
	"Attempt to connect to each of the given sockets on the given host. Wait at most timeOutSecs for the connections to be established. Answer an array of strings indicating the available ports."
	"Socket pingPorts: #(7 13 19 21 23 25 80 110 119) on: 'squeak.cs.uiuc.edu' timeOutSecs: 15"

	| serverAddr sockets sock deadline done unconnectedCount connectedCount waitingCount result |
	Socket initializeNetwork.
	serverAddr _ NetNameResolver addressForName: hostName timeout: 10.
	serverAddr = nil ifTrue: [
		self inform: 'Could not find an address for ', hostName.
		^ #()].

	sockets _ portList collect: [:portNum |
		sock _ Socket new.
		sock connectTo: serverAddr port: portNum].

	deadline _ self deadlineSecs: timeOutSecs.
	done _ false.
	[done] whileFalse: [
		unconnectedCount _ 0.
		connectedCount _ 0.
		waitingCount _ 0.
		sockets do: [:s |
			s isUnconnectedOrInvalid
				ifTrue: [unconnectedCount _ unconnectedCount + 1]
				ifFalse: [
					s isConnected ifTrue: [connectedCount _ connectedCount + 1].
					s isWaitingForConnection ifTrue: [waitingCount _ waitingCount + 1]]].
		waitingCount = 0 ifTrue: [done _ true].
		connectedCount = sockets size ifTrue: [done _ true].
		Time millisecondClockValue > deadline ifTrue: [done _ true]].

	result _ (sockets select: [:s | s isConnected])
		collect: [:s | self nameForWellKnownTCPPort: s remotePort].
	sockets do: [:s | s destroy].
	^ result

]

{ #category : #utilities }
OldSocket class >> pingPortsOn: hostName [
	"Attempt to connect to a set of well-known sockets on the given host, and answer the names of the available ports."
	"Socket pingPortsOn: 'www.disney.com'"

	^ Socket
		pingPorts: #(7 13 19 21 23 25 80 110 119)
		on: hostName
		timeOutSecs: 20

]

{ #category : #registry }
OldSocket class >> register: anObject [
	WeakArray isFinalizationSupported ifFalse:[^anObject].
	self registry add: anObject
]

{ #category : #registry }
OldSocket class >> registry [
	WeakArray isFinalizationSupported ifFalse:[^nil].
	^Registry isNil
		ifTrue:[Registry := WeakRegistry new]
		ifFalse:[Registry].
]

{ #category : #registry }
OldSocket class >> registryThreshold [
	"Return the registry threshold above which socket creation may fail due to too many already open sockets. If the threshold is reached, a full GC will be issued if the creation of a socket fails."
	^RegistryThreshold
]

{ #category : #registry }
OldSocket class >> registryThreshold: aNumber [
	"Return the registry threshold above which socket creation may fail due to too many already open sockets. If the threshold is reached, a full GC will be issued if the creation of a socket fails."
	RegistryThreshold _ aNumber
]

{ #category : #examples }
OldSocket class >> remoteTestClientTCP [
	"FIRST start up another image, and execute: Socket remoteTestServerTCP.
	THEN come back to this image and execute:"
			"Socket remoteTestClientTCP"

	"Performa 6400/200, Linux-PPC 2.1.24, both images on same CPU:
		remoteClient TCP test done; time = 5680
		250 packets, 1000000 bytes sent (176 kBytes/sec)
		60 packets, 1000000 bytes received (176 kBytes/sec)"

	| socket bytesToSend sendBuf receiveBuf done bytesSent bytesReceived packetsSent packetsReceived t serverName |
	Transcript show: 'starting client/server TCP test'; cr.
	Transcript show: 'initializing network ... '.
	Socket initializeNetworkIfFail: [^Transcript show:'failed'].
	Transcript show:'ok';cr.
	socket _ Socket newTCP.
	serverName _ FillInTheBlank
		request: 'What is your remote Test Server?'
		initialAnswer: ''.
	socket connectTo: (NetNameResolver addressFromString: serverName) port: 54321.
	socket waitForConnectionUntil: Socket standardDeadline.
	Transcript show: 'client endpoint created'; cr.
	bytesToSend _ 1000000.
	sendBuf _ String new: 4000 withAll: $x.
	receiveBuf _ String new: 50000.
	done _ false.
	bytesSent _ bytesReceived _ packetsSent _ packetsReceived _ 0.
	t _ Time millisecondsToRun: [
		[done] whileFalse:
			[(socket sendDone and: [bytesSent < bytesToSend]) ifTrue:
				[packetsSent _ packetsSent + 1.
				bytesSent _ bytesSent + (socket sendData: sendBuf)].
			socket dataAvailable ifTrue:
				[packetsReceived _ packetsReceived + 1.
				bytesReceived _ bytesReceived + (socket receiveDataInto: receiveBuf)].
			done _ (bytesSent >= bytesToSend)].
		[bytesReceived < bytesToSend] whileTrue:
			[socket dataAvailable ifTrue:
				[packetsReceived _ packetsReceived + 1.
				bytesReceived _ bytesReceived + (socket receiveDataInto: receiveBuf)]]].
	socket closeAndDestroy.
	Transcript show: 'remoteClient TCP test done; time = ', t printString; cr.
	Transcript show: packetsSent printString, ' packets, ',
						bytesSent printString, ' bytes sent (',
						(bytesSent * 1000 // t) printString, ' bytes/sec)'; cr.
	Transcript show: packetsReceived printString, ' packets, ',
						bytesReceived printString, ' bytes received (',
						(bytesReceived * 1000 // t) printString, ' bytes/sec)'; cr.
]

{ #category : #examples }
OldSocket class >> remoteTestClientTCPOpenClose1000 [
	"Socket remoteTestClientTCPOpenClose1000"
	| number t1 socket serverName |
	Transcript show: 'starting client/server TCP test'; cr.
	Transcript show: 'initializing network ... '.
	Socket initializeNetworkIfFail: [^Transcript show:'failed'].
	Transcript show:'ok';cr.
	number _ 1000.
	serverName _ FillInTheBlank
		request: 'What is your remote Test Server?'
		initialAnswer: ''.
	t1 _ Time millisecondsToRun: 
		[number timesRepeat: 
		[socket _ Socket newTCP.
		socket connectTo: (NetNameResolver addressFromString: serverName) port: 54321.
		socket waitForConnectionUntil: Socket standardDeadline.
		socket closeAndDestroy]].
	Transcript cr;show: 'connects/close per second ', ((number/t1*1000.0) printString); cr.


]

{ #category : #examples }
OldSocket class >> remoteTestClientTCPOpenClosePutGet [
	"Socket remoteTestClientTCPOpenClosePutGet"

	| checkLength number bytesExpected sendBuf receiveBuf t1 socket bytesReceived serverName | 

	Transcript show: 'starting client/server TCP test'; cr.
	Transcript show: 'initializing network ... '.
	Socket initializeNetworkIfFail: [^Transcript show:'failed'].
	Transcript show:'ok';cr.
	serverName _ FillInTheBlank
		request: 'What is your remote Test Server?'
		initialAnswer: ''.
	number _ 1000.	
	bytesExpected _ 20000.
	sendBuf _ String new: 80 withAll: $x.
	receiveBuf _ String new: 50000.
	t1 _ Time millisecondsToRun: 
		[number timesRepeat: 
		[socket _ Socket newTCP.
		socket connectTo: (NetNameResolver addressFromString: serverName) port: 54321.
		socket waitForConnectionUntil: Socket standardDeadline.
		socket sendData: sendBuf.
		socket waitForSendDoneUntil: (Socket deadlineSecs: 5).
		socket waitForDataUntil: (Socket deadlineSecs: 5).
		bytesReceived _ 0.
		[bytesReceived < bytesExpected] whileTrue:
			[checkLength _ socket receiveDataInto: receiveBuf.
			bytesReceived _ bytesReceived + checkLength].
		socket closeAndDestroy]].
	Transcript cr;show: 'connects/get/put/close per second ', ((number/t1*1000.0) printString); cr.


]

{ #category : #examples }
OldSocket class >> remoteTestClientUDP [
	"FIRST start up another image, and execute: Socket remoteTestServerUDP.
	THEN come back to this image and execute:"
			"Socket remoteTestClientUDP"

	"Performa 6400/200, Linux-PPC 2.1.24:
		remoteClient UDP test done; time = 4580
		2500 packets, 10000000 bytes sent (2183 kBytes/sec)
		180 packets, 720000 bytes received (157 kBytes/sec)
		4000 bytes/packet, 39 packets/sec, 2320 packets dropped"

	| socket bytesToSend sendBuf receiveBuf done bytesSent bytesReceived packetsSent packetsReceived t serverName |
	Transcript show: 'starting client/server UDP test'; cr.
	Transcript show: 'initializing network ... '.
	Socket initializeNetworkIfFail: [^Transcript show:'failed'].
	Transcript show:'ok';cr.
	serverName _ FillInTheBlank
		request: 'What is your remote Test Server?'
		initialAnswer: ''.
	socket _ Socket newUDP.
	socket setPeer: (NetNameResolver addressFromString: serverName) port: 54321.
	Transcript show: 'client endpoint created'; cr.
	bytesToSend _ 10000000.
	sendBuf _ String new: 4000 withAll: $x.
	receiveBuf _ String new: 4000.
	done _ false.
	bytesSent _ bytesReceived _ packetsSent _ packetsReceived _ 0.
	t _ Time millisecondsToRun: [
		[done] whileFalse:
			[(socket sendDone and: [bytesSent < bytesToSend]) ifTrue:
				[packetsSent _ packetsSent + 1.
				bytesSent _ bytesSent + (socket sendData: sendBuf)].
			socket dataAvailable ifTrue:
				[packetsReceived _ packetsReceived + 1.
				bytesReceived _ bytesReceived + (socket receiveDataInto: receiveBuf)].
			done _ (bytesSent >= bytesToSend)].
	[socket waitForDataUntil: (Socket deadlineSecs: 1).
	socket dataAvailable] whileTrue:
		[packetsReceived _ packetsReceived + 1.
		bytesReceived _ bytesReceived + (socket receiveDataInto: receiveBuf)]].
	socket closeAndDestroy.
	Transcript show: 'remoteClient UDP test done; time = ', t printString; cr.
	Transcript show: packetsSent printString, ' packets, ',
						bytesSent printString, ' bytes sent (',
						(bytesSent * 1000 // t) printString, ' bytes/sec)'; cr.
	Transcript show: packetsReceived printString, ' packets, ',
						bytesReceived printString, ' bytes received (',
						(bytesReceived * 1000 // t) printString, ' bytes/sec)'; cr.
	Transcript show: (bytesSent // packetsSent) printString, ' bytes/packet, ',
						(packetsReceived * 1000 // t) printString, ' packets/sec, ',
						(packetsSent - packetsReceived) printString, ' packets dropped'; cr.
]

{ #category : #examples }
OldSocket class >> remoteTestServerTCP [
	"See remoteTestClientTCP for instructions on running this method."
	"OldSocket remoteTestServerTCP"

	| socket client buffer n |
	Transcript show: 'initializing network ... '.
	Socket initializeNetwork.
	Transcript show:'ok';cr.
	socket _ OldSocket newTCP.
	socket
		listenOn: 54321
		backlogSize: 5
		interface: (NetNameResolver addressFromString: '127.0.0.1'). "or: 0.0.0.0"
	Transcript show: 'server endpoint created -- run client test in other image'; cr.
	buffer _ String new: 4000.
	socket waitForConnectionUntil: self standardDeadline.
	client _ socket accept.
	[client isConnected] whileTrue: [
		client dataAvailable ifTrue:
			[n _ client	receiveDataInto: buffer.
			client sendData: buffer count: n]].
	client closeAndDestroy.
	socket closeAndDestroy.
	Transcript cr; show: 'server endpoint destroyed'; cr.
	^socket
]

{ #category : #examples }
OldSocket class >> remoteTestServerTCPOpenClose1000 [
	"The version of #remoteTestServerTCPOpenClose1000 using the BSD style accept() mechanism."
	"Socket remoteTestServerTCPOpenClose1000"

	| socket server |
	Transcript show: 'initializing network ... '.
	Socket initializeNetworkIfFail: [^Transcript show:'failed'].
	Transcript show:'ok';cr.
	server _ Socket newTCP.
	server listenOn: 54321 backlogSize: 20.
	server isValid ifFalse:[self error:'Accept() is not supported'].
	Transcript show: 'server endpoint created -- run client test in other image'; cr.
	1000 timesRepeat: 
		[socket _ server waitForAcceptUntil: (Socket deadlineSecs: 300).
		socket closeAndDestroy].
	server closeAndDestroy.
	Transcript cr; show: 'server endpoint destroyed'; cr.

]

{ #category : #examples }
OldSocket class >> remoteTestServerTCPOpenClosePutGet [	
	"The version of #remoteTestServerTCPOpenClosePutGet using the BSD style accept() mechanism."
	"Socket remoteTestServerTCPOpenClosePutGet"

	| socket server bytesIWantToSend bytesExpected receiveBuf sendBuf checkLength |
	Transcript show: 'initializing network ... '.
	Socket initializeNetworkIfFail: [^Transcript show:'failed'].
	Transcript show:'ok';cr.
	server _ Socket newTCP.
	server listenOn: 54321 backlogSize: 20.
	server isValid ifFalse:[self error:'Accept() is not supported'].
	Transcript show: 'server endpoint created -- run client test in other image'; cr.
	bytesIWantToSend _ 20000.
	bytesExpected _ 80.
	receiveBuf _ String new: 40000.
	sendBuf _ String new: bytesIWantToSend withAll: $x.
	1000 timesRepeat: 
		[socket _ server waitForAcceptUntil: (Socket deadlineSecs: 300).
		socket waitForDataUntil: (Socket deadlineSecs: 5).
		checkLength _ socket receiveDataInto: receiveBuf.
		(checkLength ~= bytesExpected) ifTrue: [self halt].
		socket sendData: sendBuf.
		socket waitForSendDoneUntil: (Socket deadlineSecs: 5).		
		socket closeAndDestroy].
	server closeAndDestroy.
	Transcript cr; show: 'server endpoint destroyed'; cr.

]

{ #category : #examples }
OldSocket class >> remoteTestServerTCPUsingAccept [
	"The version of #remoteTestServer using the BSD style accept() mechanism."
	"Socket remoteTestServerTCPUsingAccept"

	| socket buffer n server |
	Transcript show: 'initializing network ... '.
	Socket initializeNetworkIfFail: [^Transcript show:'failed'].
	Transcript show:'ok';cr.
	server _ Socket newTCP.
	server listenOn: 54321 backlogSize: 4.
	server isValid ifFalse:[self error:'Accept() is not supported'].
	Transcript show: 'server endpoint created -- run client test in other image'; cr.
	buffer _ String new: 40000.
	10 timesRepeat: 
		[socket _ server waitForAcceptUntil: (self deadlineSecs: 300).
		[socket isConnected] whileTrue: [ 
			socket dataAvailable ifTrue:
				[n _ socket	receiveDataInto: buffer.
				socket sendData: buffer count: n]]].
	socket closeAndDestroy.
	server closeAndDestroy.
	Transcript cr; show: 'server endpoint destroyed'; cr.
]

{ #category : #examples }
OldSocket class >> remoteTestServerUDP [
	"See remoteTestClientUDP for instructions on running this method."
	"Socket remoteTestServerUDP"

	| socket buffer n |
	Transcript show: 'initializing network ... '.
	Socket initializeNetworkIfFail: [^Transcript show:'failed'].
	Transcript show:'ok';cr.
	socket _ Socket newUDP.
	socket setPort: 54321.
	Transcript show: 'server endpoint created -- run client test in other image'; cr.
	buffer _ String new: 4000.
	[true] whileTrue: [
		socket dataAvailable ifTrue:
			[n _ socket	receiveDataInto: buffer.
				socket sendData: buffer count: n]].

]

{ #category : #examples }
OldSocket class >> remoteTestServerUDP2 [
	"See remoteTestClientUDP for instructions on running this method."
	"Socket remoteTestServerUDP2"

	| socket buffer datagramInfo |
	Transcript show: 'initializing network ... '.
	Socket initializeNetworkIfFail: [^Transcript show:'failed'].
	Transcript show:'ok';cr.
	socket _ Socket newUDP.
	socket setPort: 54321.
	Transcript show: 'server endpoint created -- run client test in other image'; cr.
	buffer _ String new: 65000.
	[true] whileTrue: [
		socket dataAvailable ifTrue:
			[datagramInfo _ socket receiveUDPDataInto: buffer. 
			Transcript show: datagramInfo printString;cr.
				socket sendData: buffer count: (datagramInfo at: 1)]].

]

{ #category : #examples }
OldSocket class >> remoteTestSinkTCP [
	"See sendTest for instructions on running this method."
	"Socket remoteTestSinkTCP"

	| socket buffer n |
	Transcript show: 'initializing network ... '.
	Socket initializeNetworkIfFail: [^Transcript show:'failed'].
	Transcript show:'ok';cr.
	socket _ Socket newTCP.
	socket listenOn: 9.
	Transcript show: 'server endpoint created -- run client test in other image'; cr.
	buffer _ String new: 64000.
	socket waitForConnectionUntil: self standardDeadline.
	[socket isConnected] whileTrue: [
		socket dataAvailable ifTrue:
			[n _ socket	receiveDataInto: buffer]].
	socket closeAndDestroy.
	Transcript cr; show: 'sink endpoint destroyed'; cr.
]

{ #category : #tests }
OldSocket class >> sendTest [
	"Send data to the 'discard' socket of the given host. Tests the speed of one-way data transfers across the network to the given host. Note that many host hosts do not run a discard server."
	"Socket sendTest"

	| sock bytesToSend sendBuf bytesSent t serverName serverAddr |
	Transcript cr; show: 'starting send test'; cr.
	Socket initializeNetwork.
	serverName _ FillInTheBlank
		request: 'What is the destination server?'
		initialAnswer: 'create.ucsb.edu'.
	serverAddr _ NetNameResolver addressForName: serverName timeout: 10.
	serverAddr = nil ifTrue: [^ self inform: 'Could not find an address for ', serverName].

	sock _ Socket new.
	Transcript show: '---------- Connecting ----------'; cr.
	sock connectTo: serverAddr port: 9.
	sock waitForConnectionUntil: self standardDeadline.
	(sock isConnected) ifFalse: [
		sock destroy.
		^ self inform: 'could not connect'].
	Transcript show: 'connection established; sending data'; cr.

	bytesToSend _ 1000000.
	sendBuf _ String new: 64*1024 withAll: $x.
	bytesSent _ 0.
	t _ Time millisecondsToRun: [
		[bytesSent < bytesToSend] whileTrue: [
			sock sendDone ifTrue: [
				bytesSent _ bytesSent + (sock sendSomeData: sendBuf)]]].
	sock waitForSendDoneUntil: self standardDeadline.
	sock destroy.
	Transcript show: '---------- Connection Closed ----------'; cr.
	Transcript show: 'send test done; time = ', t printString; cr.
	Transcript show: ((bytesToSend asFloat / t) roundTo: 0.01) printString, ' 1000Bytes/sec'; cr.
	Transcript endEntry.

]

{ #category : #utilities }
OldSocket class >> standardDeadline [
	"Return a default deadline time some seconds into the future."

	^ self deadlineSecs: 45

]

{ #category : #'instance creation' }
OldSocket class >> tcpCreateIfFail: failBlock [
	"Attempt to create a new socket. If successful, return the new socket. Otherwise, return the result of evaluating the given block. Socket creation can fail if the network isn't available or if there are not sufficient resources available to create another socket."

	| sock |
	sock _ super new initialize: TCPSocketType.
	sock isValid ifFalse: [^ failBlock value].
	^ sock

]

{ #category : #examples }
OldSocket class >> timeTest [
	"Socket timeTest"

	| serverName serverAddr s |
	Transcript show: 'initializing network ... '.
	Socket initializeNetworkIfFail: [^Transcript show:'failed'].
	Transcript show:'ok';cr.
	serverName _ FillInTheBlank
		request: 'What is your time server?'
		initialAnswer: 'localhost'.
	serverName isEmpty ifTrue: [^ Transcript show: 'never mind'; cr].
	serverAddr _ NetNameResolver addressForName: serverName timeout: 10.
	serverAddr = nil ifTrue: [self error: 'Could not find the address for ', serverName].

	s _ Socket new.
	Transcript show: '---------- Connecting ----------'; cr.
	s connectTo: serverAddr port: 13.  "13 is the 'daytime' port number"
	s waitForConnectionUntil: (self deadlineSecs: 1).
	Transcript show: 'the time server reports: ' , s getResponseNoLF.
	s closeAndDestroy.
	Transcript show: '---------- Connection Closed ----------'; cr.

]

{ #category : #examples }
OldSocket class >> timeTestUDP [
	"Socket timeTestUDP"

	| serverName serverAddr s |
	Transcript show: 'initializing network ... '.
	Socket initializeNetworkIfFail: [^Transcript show:'failed'].
	Transcript show:'ok';cr.
	serverName _ FillInTheBlank
		request: 'What is your time server?'
		initialAnswer: 'localhost'.
	serverName isEmpty ifTrue: [^ Transcript show: 'never mind'; cr].
	serverAddr _ NetNameResolver addressForName: serverName timeout: 10.
	serverAddr = nil ifTrue: [self error: 'Could not find the address for ', serverName].

	s _ Socket newUDP.		"a 'random' port number will be allocated by the system"
	"Send a packet to the daytime port and it will reply with the current date."
	Transcript show: '---------- Sending datagram from port ' , s port printString , ' ----------'; cr.
	s sendData: '!' toHost: serverAddr port: 13.	"13 is the daytime service"
	Transcript show: 'the time server reports: ' , s getResponseNoLF.
	s closeAndDestroy.
	Transcript show: '---------- Socket closed ----------'; cr.

]

{ #category : #examples }
OldSocket class >> timeTestUDP2 [
	"Socket timeTestUDP2"

	| serverName serverAddr s |
	Transcript show: 'initializing network ... '.
	Socket initializeNetworkIfFail: [^Transcript show:'failed'].
	Transcript show:'ok';cr.
	serverName _ FillInTheBlank
		request: 'What is your time server?'
		initialAnswer: 'localhost'.
	serverName isEmpty ifTrue: [^ Transcript show: 'never mind'; cr].
	serverAddr _ NetNameResolver addressForName: serverName timeout: 10.
	serverAddr = nil ifTrue: [self error: 'Could not find the address for ', serverName].

	s _ Socket newUDP.
	"The following associates a port with the UDP socket, but does NOT create a connectable endpoint"
	s setPort: 54321.
	"Send a packet to the daytime port and it will reply with the current date."
	Transcript show: '---------- Sending datagram from port ' , s port printString , ' ----------'; cr.
	s sendData: '!' toHost: serverAddr port: 13.
	Transcript show: 'the time server reports: ' , s getResponseNoLF.
	s closeAndDestroy.
	Transcript show: '---------- Socket closed ----------'; cr.

]

{ #category : #examples }
OldSocket class >> timeTestUDP3 [
	"Socket timeTestUDP3"

	| serverName serverAddr s |
	Transcript show: 'initializing network ... '.
	Socket initializeNetworkIfFail: [^Transcript show:'failed'].
	Transcript show:'ok';cr.
	serverName _ FillInTheBlank
		request: 'What is your time server?'
		initialAnswer: 'localhost'.
	serverName isEmpty ifTrue: [^ Transcript show: 'never mind'; cr].
	serverAddr _ NetNameResolver addressForName: serverName timeout: 10.
	serverAddr = nil ifTrue: [self error: 'Could not find the address for ', serverName].

	s _ Socket newUDP.
	"The following associates a port with the UDP socket, but does NOT create a connectable endpoint"
	s setPort: (Socket wildcardPort).		"explicitly request a default port number"
	"Send a packet to the daytime port and it will reply with the current date."
	Transcript show: '---------- Sending datagram from port ' , s port printString , ' ----------'; cr.
	s sendData: '!' toHost: serverAddr port: 13.
	Transcript show: 'the time server reports: ' , s getResponseNoLF.
	s closeAndDestroy.
	Transcript show: '---------- Socket closed ----------'; cr.

]

{ #category : #'instance creation' }
OldSocket class >> udpCreateIfFail: failBlock [
	"Attempt to create a new socket. If successful, return the new socket. Otherwise, return the result of evaluating the given block. Socket creation can fail if the network isn't available or if there are not sufficient resources available to create another socket."

	| sock |
	sock _ super new initialize: UDPSocketType.
	sock isValid ifFalse: [^ failBlock value].
	^ sock

]

{ #category : #registry }
OldSocket class >> unregister: anObject [
	WeakArray isFinalizationSupported ifFalse:[^anObject].
	self registry remove: anObject ifAbsent:[]
]

{ #category : #utilities }
OldSocket class >> wildcardAddress [
	"Answer a don't-care address for use with UDP sockets."

	^ByteArray new: 4		"0.0.0.0"
]

{ #category : #utilities }
OldSocket class >> wildcardPort [
	"Answer a don't-care port for use with UDP sockets.  (The system will allocate an
	unused port number to the socket.)"

	^0
]

{ #category : #'connection open/close' }
OldSocket >> accept [
	"Accept a connection from the receiver socket.
	Return a new socket that is connected to the client"
	^Socket acceptFrom: self.
]

{ #category : #'initialize-destroy' }
OldSocket >> acceptFrom: aSocket [
	"Initialize a new socket handle from an accept call"
	| semaIndex readSemaIndex writeSemaIndex |

	primitiveOnlySupportsOneSemaphore _ false.
	semaphore _ Semaphore new.
	readSemaphore _ Semaphore new.
	writeSemaphore _ Semaphore new.
	semaIndex _ Smalltalk registerExternalObject: semaphore.
	readSemaIndex _ Smalltalk registerExternalObject: readSemaphore.
	writeSemaIndex _ Smalltalk registerExternalObject: writeSemaphore.
	socketHandle _ self primAcceptFrom: aSocket socketHandle
						receiveBufferSize: 8000
						sendBufSize: 8000
						semaIndex: semaIndex
						readSemaIndex: readSemaIndex
						writeSemaIndex: writeSemaIndex.
	socketHandle = nil ifTrue: [  "socket creation failed"
		Smalltalk unregisterExternalObject: semaphore.
		Smalltalk unregisterExternalObject: readSemaphore.
		Smalltalk unregisterExternalObject: writeSemaphore.
		readSemaphore _ writeSemaphore _ semaphore _ nil
	] ifFalse:[self register].

]

{ #category : #accessing }
OldSocket >> address [
	"Shortcut"
	^self localAddress
]

{ #category : #'connection open/close' }
OldSocket >> close [
	"Close this connection gracefully. For TCP, this sends a close request, but the stream remains open until the other side also closes it."

	self primSocketCloseConnection: socketHandle.  "close this end"

]

{ #category : #'connection open/close' }
OldSocket >> closeAndDestroy [
	"First, try to close this connection gracefully. If the close attempt fails or times out, abort the connection. In either case, destroy the socket. Do nothing if the socket has already been destroyed (i.e., if its socketHandle is nil)."

	self closeAndDestroy: 20.


]

{ #category : #'connection open/close' }
OldSocket >> closeAndDestroy: timeoutSeconds [
	"First, try to close this connection gracefully. If the close attempt fails or times out, abort the connection. In either case, destroy the socket. Do nothing if the socket has already been destroyed (i.e., if its socketHandle is nil)."

	socketHandle = nil
		ifFalse: [
			self isConnected ifTrue: [
				self close.  "close this end"
				(self waitForDisconnectionUntil: (Socket deadlineSecs: timeoutSeconds))
					ifFalse: [
						"if the other end doesn't close soon, just abort the connection"
						self primSocketAbortConnection: socketHandle]].
			self destroy].

]

{ #category : #'connection open/close' }
OldSocket >> connectTo: hostAddress port: port [
	"Initiate a connection to the given port at the given host address. This operation will return immediately; follow it with waitForConnectionUntil: to wait until the connection is established."

	| status |
	status _ self primSocketConnectionStatus: socketHandle.
	(status == Unconnected)
		ifFalse: [self error: 'Socket status must Unconnected before opening a new connection'].

	self primSocket: socketHandle connectTo: hostAddress port: port.

]

{ #category : #queries }
OldSocket >> dataAvailable [
	"Return true if this socket has unread received data."

	socketHandle == nil ifTrue: [^ false].
	^ self primSocketReceiveDataAvailable: socketHandle

]

{ #category : #'initialize-destroy' }
OldSocket >> destroy [
	"Destroy this socket. Its connection, if any, is aborted and its resources are freed. Do nothing if the socket has already been destroyed (i.e., if its socketHandle is nil)."

	socketHandle = nil ifFalse: 
		[self isValid ifTrue: [self primSocketDestroy: socketHandle].
		Smalltalk unregisterExternalObject: semaphore.
		Smalltalk unregisterExternalObject: readSemaphore.
		Smalltalk unregisterExternalObject: writeSemaphore.
		socketHandle _ nil.
		readSemaphore _ writeSemaphore _ semaphore _ nil.
		self unregister].

]

{ #category : #'sending-receiving' }
OldSocket >> discardReceivedData [
	"Discard any data received up until now, and return the number of bytes discarded."

	| buf totalBytesDiscarded |
	buf _ String new: 10000.
	totalBytesDiscarded _ 0.
	[self isConnected and: [self dataAvailable]] whileTrue: [
		totalBytesDiscarded _
			totalBytesDiscarded + (self receiveDataInto: buf)].
	^ totalBytesDiscarded

]

{ #category : #'connection open/close' }
OldSocket >> disconnect [
	"Break this connection, no matter what state it is in. Data that has been sent but not received will be lost."

	self primSocketAbortConnection: socketHandle.

]

{ #category : #finalization }
OldSocket >> finalize [
	self primSocketDestroyGently: socketHandle.
	Smalltalk unregisterExternalObject: semaphore.
	Smalltalk unregisterExternalObject: readSemaphore.
	Smalltalk unregisterExternalObject: writeSemaphore.

]

{ #category : #'sending-receiving' }
OldSocket >> getData [
	"Get some data"

	| buf bytesRead |
	(self waitForDataUntil: Socket standardDeadline) ifFalse: [self error: 'getData timeout'].
	buf _ String new: 4000.
	bytesRead _ self primSocket: socketHandle receiveDataInto: buf startingAt: 1 count: buf size.
	^ buf copyFrom: 1 to: bytesRead
]

{ #category : #other }
OldSocket >> getOption: aName [ 
	"Get options on this socket, see Unix man pages for values for 
	sockets, IP, TCP, UDP. IE SO_KEEPALIVE
	returns an array, element one is an status number (0 ok, -1 read only option)
	element two is the resulting of the requested option"

	(socketHandle == nil or: [self isValid not])
		ifTrue: [self error: 'Socket status must valid before getting an option'].
	^self primSocket: socketHandle getOption: aName

"| foo options |
Socket initializeNetwork.
foo _ Socket newTCP.
foo connectTo: (NetNameResolver addressFromString: '192.168.1.1') port: 80.
foo waitForConnectionUntil: (Socket standardDeadline).

options _ {
'SO_DEBUG'. 'SO_REUSEADDR'. 'SO_REUSEPORT'. 'SO_DONTROUTE'.
'SO_BROADCAST'. 'SO_SNDBUF'. 'SO_RCVBUF'. 'SO_KEEPALIVE'.
'SO_OOBINLINE'. 'SO_PRIORITY'. 'SO_LINGER'. 'SO_RCVLOWAT'.
'SO_SNDLOWAT'. 'IP_TTL'. 'IP_HDRINCL'. 'IP_RCVOPTS'.
'IP_RCVDSTADDR'. 'IP_MULTICAST_IF'. 'IP_MULTICAST_TTL'.
'IP_MULTICAST_LOOP'. 'UDP_CHECKSUM'. 'TCP_MAXSEG'.
'TCP_NODELAY'. 'TCP_ABORT_THRESHOLD'. 'TCP_CONN_NOTIFY_THRESHOLD'. 
'TCP_CONN_ABORT_THRESHOLD'. 'TCP_NOTIFY_THRESHOLD'.
'TCP_URGENT_PTR_TYPE'}.

1 to: options size do: [:i | | fum |
	fum _foo getOption: (options at: i).
	Transcript show: (options at: i),fum printString;cr].

foo _ Socket newUDP.
foo setPeer: (NetNameResolver addressFromString: '192.168.1.9') port: 7.
foo waitForConnectionUntil: (Socket standardDeadline).

1 to: options size do: [:i | | fum |
	fum _foo getOption: (options at: i).
	Transcript show: (options at: i),fum printString;cr].
"
]

{ #category : #other }
OldSocket >> getResponseNoLF [
	"Get the response to the last command."

	| buf response bytesRead c lf |
	(self waitForDataUntil: (Socket deadlineSecs: 20)) ifFalse: [
		self error: 'getResponse timeout'].
	lf _ Character lf.
	buf _ String new: 1000.
	response _ WriteStream on: ''.
	[self dataAvailable] whileTrue: [
		bytesRead _ self primSocket: socketHandle receiveDataInto: buf startingAt: 1 count: buf size.
		1 to: bytesRead do: [ :i |
			(c _ buf at: i) ~= lf ifTrue: [response nextPut: c]]].

	^ response contents

]

{ #category : #'initialize-destroy' }
OldSocket >> initialize: socketType [
	"Initialize a new socket handle. If socket creation fails, socketHandle will be set to nil."
	| semaIndex readSemaIndex writeSemaIndex |

	primitiveOnlySupportsOneSemaphore _ false.
	semaphore _ Semaphore new.
	readSemaphore _ Semaphore new.
	writeSemaphore _ Semaphore new.
	semaIndex _ Smalltalk registerExternalObject: semaphore.
	readSemaIndex _ Smalltalk registerExternalObject: readSemaphore.
	writeSemaIndex _ Smalltalk registerExternalObject: writeSemaphore.
	socketHandle _
		self primSocketCreateNetwork: 0
			type: socketType
			receiveBufferSize: 8000
			sendBufSize: 8000
			semaIndex: semaIndex
			readSemaIndex: readSemaIndex
			writeSemaIndex: writeSemaIndex.

	socketHandle = nil ifTrue: [  "socket creation failed"
		Smalltalk unregisterExternalObject: semaphore.
		Smalltalk unregisterExternalObject: readSemaphore.
		Smalltalk unregisterExternalObject: writeSemaphore.
		readSemaphore _ writeSemaphore _ semaphore _ nil
	] ifFalse:[self register].

]

{ #category : #queries }
OldSocket >> isConnected [
	"Return true if this socket is connected."

	socketHandle == nil ifTrue: [^ false].
	^ (self primSocketConnectionStatus: socketHandle) == Connected

]

{ #category : #queries }
OldSocket >> isOtherEndClosed [
	"Return true if this socket had the other end closed."

	socketHandle == nil ifTrue: [^ false].
	^ (self primSocketConnectionStatus: socketHandle) == OtherEndClosed

]

{ #category : #queries }
OldSocket >> isThisEndClosed [
	"Return true if this socket had the this end closed."

	socketHandle == nil ifTrue: [^ false].
	^ (self primSocketConnectionStatus: socketHandle) == ThisEndClosed

]

{ #category : #queries }
OldSocket >> isUnconnected [
	"Return true if this socket's state is Unconnected."

	socketHandle == nil ifTrue: [^ false].
	^ (self primSocketConnectionStatus: socketHandle) == Unconnected

]

{ #category : #queries }
OldSocket >> isUnconnectedOrInvalid [
	"Return true if this socket is completely disconnected or is invalid."

	| status |
	socketHandle == nil ifTrue: [^ true].
	status _ self primSocketConnectionStatus: socketHandle.
	^ (status = Unconnected) | (status = InvalidSocket)

]

{ #category : #queries }
OldSocket >> isValid [
	"Return true if this socket contains a valid, non-nil socket handle."

	| status |
	socketHandle == nil ifTrue: [^ false].
	status _ self primSocketConnectionStatus: socketHandle.
	^ status ~= InvalidSocket

]

{ #category : #queries }
OldSocket >> isWaitingForConnection [
	"Return true if this socket is waiting for a connection."

	socketHandle == nil ifTrue: [^ false].
	^ (self primSocketConnectionStatus: socketHandle) == WaitingForConnection

]

{ #category : #'connection open/close' }
OldSocket >> listenOn: port [
	"Listen for a connection on the given port. This operation will return immediately; follow it with waitForConnectionUntil: to wait until a connection is established."

	| status |
	status _ self primSocketConnectionStatus: socketHandle.
	(status == Unconnected)
		ifFalse: [self error: 'Socket status must Unconnected before listening for a new connection'].

	self primSocket: socketHandle listenOn: port.

]

{ #category : #'connection open/close' }
OldSocket >> listenOn: portNumber backlogSize: backlog [
	"Listen for a connection on the given port.
	If this method succeeds, #accept may be used to establish a new connection"
	| status |
	status _ self primSocketConnectionStatus: socketHandle.
	(status == Unconnected)
		ifFalse: [self error: 'Socket status must Unconnected before listening for a new connection'].
	self primSocket: socketHandle listenOn: portNumber backlogSize: backlog.

]

{ #category : #'connection open/close' }
OldSocket >> listenOn: portNumber backlogSize: backlog interface: ifAddr [
	"Listen for a connection on the given port.
	If this method succeeds, #accept may be used to establish a new connection"
	| status |
	status _ self primSocketConnectionStatus: socketHandle.
	(status == Unconnected)
		ifFalse: [self error: 'Socket status must Unconnected before listening for a new connection'].
	self primSocket: socketHandle listenOn: portNumber backlogSize: backlog interface: ifAddr.

]

{ #category : #accessing }
OldSocket >> localAddress [
	self waitForConnectionUntil: Socket standardDeadline.
	self isConnected ifFalse: [^ByteArray new: 4].
	^ self primSocketLocalAddress: socketHandle

]

{ #category : #accessing }
OldSocket >> localPort [
	self waitForConnectionUntil: Socket standardDeadline.
	self isConnected ifFalse: [^0 ].
	^ self primSocketLocalPort: socketHandle

]

{ #category : #accessing }
OldSocket >> peerName [
	"Return the name of the host I'm connected to, or nil if its name isn't known to the domain name server or the request times out."
	"Note: Slow. Calls the domain name server, taking up to 20 seconds to time out. Even when sucessful, delays of up to 13 seconds have been observed during periods of high network load." 

	^ NetNameResolver
		nameForAddress: self remoteAddress
		timeout: 20

]

{ #category : #accessing }
OldSocket >> port [
	"Shortcut"
	^self localPort
]

{ #category : #primitives }
OldSocket >> primAcceptFrom: aHandle receiveBufferSize: rcvBufSize sendBufSize: sndBufSize semaIndex: semaIndex [
	"Create and return a new socket handle based on accepting the connection from the given listening socket"
	<primitive: 'primitiveSocketAccept' module: 'SocketPlugin'>
	^self primitiveFailed
]

{ #category : #primitives }
OldSocket >> primAcceptFrom: aHandle receiveBufferSize: rcvBufSize sendBufSize: sndBufSize semaIndex: semaIndex readSemaIndex: aReadSema writeSemaIndex: aWriteSema [
	"Create and return a new socket handle based on accepting the connection from the given listening socket"
	<primitive: 'primitiveSocketAccept3Semaphores' module: 'SocketPlugin'>
	primitiveOnlySupportsOneSemaphore _ true.
	^self primAcceptFrom: aHandle receiveBufferSize: rcvBufSize sendBufSize: sndBufSize semaIndex: semaIndex 
]

{ #category : #primitives }
OldSocket >> primSocket: socketID connectTo: hostAddress port: port [
	"Attempt to establish a connection to the given port of the given host. This is an asynchronous call; query the socket status to discover if and when the connection is actually completed."

	<primitive: 'primitiveSocketConnectToPort' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
OldSocket >> primSocket: socketID getOption: aString [ 
	"Get some option information on this socket. Refer to the UNIX 
	man pages for valid SO, TCP, IP, UDP options. In case of doubt
	refer to the source code.
	TCP_NODELAY, SO_KEEPALIVE are valid options for example
	returns an array containing the error code and the option value"

	<primitive: 'primitiveSocketGetOptions' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
OldSocket >> primSocket: socketID listenOn: port [
	"Listen for a connection on the given port. This is an asynchronous call; query the socket status to discover if and when the connection is actually completed."

	<primitive: 'primitiveSocketListenWithOrWithoutBacklog' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
OldSocket >> primSocket: aHandle listenOn: portNumber backlogSize: backlog [
	"Primitive. Set up the socket to listen on the given port.
	Will be used in conjunction with #accept only."
	<primitive: 'primitiveSocketListenWithOrWithoutBacklog' module: 'SocketPlugin'>
	self destroy. "Accept not supported so clean up"
]

{ #category : #primitives }
OldSocket >> primSocket: aHandle listenOn: portNumber backlogSize: backlog interface: ifAddr [
	"Primitive. Set up the socket to listen on the given port.
	Will be used in conjunction with #accept only."
	<primitive: 'primitiveSocketListenOnPortBacklogInterface' module: 'SocketPlugin'>
	self destroy. "Accept not supported so clean up"
]

{ #category : #primitives }
OldSocket >> primSocket: socketID receiveDataInto: aStringOrByteArray startingAt: startIndex count: count [
	"Receive data from the given socket into the given array starting at the given index. Return the number of bytes read or zero if no data is available."

	<primitive: 'primitiveSocketReceiveDataBufCount' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
OldSocket >> primSocket: socketID receiveUDPDataInto: aStringOrByteArray startingAt: startIndex count: count [
	"Receive data from the given socket into the given array starting at the given index. 
	Return an Array containing the amount read, the host address byte array, the host port, and the more flag"

	<primitive: 'primitiveSocketReceiveUDPDataBufCount' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
OldSocket >> primSocket: socketID sendData: aStringOrByteArray startIndex: startIndex count: count [
	"Send data to the remote host through the given socket starting with the given byte index of the given byte array. The data sent is 'pushed' immediately. Return the number of bytes of data actually sent; any remaining data should be re-submitted for sending after the current send operation has completed."
	"Note: In general, it many take several sendData calls to transmit a large data array since the data is sent in send-buffer-sized chunks. The size of the send buffer is determined when the socket is created."

	<primitive: 'primitiveSocketSendDataBufCount' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
OldSocket >> primSocket: socketID sendUDPData: aStringOrByteArray toHost: hostAddress  port: portNumber startIndex: startIndex count: count [
	"Send data to the remote host through the given socket starting with the given byte index of the given byte array. The data sent is 'pushed' immediately. Return the number of bytes of data actually sent; any remaining data should be re-submitted for sending after the current send operation has completed."
	"Note: In general, it many take several sendData calls to transmit a large data array since the data is sent in send-buffer-sized chunks. The size of the send buffer is determined when the socket is created."

	<primitive:  'primitiveSocketSendUDPDataBufCount' module: 'SocketPlugin'>
	self primitiveFailed


]

{ #category : #primitives }
OldSocket >> primSocket: socketID setOption: aString value: aStringValue [
	"Set some option information on this socket. Refer to the UNIX 
	man pages for valid SO, TCP, IP, UDP options. In case of doubt
	refer to the source code.
	TCP_NODELAY, SO_KEEPALIVE are valid options for example
	returns an array containing the error code and the negotiated value"

	<primitive: 'primitiveSocketSetOptions' module: 'SocketPlugin'>
	^nil
]

{ #category : #primitives }
OldSocket >> primSocket: socketID setPort: port [
	"Set the local port associated with a UDP socket.
	Note: this primitive is overloaded.  The primitive will not fail on a TCP socket, but
	the effects will not be what was desired.  Best solution would be to split Socket into
	two subclasses, TCPSocket and UDPSocket."

	<primitive: 'primitiveSocketListenWithOrWithoutBacklog' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
OldSocket >> primSocketAbortConnection: socketID [
	"Terminate the connection on the given port immediately without going through the normal close sequence. This is an asynchronous call; query the socket status to discover if and when the connection is actually terminated."

	<primitive: 'primitiveSocketAbortConnection' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
OldSocket >> primSocketCloseConnection: socketID [
	"Close the connection on the given port. The remote end is informed that this end has closed and will do no further sends. This is an asynchronous call; query the socket status to discover if and when the connection is actually closed."

	<primitive: 'primitiveSocketCloseConnection' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
OldSocket >> primSocketConnectionStatus: socketID [
	"Return an integer reflecting the connection status of this socket. For a list of possible values, see the comment in the 'initialize' method of this class. If the primitive fails, return a status indicating that the socket handle is no longer valid, perhaps because the Squeak image was saved and restored since the socket was created. (Sockets do not survive snapshots.)"

	<primitive: 'primitiveSocketConnectionStatus' module: 'SocketPlugin'>
	^ InvalidSocket

]

{ #category : #primitives }
OldSocket >> primSocketCreateNetwork: netType type: socketType receiveBufferSize: rcvBufSize sendBufSize: sendBufSize semaIndex: semaIndex [
	"Return a new socket handle for a socket of the given type and buffer sizes. Return nil if socket creation fails.
	The netType parameter is platform dependent and can be used to encode both the protocol type (IP, Xerox XNS, etc.) and/or the physical network interface to use if this host is connected to multiple networks. A zero netType means to use IP protocols and the primary (or only) network interface.
	The socketType parameter specifies:
		0	reliable stream socket (TCP if the protocol is IP)
		1	unreliable datagram socket (UDP if the protocol is IP)
	The buffer size parameters allow performance to be tuned to the application. For example, a larger receive buffer should be used when the application expects to be receiving large amounts of data, especially from a host that is far away. These values are considered requests only; the underlying implementation will ensure that the buffer sizes actually used are within allowable bounds. Note that memory may be limited, so an application that keeps many sockets open should use smaller buffer sizes. Note the macintosh implementation ignores this buffer size. Also see setOption to get/set socket buffer sizes which allows you to set/get the current buffer sizes for reading and writing.
 	If semaIndex is > 0, it is taken to be the index of a Semaphore in the external objects array to be associated with this socket. This semaphore will be signalled when the socket status changes, such as when data arrives or a send completes. All processes waiting on the semaphore will be awoken for each such event; each process must then query the socket state to figure out if the conditions they are waiting for have been met. For example, a process waiting to send some data can see if the last send has completed."

	<primitive: 'primitiveSocketCreate' module: 'SocketPlugin'>
	^ nil  "socket creation failed"

]

{ #category : #primitives }
OldSocket >> primSocketCreateNetwork: netType type: socketType receiveBufferSize: rcvBufSize sendBufSize: sendBufSize semaIndex: semaIndex readSemaIndex: aReadSema writeSemaIndex: aWriteSema [
	"See comment in primSocketCreateNetwork: with one semaIndex. However you should know that some implementations
	ignore the buffer size and this interface supports three semaphores,  one for open/close/listen and the other two for
	reading and writing"

	<primitive: 'primitiveSocketCreate3Semaphores' module: 'SocketPlugin'>
	primitiveOnlySupportsOneSemaphore _ true.
	^ self primSocketCreateNetwork: netType
			type: socketType
			receiveBufferSize: rcvBufSize
			sendBufSize: sendBufSize
			semaIndex: semaIndex
]

{ #category : #primitives }
OldSocket >> primSocketDestroy: socketID [
	"Release the resources associated with this socket. If a connection is open, it is aborted."

	<primitive: 'primitiveSocketDestroy' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
OldSocket >> primSocketDestroyGently: socketID [
	"Release the resources associated with this socket. If a connection is open, it is aborted.
	Do not fail if the receiver is already closed."

	<primitive: 'primitiveSocketDestroy' module: 'SocketPlugin'>

]

{ #category : #primitives }
OldSocket >> primSocketError: socketID [
	"Return an integer encoding the most recent error on this socket. Zero means no error."

	<primitive: 'primitiveSocketError' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
OldSocket >> primSocketLocalAddress: socketID [
	"Return the local host address for this socket."

	<primitive: 'primitiveSocketLocalAddress' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
OldSocket >> primSocketLocalPort: socketID [
	"Return the local port for this socket, or zero if no port has yet been assigned."

	<primitive: 'primitiveSocketLocalPort' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
OldSocket >> primSocketReceiveDataAvailable: socketID [
	"Return true if data may be available for reading from the current socket."

	<primitive: 'primitiveSocketReceiveDataAvailable' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
OldSocket >> primSocketRemoteAddress: socketID [
	"Return the remote host address for this socket, or zero if no connection has been made."

	<primitive: 'primitiveSocketRemoteAddress' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
OldSocket >> primSocketRemotePort: socketID [
	"Return the remote port for this socket, or zero if no connection has been made."

	<primitive: 'primitiveSocketRemotePort' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
OldSocket >> primSocketSendDone: socketID [
	"Return true if there is no send in progress on the current socket."

	<primitive: 'primitiveSocketSendDone' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #accessing }
OldSocket >> primitiveOnlySupportsOneSemaphore [
	^primitiveOnlySupportsOneSemaphore
]

{ #category : #printing }
OldSocket >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: '[', self statusString, ']'.

]

{ #category : #'sending-receiving' }
OldSocket >> readInto: aStringOrByteArray startingAt: aNumber [
	"Read data into the given buffer starting at the given index and return the number of bytes received. Note the given buffer may be only partially filled by the received data."

	(self waitForDataUntil: Socket standardDeadline) ifFalse: [self error: 'receive timeout'].
	^ self primSocket: socketHandle
		receiveDataInto: aStringOrByteArray
		startingAt: aNumber
		count: aStringOrByteArray size - aNumber + 1

]

{ #category : #accessing }
OldSocket >> readSemaphore [
	primitiveOnlySupportsOneSemaphore ifTrue: [^semaphore].
	^readSemaphore
]

{ #category : #'sending-receiving' }
OldSocket >> receiveDataInto: aStringOrByteArray [
	"Receive data into the given buffer and return the number of bytes received. Note the given buffer may be only partially filled by the received data."

	^ self primSocket: socketHandle
		receiveDataInto: aStringOrByteArray
		startingAt: 1
		count: aStringOrByteArray size

]

{ #category : #datagrams }
OldSocket >> receiveDataInto: aStringOrByteArray fromHost: hostAddress port: portNumber [
	| datagram |
	"Receive a UDP packet from the given hostAddress/portNumber, storing the data in the given buffer, and return the number of bytes received. Note the given buffer may be only partially filled by the received data."

	primitiveOnlySupportsOneSemaphore ifTrue:
		[self setPeer: hostAddress port: portNumber.
		^self receiveDataInto: aStringOrByteArray].
	[true] whileTrue: 
		[datagram _ self receiveUDPDataInto: aStringOrByteArray.
		((datagram at: 2) = hostAddress and: [(datagram at: 3) = portNumber]) 
			ifTrue: [^datagram at: 1]
			ifFalse: [^0]]
]

{ #category : #datagrams }
OldSocket >> receiveUDPDataInto: aStringOrByteArray [
	"Receive UDP data into the given buffer and return the number of bytes received. Note the given buffer may be only partially filled by the received data. What is returned is an array, the first element is the bytes read, the second the sending bytearray address, the third the senders port, the fourth, true if more of the datagram awaits reading"

	^ self primSocket: socketHandle
		receiveUDPDataInto: aStringOrByteArray
		startingAt: 1
		count: aStringOrByteArray size

]

{ #category : #registry }
OldSocket >> register [
	^self class register: self
]

{ #category : #accessing }
OldSocket >> remoteAddress [

	^ self primSocketRemoteAddress: socketHandle

]

{ #category : #accessing }
OldSocket >> remotePort [

	^ self primSocketRemotePort: socketHandle

]

{ #category : #accessing }
OldSocket >> semaphore [
	^semaphore
]

{ #category : #'sending-receiving' }
OldSocket >> sendData: aStringOrByteArray [
	"Send all of the data in the given array, even if it requires multiple calls to send it all. Return the number of bytes sent."

	"An experimental version use on slow lines: Longer timeout and smaller writes to try to avoid spurious timeouts."

	| bytesSent bytesToSend count |
	bytesToSend _ aStringOrByteArray size.
	bytesSent _ 0.
	[bytesSent < bytesToSend] whileTrue: [
		(self waitForSendDoneUntil: (Socket deadlineSecs: 60))
			ifFalse: [self error: 'send data timeout; data not sent'].
		count _ self primSocket: socketHandle
			sendData: aStringOrByteArray
			startIndex: bytesSent + 1
			count: (bytesToSend - bytesSent min: 5000).
		bytesSent _ bytesSent + count].

	^ bytesSent

]

{ #category : #'sending-receiving' }
OldSocket >> sendData: buffer count: n [
	"Send the amount of data from the given buffer"
	| sent |
	sent _ 0.
	[sent < n] whileTrue:[
		sent _ sent + (self sendSomeData: buffer startIndex: sent+1 count: (n-sent))].
]

{ #category : #datagrams }
OldSocket >> sendData: aStringOrByteArray toHost: hostAddress port: portNumber [
	"Send a UDP packet containing the given data to the specified host/port."

	primitiveOnlySupportsOneSemaphore ifTrue:
		[self setPeer: hostAddress port: portNumber.
		^self sendData: aStringOrByteArray].
	^self sendUDPData: aStringOrByteArray toHost: hostAddress port: portNumber
]

{ #category : #queries }
OldSocket >> sendDone [
	"Return true if the most recent send operation on this socket has completed."

	socketHandle == nil ifTrue: [^ false].
	^ self primSocketSendDone: socketHandle

]

{ #category : #'sending-receiving' }
OldSocket >> sendSomeData: aStringOrByteArray [
	"Send as much of the given data as possible and answer the number of bytes actually sent."
	"Note: This operation may have to be repeated multiple times to send a large amount of data."

	^ self
		sendSomeData: aStringOrByteArray
		startIndex: 1
		count: aStringOrByteArray size
]

{ #category : #'sending-receiving' }
OldSocket >> sendSomeData: aStringOrByteArray startIndex: startIndex [
	"Send as much of the given data as possible starting at the given index. Answer the number of bytes actually sent."
	"Note: This operation may have to be repeated multiple times to send a large amount of data."

	^ self
		sendSomeData: aStringOrByteArray
		startIndex: startIndex
		count: (aStringOrByteArray size - startIndex + 1)
]

{ #category : #'sending-receiving' }
OldSocket >> sendSomeData: aStringOrByteArray startIndex: startIndex count: count [
	"Send up to count bytes of the given data starting at the given index. Answer the number of bytes actually sent."
	"Note: This operation may have to be repeated multiple times to send a large amount of data."

	| bytesSent |
	(self waitForSendDoneUntil: (Socket deadlineSecs: 20))
		ifTrue: [
			bytesSent _ self primSocket: socketHandle
				sendData: aStringOrByteArray
				startIndex: startIndex
				count: count]
		ifFalse: [self error: 'send data timeout; data not sent'].
	^ bytesSent

]

{ #category : #datagrams }
OldSocket >> sendUDPData: aStringOrByteArray toHost: hostAddress port: portNumber [
	"Send a UDP packet containing the given data to the specified host/port."
	| bytesToSend bytesSent count |

	bytesToSend _ aStringOrByteArray size.
	bytesSent _ 0.
	[bytesSent < bytesToSend] whileTrue: [
		(self waitForSendDoneUntil: (Socket deadlineSecs: 20))
			ifFalse: [self error: 'send data timeout; data not sent'].
		count _ self primSocket: socketHandle
			sendUDPData: aStringOrByteArray
			toHost: hostAddress
			port: portNumber
			startIndex: bytesSent + 1
			count: bytesToSend - bytesSent.
		bytesSent _ bytesSent + count].

	^ bytesSent

]

{ #category : #other }
OldSocket >> setOption: aName value: aValue [ 
	| value |
	"setup options on this socket, see Unix man pages for values for 
	sockets, IP, TCP, UDP. IE SO_KEEPALIVE
	returns an array, element one is the error number
	element two is the resulting of the negotiated value.
	See getOption for list of keys"

	(socketHandle == nil or: [self isValid not])
		ifTrue: [self error: 'Socket status must valid before setting an option'].
	value _ aValue asString.
	aValue == true ifTrue: [value _ '1'].
	aValue == false ifTrue: [value _ '0'].
	^ self primSocket: socketHandle setOption: aName value: value
]

{ #category : #datagrams }
OldSocket >> setPeer: hostAddress port: port [
	"Set the default send/recv address."

	self primSocket: socketHandle connectTo: hostAddress port: port.

]

{ #category : #datagrams }
OldSocket >> setPort: port [
	"Associate a local port number with a UDP socket.  Not applicable to TCP sockets."

	self primSocket: socketHandle setPort: port.

]

{ #category : #queries }
OldSocket >> socketError [
	^self primSocketError: socketHandle
]

{ #category : #accessing }
OldSocket >> socketHandle [
	^socketHandle
]

{ #category : #queries }
OldSocket >> statusString [
	"Return a string describing the status of this socket."

	| status |
	socketHandle == nil ifTrue: [^ 'destroyed'].
	status _ self primSocketConnectionStatus: socketHandle.
	status = InvalidSocket ifTrue: [^ 'invalidSocketHandle'].
	status = Unconnected ifTrue: [^ 'unconnected'].
	status = WaitingForConnection ifTrue: [^ 'waitingForConnection'].
	status = Connected ifTrue: [^ 'connected'].
	status = OtherEndClosed ifTrue: [^ 'otherEndClosedButNotThisEnd'].
	status = ThisEndClosed ifTrue: [^ 'thisEndClosedButNotOtherEnd'].
	^ 'unknown socket status'

]

{ #category : #registry }
OldSocket >> unregister [
	^self class unregister: self
]

{ #category : #waiting }
OldSocket >> waitForAcceptUntil: deadLine [
	"Wait and accept an incoming connection"
	self waitForConnectionUntil: deadLine.
	^self isConnected
		ifTrue:[self accept]
		ifFalse:[nil]
]

{ #category : #waiting }
OldSocket >> waitForConnectionUntil: deadline [
	"Wait up until the given deadline for a connection to be established. Return true if it is established by the deadline, false if not."

	| status |
	status _ self primSocketConnectionStatus: socketHandle.
	[(status = WaitingForConnection) and: [Time millisecondClockValue < deadline]]
		whileTrue: [
			semaphore waitTimeoutMSecs: (deadline - Time millisecondClockValue).
			status _ self primSocketConnectionStatus: socketHandle].

	^ status = Connected

]

{ #category : #waiting }
OldSocket >> waitForDataUntil: deadline [
	"Wait up until the given deadline for data to arrive. Return true if data arrives by the deadline, false if not."

	| dataArrived |
	[self isConnected & 
	 (dataArrived _ self primSocketReceiveDataAvailable: socketHandle) not
			"Connection end and final data can happen fast, so test in this order"
		and: [Time millisecondClockValue < deadline]] whileTrue: [
			self readSemaphore waitTimeoutMSecs: (deadline - Time millisecondClockValue)].

	^ dataArrived

]

{ #category : #waiting }
OldSocket >> waitForDisconnectionUntil: deadline [
	"Wait up until the given deadline for the the connection to be broken. Return true if it is broken by the deadline, false if not."
	"Note: The client should know the the connect is really going to be closed (e.g., because he has called 'close' to send a close request to the other end) before calling this method.
JMM 00/5/17 note that other end can close which will terminate wait"

	| extraBytes status |
	extraBytes _ 0.
	status _ self primSocketConnectionStatus: socketHandle.
	[((status = Connected) or: [(status = ThisEndClosed)]) and:
	 [Time millisecondClockValue < deadline]] whileTrue: [
		self dataAvailable
			ifTrue: [extraBytes _ extraBytes + self discardReceivedData].
		semaphore waitTimeoutMSecs: (deadline - Time millisecondClockValue).
		status _ self primSocketConnectionStatus: socketHandle].

	extraBytes > 0
		ifTrue: [self inform: 'Discarded ', extraBytes printString, ' bytes while closing connection.'].

	^ status ~= Connected

]

{ #category : #waiting }
OldSocket >> waitForSendDoneUntil: deadline [
	"Wait up until the given deadline for the current send operation to complete. Return true if it completes by the deadline, false if not."

	| sendDone |
	[self isConnected & (sendDone _ self primSocketSendDone: socketHandle) not
			"Connection end and final data can happen fast, so test in this order"
		and: [Time millisecondClockValue < deadline]] whileTrue: [
			self writeSemaphore waitTimeoutMSecs: (deadline - Time millisecondClockValue)].

	^ sendDone
]

{ #category : #accessing }
OldSocket >> writeSemaphore [
	primitiveOnlySupportsOneSemaphore ifTrue: [^semaphore].
	^writeSemaphore
]
