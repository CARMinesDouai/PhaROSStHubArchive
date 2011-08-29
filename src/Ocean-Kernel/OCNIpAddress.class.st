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
	#name : #OCNIpAddress,
	#superclass : #Object,
	#instVars : [
		'family',
		'ip',
		'port'
	],
	#category : #'Ocean-Kernel'
}

{ #category : #constants }
OCNIpAddress class >> afInetFamily [
	^#AfInet
]

{ #category : #'instance creation' }
OCNIpAddress class >> newFromString: aStringIpAddress [
	self subclassResponsibility 
]

{ #category : #testing }
OCNIpAddress >> = anIpAddress [
	^ self ip = anIpAddress ip 
		and: [ self family = anIpAddress family  
			and: [ self port = anIpAddress port ]]
]

{ #category : #constants }
OCNIpAddress >> afInetFamily [
	^self class afInetFamily
]

{ #category : #accessing }
OCNIpAddress >> family [
	^ family
]

{ #category : #accessing }
OCNIpAddress >> family: anObject [
	family := anObject
]

{ #category : #testing }
OCNIpAddress >> hash [
	^ (self ip hash xor: self family hash) xor: self port hash
]

{ #category : #accessing }
OCNIpAddress >> ip [
	^ ip
]

{ #category : #accessing }
OCNIpAddress >> ip: anObject [
	ip := anObject
]

{ #category : #printing }
OCNIpAddress >> ipString [
	self subclassResponsibility 
]

{ #category : #testing }
OCNIpAddress >> isIpv4 [

	^false
]

{ #category : #testing }
OCNIpAddress >> isIpv6 [

	^false
]

{ #category : #testing }
OCNIpAddress >> isOfAfInetFamily [
	^ self family = self afInetFamily
]

{ #category : #accessing }
OCNIpAddress >> port [
	^ port
]

{ #category : #accessing }
OCNIpAddress >> port: anObject [
	port := anObject
]

{ #category : #printing }
OCNIpAddress >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: '(', self ipString, ')'
]
