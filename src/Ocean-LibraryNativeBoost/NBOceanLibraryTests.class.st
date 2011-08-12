Class {
	#name : #NBOceanLibraryTests,
	#superclass : #TestCase,
	#instVars : [
		'library'
	],
	#pools : [
		'NBOceanLibraryConstants'
	],
	#category : #'Ocean-LibraryNativeBoost'
}

{ #category : #'as yet unclassified' }
NBOceanLibraryTests >> library [ 
	^ library ifNil: [ self setUp. library  ]
]

{ #category : #'as yet unclassified' }
NBOceanLibraryTests >> setUp [ 
	library := NBOceanLibrary new.
]

{ #category : #'as yet unclassified' }
NBOceanLibraryTests >> testConnectSocket [
	| socket addr |

	[ 
	socket := self library newTcpSocket.

	"connect using invalid address"
	addr := self library ipv4Address: '0.0.0.0' port: 1234.
	
	self should: [ socket connectTo: addr. ] raise: OCNSocketOperationFailureError
	
"     The connect() system call will fail if:

     [EACCES]           The destination address is a broadcast address and the socket option SO_BROADCAST is not set.

     [EADDRINUSE]       The address is already in use.

     [EADDRNOTAVAIL]    The specified address is not available on this machine.

     [EAFNOSUPPORT]     Addresses in the specified address family cannot be used with this socket.

     [EALREADY]         The socket is non-blocking and a previous connection attempt has not yet been completed.

     [EBADF]            socket is not a valid descriptor.

     [ECONNREFUSED]     The attempt to connect was ignored (because the target is not listening for connections) or explicitly rejected.

     [EFAULT]           The address parameter specifies an area outside the process address space.

     [EHOSTUNREACH]     The target host cannot be reached (e.g., down, disconnected).

     [EINPROGRESS]      The socket is non-blocking and the connection cannot be completed immediately.  It is possible to select(2) for completion by selecting the socket for writing.

     [EINTR]            Its execution was interrupted by a signal.

     [EINVAL]           An invalid argument was detected (e.g., address_len is not valid for the address family, the specified address family is invalid).

     [EISCONN]          The socket is already connected.

     [ENETDOWN]         The local network interface is not functioning.

     [ENETUNREACH]      The network isn't reachable from this host.

     [ENOBUFS]          The system call was unable to allocate a needed memory buffer.

     [ENOTSOCK]         socket is not a file descriptor for a socket.

     [EOPNOTSUPP]       Because socket is listening, no connection is allowed.

     [EPROTOTYPE]       address has a different type than the socket that is bound to the specified peer address.

     [ETIMEDOUT]        Connection establishment timed out without establishing a connection.

     [ECONNRESET]       Remote host reset the connection request.
"	

	] ensure: [ socket destroy ] 

]

{ #category : #'as yet unclassified' }
NBOceanLibraryTests >> testCreateSocket [

	| socket |
	
	self shouldnt: [ 
		socket := self library newTcpSocket.
		socket destroy.
	] raise: OCNSocketOperationFailureError.
	
]

{ #category : #'as yet unclassified' }
NBOceanLibraryTests >> testInet_ntoa [

	| socket addr after |
	
	addr := self library inet_aton: '127.0.0.1'.
	after := self library inet_ntoa: addr.
	
	self assert: after = '127.0.0.1'
]
