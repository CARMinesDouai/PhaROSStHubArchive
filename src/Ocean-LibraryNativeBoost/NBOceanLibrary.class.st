Class {
	#name : #NBOceanLibrary,
	#superclass : #Object,
	#instVars : [
		'errNo'
	],
	#classVars : [
		'TypeAliases'
	],
	#pools : [
		'NBOceanLibraryConstants',
		'OCNSysSocketConstants'
	],
	#category : #'Ocean-LibraryNativeBoost'
}

{ #category : #types }
NBOceanLibrary class >> externalTypeAlias: aName [

	^ self typeAliases at: aName ifAbsent: nil
]

{ #category : #types }
NBOceanLibrary class >> initTypeAliases [ 

	"self initTypeAliases"

	^  TypeAliases :=  Dictionary newFromPairs: #(
		uint32_t  ulong
		uint16_t  ushort
		sockaddr NBSockAddrIn
		socklen_t ulong
		size_t ulong
		
	)
]

{ #category : #types }
NBOceanLibrary class >> typeAliases [

	^ TypeAliases ifNil: [ self initTypeAliases ]
]

{ #category : #'socket library functions' }
NBOceanLibrary >> accept: sockfd addr: sockaddr addrLen: addrLenBuf [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin>

"
When an application is listening for stream-oriented connections from other hosts, it is notified of such events (cf. select() function) and must initialize the connection using the accept() function. Accept() creates a new socket for each connection and removes the connection from the listen queue. It takes the following arguments:

    sockfd, the descriptor of the listening socket that has the connection queued.
    cliaddr, a pointer to a sockaddr structure to receive the client's address information.
    addrlen, a pointer to a socklen_t location that specifies the size of the client address structure passed to accept(). When accept() returns, this location indicates how many bytes of the structure were actually used.

The accept() function returns the new socket descriptor for the accepted connection, or -1 if an error occurs. All further communication with the remote host now occurs via this new socket.

Datagram sockets do not require processing by accept() since the receiver may immediately respond to the request using the listening socket.
"
	
	^ self call: #( int accept(int sockfd,  sockaddr *sockaddr, socklen_t *addrLenBuf) ) failCode: -1 
]

{ #category : #'socket library functions' }
NBOceanLibrary >> bind: sockfd address: socketAddress size: addrlen [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin>
"bind() assigns a socket to an address. When a socket is created using socket(), it is only given a protocol family, but not assigned an address. This association with an address must be performed with the bind() system call before the socket can accept connections to other hosts. bind() takes three arguments:

    sockfd, a descriptor representing the socket to perform the bind on.
    my_addr, a pointer to a sockaddr structure representing the address to bind to.
    addrlen, a socklen_t field specifying the size of the sockaddr structure.

Bind() returns 0 on success and -1 if an error occurs."

	^ self call: #( int bind(int sockfd,  sockaddr socketAddress, socklen_t addrlen) ) failCode: -1
]

{ #category : #'TCP API' }
NBOceanLibrary >> bind: aSocket toIpv4Address: anAddress [
	"anAddress represents the local address of the network interface to use"
	
	| result primitiveAddress |
	primitiveAddress := self posixIPV4AddressFrom: anAddress.
	result := self bind: aSocket socketId address: primitiveAddress size: primitiveAddress instanceSize. 
	result = -1 ifTrue: [OCNSocketOperationFailureError signal: 'Bind failure']
]

{ #category : #'code generation' }
NBOceanLibrary >> call: fnSpec [ 
	| sender |
	
	sender := thisContext sender.
	^ NBFFICallout  
		handleFailureIn: sender
		nativeCode: [ :gen |
			gen
				sender: sender;
				cdecl;
				generateCall: fnSpec module: self libraryHandle]

]

{ #category : #'code generation' }
NBOceanLibrary >> call: fnSpec failCode: aReturnValue [
	"will customize it later"
	| sender method |
	
	sender := thisContext sender.
	^ NBFFICallout  
		handleFailureIn: sender
		nativeCode: [ :gen |
			gen
				sender: sender;
				cdecl;
				generateCall: fnSpec module: self libraryHandle]

]

{ #category : #'code generation' }
NBOceanLibrary >> call: fnSpec options: anOptions [

	| sender |
	
	sender := thisContext sender.
	^ NBFFICallout  
		handleFailureIn: sender
		nativeCode: [ :gen |
			gen
				sender: sender;
				parseOptions: anOptions;  
				cdecl;
				generateCall: fnSpec module: self libraryHandle]

]

{ #category : #'socket library functions' }
NBOceanLibrary >> close: socket [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin>

	^ self call: #( int close (int socket) ) failCode: -1
]

{ #category : #'socket library functions' }
NBOceanLibrary >> connect: sockfd serverAddress: serverAddr [
	^ self connect: sockfd serverAddress: serverAddr addrLen: serverAddr class instanceSize.
]

{ #category : #'socket library functions' }
NBOceanLibrary >> connect: sockfd serverAddress: serverAddr addrLen: addrLen [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin>

"The connect() system call connects a socket, identified by its file descriptor, to a remote host specified by that host's address in the argument list.

Certain types of sockets are connectionless, most commonly user datagram protocol sockets. For these sockets, connect takes on a special meaning: the default target for sending and receiving data gets set to the given address, allowing the use of functions such as send() and recv() on connectionless sockets.

connect() returns an integer representing the error code: 0 represents success, while -1 represents an error."
	
	^ self call: #( int connect(int sockfd,  sockaddr serverAddr, socklen_t addrLen) ) failCode: -1
]

{ #category : #'TCP API' }
NBOceanLibrary >> connect: aSocket toServerWithIpv4Address: serverAddress [
	| result addr |
	addr := self posixIPV4AddressFrom: serverAddress.
	
	result := self connect: aSocket socketId
		serverAddress: addr
		serverAddressSize: addr instanceSize.
	result = -1  ifTrue: [OCNSocketOperationFailureError signal: 'Connection failure']
]

{ #category : #'TCP API' }
NBOceanLibrary >> createTcpSocket [

	^ self socketDomain: PF_INET type: SOCK_STREAM protocol: IPPROTO_TCP.

]

{ #category : #'TCP API' }
NBOceanLibrary >> createTcpSocketDescriptorId [
 	| result |
	result := self 
		socketDomain: PF_INET
		type: SOCK_STREAM
		protocol: IPPROTO_TCP.
	
	result = -1  ifTrue: [OCNSocketOperationFailureError signal: 'Socket creation failure'].
	^ result
]

{ #category : #'socket creation' }
NBOceanLibrary >> destroy: anOCNSocket [
	| result |
	result := self close: anOCNSocket socketId.
	result = -1  ifTrue: [OCNSocketOperationFailureError signal: 'Close failed'].
	
	"reset id, just for case"
	anOCNSocket socketId: nil  
]

{ #category : #'system error' }
NBOceanLibrary >> errNo [
	errNo notNull ifTrue: [
		^ errNo longAt: 0
	].
	^ nil
]

{ #category : #'socket library functions' }
NBOceanLibrary >> freeAddrInfo: ai [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin>

	^ self call: #(
		void freeaddrinfo( NBExternalAddress ai "struct addrinfo *ai")
		)

]

{ #category : #resolving }
NBOceanLibrary >> getAddrInfo: hostName [

	| ai hints infos next results |
	ai := NBExternalAddress new.  
	
	hints := NBAddrInfo new.
	hints 
		ai_family: AF_INET;
		ai_flags: (AI_CANONNAME | AI_DEFAULT).
		  
	( self getAddrInfo: hostName service: nil hints: hints result: ai ) ~= 0 ifTrue: [
		self error: 'Unable to resolve host name' ].
		
	infos := OrderedCollection new.
	next := ai.

	[
		[ | info oinfo |
			info := NBAddrInfo fromPointer: next.
			oinfo := NBOceanAddressInfo new.
			
			info ai_canonname notNull ifTrue: [
				oinfo canonicalName: info ai_canonname readString 
			].
			
			oinfo family: info ai_family.
			oinfo protocol: info ai_protocol.
			oinfo socketType: info ai_socktype.
			oinfo addrLen: info ai_addrlen.
			        
			(info ai_family = AF_INET and: [ info ai_addrlen = 16 ]) ifTrue: [
				info ai_addr notNull ifTrue: [ | addr |
					addr := (NBSockAddrIn fromPointer: info ai_addr ).
					oinfo addr: addr ]
			].
			infos add: oinfo.
			next := info ai_next.
			next isNull 
		 ] whileFalse.

	] ensure: [ 
		self freeAddrInfo: ai.
	 ].

	^ infos
]

{ #category : #'socket library functions' }
NBOceanLibrary >> getAddrInfo: hostName service: servName hints: hints result: res [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin>

"
     This structure can be used to provide hints concerning the type of socket that the caller supports or wishes to use.  The caller can
     supply the following structure elements in hints:

     ai_family      The protocol family that should be used.  When ai_family is set to PF_UNSPEC, it means the caller will accept any pro-
                    tocol family supported by the operating system.

     ai_socktype    Denotes the type of socket that is wanted: SOCK_STREAM, SOCK_DGRAM, or SOCK_RAW.  When ai_socktype is zero the caller
                    will accept any socket type.

     ai_protocol    Indicates which transport protocol is desired, IPPROTO_UDP or IPPROTO_TCP.  If ai_protocol is zero the caller will
                    accept any protocol.

     ai_flags       The ai_flags field to which the hints parameter points shall be set to zero or be the bitwise-inclusive OR of one or
                    more of the values AI_ADDRCONFIG, AI_ALL, AI_CANONNAME, AI_NUMERICHOST, AI_NUMERICSERV, AI_PASSIVE, and AI_V4MAPPED.

                    AI_ADDRCONFIG   If the AI_ADDRCONFIG bit is set, IPv4 addresses shall be returned only if an IPv4 address is configured
                                    on the local system, and IPv6 addresses shall be returned only if an IPv6 address is configured on the
                                    local system.

                    AI_ALL          If the AI_ALL bit is set with the AI_V4MAPPED bit, then getaddrinfo() shall return all matching IPv6
                                    and IPv4 addresses.  The AI_ALL bit without the AI_V4MAPPED bit is ignored.

                    AI_CANONNAME    If the AI_CANONNAME bit is set, a successful call to getaddrinfo() will return a NUL-terminated string
                                    containing the canonical name of the specified hostname in the ai_canonname element of the first
                                    addrinfo structure returned.

                    AI_NUMERICHOST  If the AI_NUMERICHOST bit is set, it indicates that hostname should be treated as a numeric string
                                    defining an IPv4 or IPv6 address and no name resolution should be attempted.

                    AI_NUMERICSERV  If the AI_NUMERICSERV bit is set, then a non-null servname string supplied shall be a numeric port
                                    string.  Otherwise, an EAI_NONAME error shall be returned.  This bit shall prevent any type of name
                                    resolution service (for example, NIS+) from being invoked.

                    AI_PASSIVE      If the AI_PASSIVE bit is set it indicates that the returned socket address structure is intended for
                                    use in a call to bind(2).  In this case, if the hostname argument is the null pointer, then the IP
                                    address portion of the socket address structure will be set to INADDR_ANY for an IPv4 address or
                                    IN6ADDR_ANY_INIT for an IPv6 address.

                                    If the AI_PASSIVE bit is not set, the returned socket address structure will be ready for use in a call
                                    to connect(2) for a connection-oriented protocol or connect(2), sendto(2), or sendmsg(2) if a connec-
                                    tionless protocol was chosen.  The IP address portion of the socket address structure will be set to
                                    the loopback address if hostname is the null pointer and AI_PASSIVE is not set.

                    AI_V4MAPPED     If the AI_V4MAPPED flag is specified along with an ai_family of AF_INET6, then getaddrinfo() shall
                                    return IPv4-mapped IPv6 addresses on finding no matching IPv6 addresses ( ai_addrlen shall be 16).  The
                                    AI_V4MAPPED flag shall be ignored unless ai_family equals AF_INET6.

     All other elements of the addrinfo structure passed via hints must be zero or the null pointer.
"
	^ self call: #( 
		int getaddrinfo(String hostName , String servName ,  NBAddrInfo hints,  NBExternalAddress * res)
	) options: #( + optStringOrNull "nil is valid as string param")
	
]

{ #category : #'socket library functions' }
NBOceanLibrary >> getAddrInfo: hostName service: servName result: res [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin>

	^ self call: #( 
		int getaddrinfo(String hostName , String servName ,  0 "addrinfo* hints",  void * res)
	) options: #( + optStringOrNull "nil is valid as string param")
]

{ #category : #'socket library functions' }
NBOceanLibrary >> getHostByAddr: addr len: len type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin>
"
The gethostbyname() and gethostbyaddr() functions are used to resolve host names and addresses in the domain name system or the local host's other resolver mechanisms (e.g., /etc/hosts lookup). They return a pointer to an object of type struct hostent, which describes an Internet Protocol host. The functions take the following arguments:

    name specifies the name of the host. For example: www.wikipedia.org
    addr specifies a pointer to a struct in_addr containing the address of the host.
    len specifies the length, in bytes, of addr.
    type specifies the address family type (e.g., AF_INET) of the host address.

The functions return a NULL pointer in case of error, in which case the external integer h_errno may be checked to see whether this is a temporary failure or an invalid or unknown host. Otherwise a valid struct hostent * is returned.

These functions are not strictly a component of the BSD socket API, but are often used in conjunction with the API functions. Furthermore, these functions are now considered legacy interfaces for querying the domain name system. New functions that are completely protocol-agnostic (supporting IPv6) have been defined. These new function are getaddrinfo() and getnameinfo(), and are based on a new addrinfo data structure.
"
	
	^ self call: #( hostent *gethostbyAddr ( void *addr, int len, int type ) ) failCode: 0
	
]

{ #category : #'socket library functions' }
NBOceanLibrary >> getHostByName: aName [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin>

"
The gethostbyname() and gethostbyaddr() functions are used to resolve host names and addresses in the domain name system or the local host's other resolver mechanisms (e.g., /etc/hosts lookup). They return a pointer to an object of type struct hostent, which describes an Internet Protocol host. The functions take the following arguments:

    name specifies the name of the host. For example: www.wikipedia.org
    addr specifies a pointer to a struct in_addr containing the address of the host.
    len specifies the length, in bytes, of addr.
    type specifies the address family type (e.g., AF_INET) of the host address.

The functions return a NULL pointer in case of error, in which case the external integer h_errno may be checked to see whether this is a temporary failure or an invalid or unknown host. Otherwise a valid struct hostent * is returned.

These functions are not strictly a component of the BSD socket API, but are often used in conjunction with the API functions. Furthermore, these functions are now considered legacy interfaces for querying the domain name system. New functions that are completely protocol-agnostic (supporting IPv6) have been defined. These new function are getaddrinfo() and getnameinfo(), and are based on a new addrinfo data structure.
"
	
	^ self call: #( hostent *gethostbyname( String aName) ) failCode: 0
	
]

{ #category : #'byte conversions' }
NBOceanLibrary >> htonl: hostlong [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin >

	^ NBFFICallout 
		cdecl: #( uint32_t htonl (uint32_t hostlong) ) 
		module: self libraryHandle.

]

{ #category : #'byte conversions' }
NBOceanLibrary >> htons: hostshort [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin >

	^ NBFFICallout 
		cdecl: #( uint16_t htons (uint16_t hostshort) ) 
		module: self libraryHandle.

]

{ #category : #'socket library functions' }
NBOceanLibrary >> inet_aton: addressString [ 
	| buf |
	
	buf := ByteArray new: 20.
	(self inet_aton: addressString addr: buf) == 1 ifFalse: [
		self error: 'Invalid address string' ].
	^ buf nbUlongAt: 1
]

{ #category : #'socket library functions' }
NBOceanLibrary >> inet_aton: addressString addr: in_addr_buf [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin>
	
	^ self call: #( int inet_aton (String addressString, void * in_addr_buf ) ) failCode: 0
	
]

{ #category : #'socket library functions' }
NBOceanLibrary >> inet_ntoa: in_addr [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin>
	
	^ self call: #( String inet_ntoa ( ulong in_addr ) ) failCode: 0
	
]

{ #category : #'initialize-release' }
NBOceanLibrary >> initialize [ 
	errNo := 
		NBExternalAddress value: (
			NativeBoost forCurrentPlatform loadSymbol: 'errno' fromModuleHandle: self libraryHandle).
	errNo isNull ifTrue: [ self error: 'Unable to initialize library: errno symbol not found']. 

]

{ #category : #'socket address' }
NBOceanLibrary >> ipv4Address: ipAddrString port: aPort [
	| addr |
	addr := NBSockAddrIn new.
	addr sin_family: AF_INET;
		sin_port: (self htons: aPort);
		sin_addr: (self inet_aton: ipAddrString).
	
	^ addr
]

{ #category : #library }
NBOceanLibrary >> libraryHandle [
	^ NativeBoost forCurrentPlatform 
		loadModule: self libraryName
]

{ #category : #library }
NBOceanLibrary >> libraryName [
	^'/System/Library/Frameworks/System.framework/System'
]

{ #category : #'socket library functions' }
NBOceanLibrary >> listen: sockfd backlog: backlogSize [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin>

"After a socket has been associated with an address, listen() prepares it for incoming connections. However, this is only necessary for the stream-oriented (connection-oriented) data modes, i.e., for socket types (SOCK_STREAM, SOCK_SEQPACKET). listen() requires two arguments:

    sockfd, a valid socket descriptor.
    backlog, an integer representing the number of pending connections that can be queued up at any one time. The operating system usually places a cap on this value.

Once a connection is accepted, it is dequeued. On success, 0 is returned. If an error occurs, -1 is returned."

	^ self call: #( int listen(int sockfd, int backlogSize) ) failCode: -1
]

{ #category : #'socket creation' }
NBOceanLibrary >> newTcpSocket [
	| sock fd |
	
	"this is awful, but anyways ;)"
	sock := (OCNTcpSocket newWithNetworkLibrary: self ).
	sock state: sock cleanStateSymbol.

	fd :=  self socketDomain: PF_INET type: SOCK_STREAM protocol: IPPROTO_TCP.
	
	fd = -1  ifTrue: [OCNSocketOperationFailureError signal: 'Socket creation failure'].

	sock socketId: fd.
	^ sock
]

{ #category : #'byte conversions' }
NBOceanLibrary >> ntohs: netshort [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin >

	^ NBFFICallout 
		cdecl: #( uint16_t ntohs( uint16_t netshort) ) 
		module: self libraryHandle.

]

{ #category : #'byte conversions' }
NBOceanLibrary >> ntonl: netlong [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin >

	^ NBFFICallout 
		cdecl: #( uint32_t ntohl ( uint32_t netlong) ) 
		module: self libraryHandle.

]

{ #category : #'socket address' }
NBOceanLibrary >> posixIPV4AddressFrom: aSocketAddress [

	| posixAddress family |
	posixAddress := NBSockAddrIn new.
	(aSocketAddress isOfAfInetFamily) 
		ifTrue: [ family := AF_INET ]
		ifFalse: [ self error: 'Only AfInet socket family are supported' ].
	posixAddress sin_family: (self htons: family).
	posixAddress sin_port: (self htons: aSocketAddress port).
	posixAddress sin_addr: (aSocketAddress ip nbUlongAt: 1).
	^posixAddress
]

{ #category : #'socket library functions' }
NBOceanLibrary >> recv: socket buffer: buffer len: length flags: flags [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin>

	^ self call: #(
		ssize_t
			recv(int socket, void *buffer, size_t length, int flags)
	 ) failCode: -1
]

{ #category : #'socket library functions' }
NBOceanLibrary >> recvfrom: socket buffer: buffer len: length flags: flags addr: address addrLen: address_len [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin>

	^ self call: #(
		ssize_t
			recvfrom(int socket, void * buffer, size_t length, int flags,  sockaddr * address,
				socklen_t * address_len)
	 ) failCode: -1
]

{ #category : #'socket library functions' }
NBOceanLibrary >> sendTo: socket buffer: buffer len: length [ 
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin>

	^ self call: #( ssize_t send ( int socket,  void *buffer, size_t length, 0) ) failCode: -1
]

{ #category : #'socket library functions' }
NBOceanLibrary >> sendTo: socket buffer: buffer len: length flags: flags [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin>

	^ self call: #( ssize_t send ( int socket,  void *buffer, size_t length, int flags) ) failCode: -1
]

{ #category : #'socket library functions' }
NBOceanLibrary >> sendTo: socket buffer: buffer len: length flags: flags destAddr: dest_addr addrLen: dest_len [ 
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin>

	^ self call: #(
		ssize_t sendto (int socket,  void *buffer, size_t length, int flags,  sockaddr *dest_addr, socklen_t dest_len)
	 ) failCode: -1
]

{ #category : #'socket library functions' }
NBOceanLibrary >> socketDomain: domain type: type protocol: protocol [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin>
"socket() creates an endpoint for communication and returns a file descriptor for the socket. socket() takes three arguments:

    domain, which specifies the protocol family of the created socket. For example:
        PF_INET for network protocol IPv4 or
        PF_INET6 for IPv6.
        PF_UNIX for local socket (using a file).
    type, one of:
        SOCK_STREAM (reliable stream-oriented service or Stream Sockets)
        SOCK_DGRAM (datagram service or Datagram Sockets)
        SOCK_SEQPACKET (reliable sequenced packet service), or
        SOCK_RAW (raw protocols atop the network layer).
    protocol specifying the actual transport protocol to use. The most common are IPPROTO_TCP, IPPROTO_SCTP, IPPROTO_UDP, IPPROTO_DCCP. These protocols are specified in <netinet/in.h>. 

The function returns -1 if an error occurred. Otherwise, it returns an integer representing the newly-assigned descriptor."
	^ self call: #( int socket (int domain, int type, int protocol) ) failCode: -1
]

{ #category : #'TCP API' }
NBOceanLibrary >> tcpReceiveFrom: aSocket [
	self
		readFrom: aSocket socketId
		buffer: self alienDataBuffer
		ofSize: self alienDataBufferSize
		result: self alienResult.
	^ self receivedString
]

{ #category : #'TCP API' }
NBOceanLibrary >> tcpSendData: data to: aSocket [

	^ self send: data offset: 1 length: data byteSize to: aSocket 
]
