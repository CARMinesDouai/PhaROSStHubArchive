Class {
	#name : #NBSockAddrIn,
	#superclass : #NBExternalStructure,
	#type : #bytes,
	#pools : [
		'NBOceanLibraryConstants'
	],
	#category : #'Ocean-LibraryNativeBoost'
}

{ #category : #'as yet unclassified' }
NBSockAddrIn class >> fieldsDesc [

	^ #(
	short sin_family; " 2 e.g. AF_INET, AF_INET6 "
	ushort sin_port;  " 2 e.g. htons(3490) "
	ulong sin_addr;    " 4 see struct in_addr, below "
	
	ulong unused1; "8 zero this if you want to"
	ulong unused2;	
 	)
]

{ #category : #accessing }
NBSockAddrIn >> setAnyAddress [
	self sin_addr: INADDR_ANY 
]

{ #category : #accessing }
NBSockAddrIn >> setLoopbackAddress [
	self sin_addr: INADDR_LOOPBACK 
]
