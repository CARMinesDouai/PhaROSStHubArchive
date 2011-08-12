Class {
	#name : #NBAddrInfo,
	#superclass : #NBExternalStructure,
	#type : #bytes,
	#pools : [
		'NBOceanLibraryConstants'
	],
	#category : #'Ocean-LibraryNativeBoost'
}

{ #category : #'as yet unclassified' }
NBAddrInfo class >> externalTypeAlias: aName [
	^ NBOceanLibrary externalTypeAlias: aName

]

{ #category : #'as yet unclassified' }
NBAddrInfo class >> fieldsDesc [ 
	^ #(
	int ai_flags;		" input flags "
	int ai_family;	" protocol family for socket "
	int ai_socktype;	" socket type "
	int ai_protocol;		" protocol for socket "
	socklen_t ai_addrlen;	" length of socket-address "

	NBExternalAddress ai_canonname;	"char *, canonical name for service location"
	NBExternalAddress ai_addr; "sockaddr* ,  socket-address for socket"
	NBExternalAddress ai_next;	" struct addrinfo * , pointer to next in list"
	)
]
