"
// IPv4 AF_INET sockets:

struct sockaddr_in {
    short            sin_family;   // e.g. AF_INET, AF_INET6
    unsigned short   sin_port;     // e.g. htons(3490)
    struct in_addr   sin_addr;     // see struct in_addr, below
    char             sin_zero[8];  // zero this if you want to
};

struct in_addr {
    unsigned long s_addr;          // load with inet_pton()
};


// IPv6 AF_INET6 sockets:

struct sockaddr_in6 {
    u_int16_t       sin6_family;   // address family, AF_INET6
    u_int16_t       sin6_port;     // port number, Network Byte Order
    u_int32_t       sin6_flowinfo; // IPv6 flow information
    struct in6_addr sin6_addr;     // IPv6 address
    u_int32_t       sin6_scope_id; // Scope ID
};

struct in6_addr {
    unsigned char   s6_addr[16];   // load with inet_pton()
};

"
Class {
	#name : #OCNIPV4SocketAddress,
	#superclass : #OCNSocketAddress,
	#instVars : [
		'family',
		'ip',
		'port'
	],
	#category : #'Ocean-Kernel'
}

{ #category : #accessing }
OCNIPV4SocketAddress >> family [
	^ family
]

{ #category : #accessing }
OCNIPV4SocketAddress >> family: anObject [
	family := anObject
]

{ #category : #accessing }
OCNIPV4SocketAddress >> ip [
	^ ip
]

{ #category : #accessing }
OCNIPV4SocketAddress >> ip: anObject [
	ip := anObject
]

{ #category : #accessing }
OCNIPV4SocketAddress >> port [
	^ port
]

{ #category : #accessing }
OCNIPV4SocketAddress >> port: anObject [
	port := anObject
]

{ #category : #'primitive address' }
OCNIPV4SocketAddress >> primitiveAddress [
	| primitiveAddress |
	primitiveAddress := OCNSockAddrIn newC.
	primitiveAddress sinFamily: self family.
	primitiveAddress sinPort: self port.
	primitiveAddress sinAddr: self ip.
	^primitiveAddress
]

{ #category : #'primitive address' }
OCNIPV4SocketAddress >> primitiveAddressSize [
	^OCNSockAddrIn dataSize 
]
