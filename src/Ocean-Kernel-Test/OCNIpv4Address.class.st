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
	#name : #OCNIpv4Address,
	#superclass : #OCNIpAddress,
	#category : #'Ocean-Kernel'
}

{ #category : #'instance creation' }
OCNIpv4Address class >> loopbackAddressWithPort: aPortNumber [
	^ self new
		family: self afInetFamily;
		ip: #[127 0 0 1]; 
		port: aPortNumber ;
		yourself
]

{ #category : #'instance creation' }
OCNIpv4Address class >> newFromString: aStringIpAddress [
	self  notYetImplemented
]

{ #category : #printing }
OCNIpv4Address >> ipString [
	| stream |
	
	stream := (String new: 15) writeStream.
	
	"self>>ip returns a byteArray"
	self ip do: [ :n | stream nextPutAll:  n asString ] separatedBy: [ stream nextPut: $. ].
	
	^stream contents
]

{ #category : #testing }
OCNIpv4Address >> isIpv4 [

	^true
]
