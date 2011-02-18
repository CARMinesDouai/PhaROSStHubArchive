"
struct sockaddr { // used by connect
    unsigned short    sa_family;    // address family, AF_xxx
    char              sa_data[14];  // 14 bytes of protocol address
}; 

struct sockaddr_in {
    short            sin_family;   // 2 e.g. AF_INET, AF_INET6
    unsigned short   sin_port;     // 2 e.g. htons(3490)
    struct in_addr   sin_addr;     // 4 see struct in_addr, below
    char             sin_zero[8];  // 8 zero this if you want to
};

struct in_addr {
    unsigned long s_addr;          // load with inet_pton()
};

"
Class {
	#name : #OCNPosixAlienBasedSockAddrIn,
	#superclass : #Alien,
	#type : #bytes,
	#category : #'Ocean-Libraries-Posix'
}

{ #category : #'instance creation' }
OCNPosixAlienBasedSockAddrIn class >> dataSize [
	^16
]

{ #category : #accessing }
OCNPosixAlienBasedSockAddrIn >> sinAddr [
	^self unsignedLongAt: 5
]

{ #category : #accessing }
OCNPosixAlienBasedSockAddrIn >> sinAddr: aByteArray [
	| byteIndex |
	byteIndex := 5.
	aByteArray do: [:byte|
		self unsignedByteAt: byteIndex put: byte.
		byteIndex := byteIndex + 1].

]

{ #category : #accessing }
OCNPosixAlienBasedSockAddrIn >> sinFamily [
	^self signedShortAt: 1
]

{ #category : #accessing }
OCNPosixAlienBasedSockAddrIn >> sinFamily: aByteArray [
	"really strange that htons is required here since it does not in C"

	self signedShortAt: 1 put: aByteArray
]

{ #category : #accessing }
OCNPosixAlienBasedSockAddrIn >> sinPort [
	^self unsignedShortAt: 3
]

{ #category : #accessing }
OCNPosixAlienBasedSockAddrIn >> sinPort: aByteArray [
	self unsignedShortAt: 3 put: aByteArray
]
