Class {
	#name : #OCNSysSocketLibrary,
	#superclass : #AlienLibrary,
	#category : #'Ocean-Kernel'
}

{ #category : #'communication domain' }
OCNSysSocketLibrary >> AfInet [
	^2
]

{ #category : #'socket protocol' }
OCNSysSocketLibrary >> IpProtoTcp [
	^6
]

{ #category : #'communication domain' }
OCNSysSocketLibrary >> PfInet [
	^self AfInet
]

{ #category : #'shutdown constants' }
OCNSysSocketLibrary >> ShutRD [
	"Disables further receive operations on a socket"
	^0

]

{ #category : #'shutdown constants' }
OCNSysSocketLibrary >> ShutRdwr [
	"Disables further send and receive operations."
	^2

]

{ #category : #'shutdown constants' }
OCNSysSocketLibrary >> ShutWr [
	"Disables further send operations."
	^1

]

{ #category : #'socket type' }
OCNSysSocketLibrary >> SockStream [
	^1
]

{ #category : #'socket functions' }
OCNSysSocketLibrary >> bind: socketID address: socketAddress [ 
"int bind(int socket, const struct sockaddr *address,
       socklen_t address_len);
See description in comment below
"







" int bind(int socket, const struct sockaddr *address,
       socklen_t address_len);

DESCRIPTION

The bind() function shall assign a local socket address address to a socket identified by descriptor socket that has no local socket address assigned. Sockets created with the socket() function are initially unnamed; they are identified only by their address family.

The bind() function takes the following arguments:

socket
Specifies the file descriptor of the socket to be bound.
address
Points to a sockaddr structure containing the address to be bound to the socket. The length and format of the address depend on the address family of the socket.
address_len
Specifies the length of the sockaddr structure pointed to by the address argument.
The socket specified by socket may require the process to have appropriate privileges to use the bind() function.

RETURN VALUE

Upon successful completion, bind() shall return 0; otherwise, -1 shall be returned and errno set to indicate the error.

ERRORS

The bind() function shall fail if:

[EADDRINUSE]
The specified address is already in use.
[EADDRNOTAVAIL]
The specified address is not available from the local machine.
[EAFNOSUPPORT]
The specified address is not a valid address for the address family of the specified socket.
[EBADF]
The socket argument is not a valid file descriptor.
[EINVAL]
The socket is already bound to an address, and the protocol does not support binding to a new address; or the socket has been shut down.
[ENOTSOCK]
The socket argument does not refer to a socket.
[EOPNOTSUPP]
The socket type of the specified socket does not support binding to an address.
If the address family of the socket is AF_UNIX, then bind() shall fail if:

[EACCES]
A component of the path prefix denies search permission, or the requested name requires writing in a directory with a mode that denies write permission.
[EDESTADDRREQ] or [EISDIR]
The address argument is a null pointer.
[EIO]
An I/O error occurred.
[ELOOP]
A loop exists in symbolic links encountered during resolution of the pathname in address.
[ENAMETOOLONG]
A component of a pathname exceeded {NAME_MAX} characters, or an entire pathname exceeded {PATH_MAX} characters.
[ENOENT]
A component of the pathname does not name an existing file or the pathname is an empty string.
[ENOTDIR]
A component of the path prefix of the pathname in address is not a directory.
[EROFS]
The name would reside on a read-only file system.
The bind() function may fail if:

[EACCES]
The specified address is protected and the current user does not have permission to bind to it.
[EINVAL]
The address_len argument is not a valid length for the address family.
[EISCONN]
The socket is already connected.
[ELOOP]
More than {SYMLOOP_MAX} symbolic links were encountered during resolution of the pathname in address.
[ENAMETOOLONG]
Pathname resolution of a symbolic link produced an intermediate result whose length exceeds {PATH_MAX}.
[ENOBUFS]
Insufficient resources were available to complete the call.
"
]

{ #category : #'socket functions' }
OCNSysSocketLibrary >> close: socketId [

	| result |
	result := Alien new: 4.
	(self alienMethodNamed: 'close')
		primFFICallResult: result
		with: socketId.
	^ result unsignedLongAt: 1

"#include <unistd.h>
int close(int fildes);
RETURN VALUES
If successful, close() returns a value of zero. On failure, it returns a value of -1 and sets errno to one of the following:
"
]

{ #category : #'socket functions' }
OCNSysSocketLibrary >> connect: socketId serverAddress: serverSocketAddress serverAddressSize: serverSocketAddressSize [
"int connect(int socket, const struct sockaddr *address,
       socklen_t address_len);

See description in comment below
"
	| result alienMethod |
	result := Alien new: 4.
	alienMethod := self alienMethodNamed: self connectFunctionName.
	alienMethod
		primFFICallResult: result
		withArguments: {socketId. serverSocketAddress pointer. serverSocketAddressSize}.
	
	^ result signedLongAt: 1

"SYNOPSIS

#include <sys/socket.h>

int connect(int socket, const struct sockaddr *address,
       socklen_t address_len);

DESCRIPTION

The connect() function shall attempt to make a connection on a socket. The function takes the following arguments:

socket
Specifies the file descriptor associated with the socket.
address
Points to a sockaddr structure containing the peer address. The length and format of the address depend on the address family of the socket.
address_len
Specifies the length of the sockaddr structure pointed to by the address argument.
If the socket has not already been bound to a local address, connect() shall bind it to an address which, unless the socket's address family is AF_UNIX, is an unused local address.

If the initiating socket is not connection-mode, then connect() shall set the socket's peer address, and no connection is made. For SOCK_DGRAM sockets, the peer address identifies where all datagrams are sent on subsequent send() functions, and limits the remote sender for subsequent recv() functions. If address is a null address for the protocol, the socket's peer address shall be reset.

If the initiating socket is connection-mode, then connect() shall attempt to establish a connection to the address specified by the address argument. If the connection cannot be established immediately and O_NONBLOCK is not set for the file descriptor for the socket, connect() shall block for up to an unspecified timeout interval until the connection is established. If the timeout interval expires before the connection is established, connect() shall fail and the connection attempt shall be aborted. If connect() is interrupted by a signal that is caught while blocked waiting to establish a connection, connect() shall fail and set errno to [EINTR], but the connection request shall not be aborted, and the connection shall be established asynchronously.

If the connection cannot be established immediately and O_NONBLOCK is set for the file descriptor for the socket, connect() shall fail and set errno to [EINPROGRESS], but the connection request shall not be aborted, and the connection shall be established asynchronously. Subsequent calls to connect() for the same socket, before the connection is established, shall fail and set errno to [EALREADY].

When the connection has been established asynchronously, select() and poll() shall indicate that the file descriptor for the socket is ready for writing.

The socket in use may require the process to have appropriate privileges to use the connect() function.

RETURN VALUE

Upon successful completion, connect() shall return 0; otherwise, -1 shall be returned and errno set to indicate the error.

ERRORS

The connect() function shall fail if:

[EADDRNOTAVAIL]
The specified address is not available from the local machine.
[EAFNOSUPPORT]
The specified address is not a valid address for the address family of the specified socket.
[EALREADY]
A connection request is already in progress for the specified socket.
[EBADF]
The socket argument is not a valid file descriptor.
[ECONNREFUSED]
The target address was not listening for connections or refused the connection request.
[EINPROGRESS]
O_NONBLOCK is set for the file descriptor for the socket and the connection cannot be immediately established; the connection shall be established asynchronously.
[EINTR]
The attempt to establish a connection was interrupted by delivery of a signal that was caught; the connection shall be established asynchronously.
[EISCONN]
The specified socket is connection-mode and is already connected.
[ENETUNREACH]
No route to the network is present.
[ENOTSOCK]
The socket argument does not refer to a socket.
[EPROTOTYPE]
The specified address has a different type than the socket bound to the specified peer address.
[ETIMEDOUT]
The attempt to connect timed out before a connection was made.
If the address family of the socket is AF_UNIX, then connect() shall fail if:

[EIO]
An I/O error occurred while reading from or writing to the file system.
[ELOOP]
A loop exists in symbolic links encountered during resolution of the pathname in address.
[ENAMETOOLONG]
A component of a pathname exceeded {NAME_MAX} characters, or an entire pathname exceeded {PATH_MAX} characters.
[ENOENT]
A component of the pathname does not name an existing file or the pathname is an empty string.
[ENOTDIR]
A component of the path prefix of the pathname in address is not a directory.
The connect() function may fail if:

[EACCES]
Search permission is denied for a component of the path prefix; or write access to the named socket is denied.
[EADDRINUSE]
Attempt to establish a connection that uses addresses that are already in use.
[ECONNRESET]
Remote host reset the connection request.
[EHOSTUNREACH]
The destination host cannot be reached (probably because the host is down or a remote router cannot reach it).
[EINVAL]
The address_len argument is not a valid length for the address family; or invalid address family in the sockaddr structure.
[ELOOP]
More than {SYMLOOP_MAX} symbolic links were encountered during resolution of the pathname in address.
[ENAMETOOLONG]
Pathname resolution of a symbolic link produced an intermediate result whose length exceeds {PATH_MAX}.
[ENETDOWN]
The local network interface used to reach the destination is down.
[ENOBUFS]
No buffer space is available.
[EOPNOTSUPP]
The socket is listening and cannot be connected.
"
]

{ #category : #'socket functions' }
OCNSysSocketLibrary >> connectFunctionName [
	^'connect'
]

{ #category : #'byte conversions' }
OCNSysSocketLibrary >> htonl: anInt [
"uint32_t htonl(uint32_t hostlong);"

		| result |
	result := Alien new: 4.
	(self alienMethodNamed: 'htonl')
		primFFICallResult: result
		with: anInt.
	^ result unsignedLongAt: 1

]

{ #category : #'byte conversions' }
OCNSysSocketLibrary >> htons: anInt [
"host to network short
uint16_t htons(uint16_t hostshort);"

	| result |
	result := Alien new: 2.
	(self alienMethodNamed: 'htons')
		primFFICallResult: result
		with: anInt.
	^ result unsignedShortAt: 1
]

{ #category : #accessing }
OCNSysSocketLibrary >> libraryName [
	^'/System/Library/Frameworks/System.framework/System'
]

{ #category : #'byte conversions' }
OCNSysSocketLibrary >> ntohl: anInt [
"uint32_t ntohl(uint32_t netlong);"

	| result |
	result := Alien new: 4.
	(self alienMethodNamed: 'ntohl')
		primFFICallResult: result
		with: anInt.
	^ result unsignedLongAt: 1
]

{ #category : #'byte conversions' }
OCNSysSocketLibrary >> ntohs: anInt [
"uint16_t ntohs(uint16_t netshort);"

	| result |
	result := Alien new: 2.
	(self alienMethodNamed: 'ntohs')
		primFFICallResult: result
		with: anInt.
	^ result unsignedShortAt: 1
]

{ #category : #'socket functions' }
OCNSysSocketLibrary >> sendTo: socketId buffer: buffer ofSize: size withFlag: flag [
"ssize_t send(int socket, const void *buffer, size_t length, int flags);"

	| result alienMethod |
	result := Alien new: 4.
	alienMethod := self alienMethodNamed: 'send'.
	alienMethod
		primFFICallResult: result
		withArguments: {socketId. buffer pointer. size. flag}.
	
	^ result signedLongAt: 1
]

{ #category : #'socket functions' }
OCNSysSocketLibrary >> shutdown: socketId usingMethod: aFlag [

	| result |
	result := Alien new: 4.
	(self alienMethodNamed: 'shutdown')
		primFFICallResult: result
		with: socketId
		with: aFlag.
	^ result unsignedLongAt: 1

"#include <sys/socket.h>

int shutdown(int socket, int how);

DESCRIPTION

socket
Specifies the file descriptor of the socket.
how
Specifies the type of shutdown. The values are as follows:
#defin SHUT_RD 0 
Disables further receive operations.
#define SHUT_WR 1
Disables further send operations.
#define SHUT_RDWR 2
Disables further send and receive operations.
The shutdown() function disables subsequent send and/or receive operations on a socket, depending on the value of the how argument.

RETURN VALUE

Upon successful completion, shutdown() returns 0. Otherwise, -1 is returned and errno is set to indicate the error.
"
]

{ #category : #'socket functions' }
OCNSysSocketLibrary >> socketDomain: communicationDomain type: socketType protocol: socketProtocol [
"int socket(int domain, int type, int protocol);
See description in comment below
"
	| result alienMethod |
	result := Alien new: 4.
	alienMethod := self alienMethodNamed:'socket'.
	alienMethod
		primFFICallResult: result
		withArguments: {communicationDomain. socketType. socketProtocol}.
	^ result

"#include <sys/socket.h>

int socket(int domain, int type, int protocol);

DESCRIPTION

The socket() function shall create an unbound socket in a communications domain, and return a file descriptor that can be used in later function calls that operate on sockets.

The socket() function takes the following arguments:

domain
Specifies the communications domain in which a socket is to be created.
type
Specifies the type of socket to be created.
protocol
Specifies a particular protocol to be used with the socket. Specifying a protocol of 0 causes socket() to use an unspecified default protocol appropriate for the requested socket type.
The domain argument specifies the address family used in the communications domain. The address families supported by the system are implementation-defined.

Symbolic constants that can be used for the domain argument are defined in the <sys/socket.h> header.

The type argument specifies the socket type, which determines the semantics of communication over the socket. The following socket types are defined; implementations may specify additional socket types:

SOCK_STREAM
Provides sequenced, reliable, bidirectional, connection-mode byte streams, and may provide a transmission mechanism for out-of-band data.
SOCK_DGRAM
Provides datagrams, which are connectionless-mode, unreliable messages of fixed maximum length.
SOCK_SEQPACKET
Provides sequenced, reliable, bidirectional, connection-mode transmission paths for records. A record can be sent using one or more output operations and received using one or more input operations, but a single operation never transfers part of more than one record. Record boundaries are visible to the receiver via the MSG_EOR flag.
If the protocol argument is non-zero, it shall specify a protocol that is supported by the address family. If the protocol argument is zero, the default protocol for this address family and type shall be used. The protocols supported by the system are implementation-defined.

The process may need to have appropriate privileges to use the socket() function or to create some sockets.

RETURN VALUE

Upon successful completion, socket() shall return a non-negative integer, the socket file descriptor. Otherwise, a value of -1 shall be returned and errno set to indicate the error.

ERRORS

The socket() function shall fail if:

[EAFNOSUPPORT]
The implementation does not support the specified address family.
[EMFILE]
No more file descriptors are available for this process.
[ENFILE]
No more file descriptors are available for the system.
[EPROTONOSUPPORT]
The protocol is not supported by the address family, or the protocol is not supported by the implementation.
[EPROTOTYPE]
The socket type is not supported by the protocol.
The socket() function may fail if:

[EACCES]
The process does not have appropriate privileges.
[ENOBUFS]
Insufficient resources were available in the system to perform the operation.
[ENOMEM]
Insufficient memory was available to fulfill the request.
"
]
