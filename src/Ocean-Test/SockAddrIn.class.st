"
struct sockaddr_in {
    short            sin_family;   // e.g. AF_INET, AF_INET6
    unsigned short   sin_port;     // e.g. htons(3490)
    struct in_addr   sin_addr;     // see struct in_addr, below
    char             sin_zero[8];  // zero this if you want to
};

struct in_addr {
    unsigned long s_addr;          // load with inet_pton()
};

"
Class {
	#name : #SockAddrIn,
	#superclass : #Alien,
	#type : #bytes,
	#category : #'Ocean-Kernel'
}

{ #category : #'instance creation' }
SockAddrIn class >> dataSize [
	^16
]

{ #category : #accessing }
SockAddrIn >> sinAddr [
	^self unsignedLongAt: 5
]

{ #category : #accessing }
SockAddrIn >> sinAddr: aByteArray [
	| byteIndex |
	byteIndex := 5.
	aByteArray do: [:byte|
		self unsignedByteAt: byteIndex put: byte.
		byteIndex := byteIndex + 1].

]

{ #category : #accessing }
SockAddrIn >> sinFamily [
	^self signedShortAt: 1
]

{ #category : #accessing }
SockAddrIn >> sinFamily: newFamily [
	self signedShortAt:1 put: newFamily
]

{ #category : #accessing }
SockAddrIn >> sinPort [
	^self unsignedShortAt: 3
]

{ #category : #accessing }
SockAddrIn >> sinPort: newPort [
	self unsignedShortAt: 3 put: newPort 
]
