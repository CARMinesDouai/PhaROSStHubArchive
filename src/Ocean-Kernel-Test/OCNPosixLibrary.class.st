Class {
	#name : #OCNPosixLibrary,
	#superclass : #AlienLibrary,
	#instVars : [
		'alienResult',
		'alienDataBuffer'
	],
	#pools : [
		'OCNSysSocketConstants'
	],
	#classInstVars : [
		'default'
	],
	#category : #'Ocean-Libraries-Posix'
}

{ #category : #'instance creation' }
OCNPosixLibrary class >> proxy [
	^self new
]

{ #category : #'socket functions' }
OCNPosixLibrary >> accept: socketId clientSocketAddress: address clientSocketAddressSize: addressSize [

"int accept (int socket, struct sockaddr *address,socklen_t *address_len); "
	
	| result alienMethod |
	result := Alien new: 4.
	alienMethod := self alienMethodNamed: self acceptFunctionName.
	alienMethod
		primFFICallResult: result
		withArguments: {socketId. address pointer. addressSize}.
	
	^ result signedLongAt: 1

"#include <sys/socket.h>

int accept (int socket, struct sockaddr *address,
                                 socklen_t *address_len);

DESCRIPTION

The accept() function extracts the first connection on the queue of pending connections, creates a new socket with the same socket type protocol and address family as the specified socket, and allocates a new file descriptor for that socket.
The function takes the following arguments:

socket
Specifies a socket that was created with socket(), has been bound to an address with bind(), and has issued a successful call to listen().
address
Either a null pointer, or a pointer to a sockaddr structure where the address of the connecting socket will be returned.
address_len
Points to a socklen_t which on input specifies the length of the supplied sockaddr structure, and on output specifies the length of the stored address.
If address is not a null pointer, the address of the peer for the accepted connection is stored in the sockaddr structure pointed to by address, and the length of this address is stored in the object pointed to by address_len.

If the actual length of the address is greater than the length of the supplied sockaddr structure, the stored address will be truncated.

If the protocol permits connections by unbound clients, and the peer is not bound, then the value stored in the object pointed to by address is unspecified.

If the listen queue is empty of connection requests and O_NONBLOCK is not set on the file descriptor for the socket, accept() will block until a connection is present. If the listen() queue is empty of connection requests and O_NONBLOCK is set on the file descriptor for the socket, accept() will fail and set errno to [EAGAIN] or [EWOULDBLOCK].

The accepted socket cannot itself accept more connections. The original socket remains open and can accept more connections.

RETURN VALUE

Upon successful completion, accept() returns the nonnegative file descriptor of the accepted socket. Otherwise, -1 is returned and errno is set to indicate the error.
ERRORS

The accept() function will fail if:
[EAGAIN] or [EWOULDBLOCK]

O_NONBLOCK is set for the socket file descriptor and no connections are present to be accepted.
[EBADF]
The socket argument is not a valid file descriptor.
[ECONNABORTED]
A connection has been aborted.
[EFAULT]
The address or address_len parameter can not be accessed or written.
[EINTR]
The accept() function was interrupted by a signal that was caught before a valid connection arrived.
[EINVAL]
The socket is not accepting connections.
[EMFILE]
{OPEN_MAX} file descriptors are currently open in the calling process.
[ENFILE]
The maximum number of file descriptors in the system are already open.
[ENOTSOCK]
The socket argument does not refer to a socket.
[EOPNOTSUPP]
The socket type of the specified socket does not support accepting connections.
The accept() function may fail if:

[ENOBUFS]
No buffer space is available.
[ENOMEM]
There was insufficient memory available to complete the operation.
[ENOSR]
There was insufficient STREAMS resources available to complete the operation.
[EPROTO]
A protocol error has occurred; for example, the STREAMS protocol stack has not been initialised.
"
]

{ #category : #'function names' }
OCNPosixLibrary >> acceptFunctionName [
	^'accept'
]

{ #category : #accessing }
OCNPosixLibrary >> alienDataBuffer [
	^ alienDataBuffer
]

{ #category : #accessing }
OCNPosixLibrary >> alienDataBuffer: anObject [
	alienDataBuffer := anObject
]

{ #category : #'initialize-release' }
OCNPosixLibrary >> alienDataBufferOfSize: bytesCount [
	self alienDataBuffer: (Alien newGC: bytesCount + 1).
	
]

{ #category : #accessing }
OCNPosixLibrary >> alienDataBufferSize [
	^self alienDataBuffer 
		ifNil: [self defaultDataBufferSize] 
		ifNotNil: [self alienDataBuffer dataSize - 1]
]

{ #category : #accessing }
OCNPosixLibrary >> alienResult [
	^ alienResult
]

{ #category : #accessing }
OCNPosixLibrary >> alienResult: anObject [
	alienResult := anObject
]

{ #category : #'socket functions' }
OCNPosixLibrary >> bind: socketId address: socketAddress size: socketAddressSize [
"
int bind(int socket, const struct sockaddr *address, socklen_t address_len);
See description in comment below
"

	| alienMethod |
	alienMethod := self alienMethodNamed: self bindFunctionName.
	alienMethod
		primFFICallResult: self alienResult
		withArguments: {socketId. socketAddress pointer. socketAddressSize}.
	
	^ self latestPosixResult

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

{ #category : #'TCP API' }
OCNPosixLibrary >> bind: socketId toIpv4Address: anAddress [
	"anAddress represents the local address of the network interface to use"
	
	| result primitiveAddress |
	primitiveAddress := self posixIPV4AddressFrom: anAddress.
	[result := self bind: socketId address: primitiveAddress size: primitiveAddress dataSize] 
	ensure: [primitiveAddress free].
	result = -1 ifTrue: [OCNSocketOperationFailureError signal: 'Bind failure']
]

{ #category : #'function names' }
OCNPosixLibrary >> bindFunctionName [
	^'bind'
]

{ #category : #'TCP API' }
OCNPosixLibrary >> close: socketId [
	(self alienMethodNamed: self closeFunctionName) primFFICallResult: self alienResult with: socketId.
	self latestPosixResult 	= -1  ifTrue: [OCNSocketOperationFailureError signal: 'Close failed']
		
"#include <unistd.h>
int close(int fildes);
RETURN VALUES
If successful, close() returns a value of zero. On failure, it returns a value of -1 and sets errno to one of the following:
"
]

{ #category : #'function names' }
OCNPosixLibrary >> closeFunctionName [
	^ 'close'
]

{ #category : #'socket functions' }
OCNPosixLibrary >> connect: socketId serverAddress: serverSocketAddress serverAddressSize: serverSocketAddressSize [
"int connect(int socket, const struct sockaddr *address,
       socklen_t address_len);

See description in comment below
"
	| alienMethod |
	alienMethod := self alienMethodNamed: self connectFunctionName.
	alienMethod
		primFFICallResult: self alienResult
		withArguments: {socketId. serverSocketAddress pointer. serverSocketAddressSize}.

	^ self latestPosixResult

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

{ #category : #'TCP API' }
OCNPosixLibrary >> connect: socketId toServerWithIpv4Address: serverAddress [
	| result primitiveAddress |
	primitiveAddress := self posixIPV4AddressFrom: serverAddress.
	result := self connect: socketId
		serverAddress: primitiveAddress
		serverAddressSize: primitiveAddress dataSize.
	result = -1  ifTrue: [OCNSocketOperationFailureError signal: 'Connection failure']
]

{ #category : #'function names' }
OCNPosixLibrary >> connectFunctionName [
	^'connect'
]

{ #category : #'TCP API' }
OCNPosixLibrary >> createTcpSocketDescriptorId [

  	| result |
	self 
		socketDomain: PF_INET
		type: SOCK_STREAM
		protocol: IPPROTO_TCP.
	
	self latestPosixResult = -1  ifTrue: [OCNSocketOperationFailureError signal: 'Socket creation failure'].
	
	^ self latestPosixResult 
]

{ #category : #accessing }
OCNPosixLibrary >> defaultDataBufferSize [
	^2000
]

{ #category : #'byte conversions' }
OCNPosixLibrary >> htonl: anInt [
"uint32_t htonl(uint32_t hostlong);"

		| result |
	result := Alien new: 4.
	(self alienMethodNamed: 'htonl')
		primFFICallResult: result
		with: anInt.
	^ result unsignedLongAt: 1

]

{ #category : #'byte conversions' }
OCNPosixLibrary >> htons: anInt [
"host to network short
uint16_t htons(uint16_t hostshort);"

	| result |
	result := Alien new: 2.
	(self alienMethodNamed: 'htons')
		primFFICallResult: result
		with: anInt.
	^ result unsignedShortAt: 1
]

{ #category : #'initialize-release' }
OCNPosixLibrary >> initialize [
	super initialize.
	self alienDataBuffer: (Alien newGC: self defaultDataBufferSize).
	self alienResult: (Alien newGC: 4).

]

{ #category : #accessing }
OCNPosixLibrary >> latestPosixResult [
	^ self alienResult signedLongAt: 1
]

{ #category : #'socket functions' }
OCNPosixLibrary >> listen: socketId backlog: backlog [
"int listen(int socket, int backlog);
See description in comment below
"

	| result alienMethod |
	result := Alien new: 4.
	alienMethod := self alienMethodNamed: self listenFunctionName.
	alienMethod
		primFFICallResult: result
		withArguments: {socketId. backlog}.
	
	^ result signedLongAt: 1

"#include <sys/socket.h>

int listen(int socket, int backlog);

DESCRIPTION

The listen() function marks a connection-mode socket, specified by the socket argument, as accepting connections, and limits the number of outstanding connections in the socket's listen queue to the value specified by the backlog argument.
If listen() is called with a backlog argument value that is less than 0, the function sets the length of the socket's listen queue to 0.

The implementation may include incomplete connections in the queue subject to the queue limit. The implementation may also increase the specified queue limit internally if it includes such incomplete connections in the queue subject to this limit.

Implementations may limit the length of the socket's listen queue. If backlog exceeds the implementation-dependent maximum queue length, the length of the socket's listen queue will be set to the maximum supported value.

The socket in use may require the process to have appropriate privileges to use the listen() function.

RETURN VALUE

Upon successful completions, listen() returns 0. Otherwise, -1 is returned and errno is set to indicate the error.
ERRORS

The listen() function will fail if:
[EBADF]
The socket argument is not a valid file descriptor.
[EDESTADDRREQ]
The socket is not bound to a local address, and the protocol does not support listening on an unbound socket.
[EINVAL]
The socket is already connected.
[ENOTSOCK]
The socket argument does not refer to a socket.
[EOPNOTSUPP]
The socket protocol does not support listen().
The listen() function may fail if:

[EACCES]
The calling process does not have the appropriate privileges.
[EINVAL]
The socket has been shut down.
[ENOBUFS]
Insufficient resources are available in the system to complete the call.
"
]

{ #category : #'function names' }
OCNPosixLibrary >> listenFunctionName [
	^ 'listen'
]

{ #category : #'byte conversions' }
OCNPosixLibrary >> ntohl: anInt [
"uint32_t ntohl(uint32_t netlong);"

	| result |
	result := Alien new: 4.
	(self alienMethodNamed: 'ntohl')
		primFFICallResult: result
		with: anInt.
	^ result unsignedLongAt: 1
]

{ #category : #'byte conversions' }
OCNPosixLibrary >> ntohs: anInt [
"uint16_t ntohs(uint16_t netshort);"

	| result |
	result := Alien new: 2.
	(self alienMethodNamed: 'ntohs')
		primFFICallResult: result
		with: anInt.
	^ result unsignedShortAt: 1
]

{ #category : #'socket address' }
OCNPosixLibrary >> posixIPV4AddressFrom: aSocketAddress [

	| posixAddress family |
	posixAddress := OCNPosixAlienBasedSockAddrIn newC.
	(aSocketAddress isOfAfInetFamily) 
		ifTrue: [ family := AF_INET ]
		ifFalse: [ self error: 'Only AfInet socket family are supported' ].
	posixAddress sinFamily: (self htons: family).
	posixAddress sinPort: (self htons: aSocketAddress port).
	posixAddress sinAddr: aSocketAddress ip.
	^posixAddress
]

{ #category : #'TCP API' }
OCNPosixLibrary >> readFrom: socketId [
	self
		readFrom: socketId
		buffer: self alienDataBuffer
		ofSize: self alienDataBufferSize
		result: self alienResult.
	^ self receivedString
]

{ #category : #'socket functions' }
OCNPosixLibrary >> readFrom: socketId buffer: buffer ofSize: bufferSize result: result [

	| alienMethod |
	alienMethod := self alienMethodNamed: self readFunctionName.
	alienMethod
		primFFICallResult: result
		withArguments: {socketId. buffer pointer. bufferSize}.

"#include <sys/types.h>#include <unistd.h>
ssize_t read(int fd, void *buf, size_t count);
Description

read lit jusqu'à count octets depuis le descripteur de fichier fd dans le buffer pointé par buf.
Si count vaut zéro, read renvoie zéro et n'a pas d'autres effets.

Si count est supérieur à SSIZE_MAX, le résultat est indéfini.

Valeur Renvoyée

read renvoie -1 s'il échoue, auquel cas errno contient le code d'erreur, et la position de la tête de lecture est indéfinie.
Sinon, read renvoie le nombre d'octets lus (0 en fin de fichier), et avance la tête de lecture de ce nombre. Le fait que le nombre renvoyé soit plus petit que le nombre demandé n'est pas une erreur. Ceci se produit à la fin du fichier, ou si on lit depuis un tube ou un terminal, ou encore si read a été interrompu par un signal.

Erreurs

EINTR
read a été interrompu par un signal avant d'avoir eu le temps de lire quoi que ce soit.
EAGAIN
On utilise une lecture non bloquante (attribut O_NONBLOCK du descripteur de fichier) et aucune donnée n'était disponible.
EIO
Erreur d'entrée/sortie. Ceci arrive si un processus est dans un groupe en arrière-plan et tente de lire depuis le terminal. Il reçoit un signal SIGTTIN mais il l'ignore ou le bloque. Ceci se produit également si une erreur d'entrée/sortie bas-niveau s'est produite pendant la lecture d'un disque ou d'une bande.
EISDIR
fd est un répertoire.
EBADF
fd n'est pas un descripteur valide, ou n'est pas ouvert en lecture.
EINVAL
fd corrrespond à un objet ne permettant pas la lecture.
EFAULT
buf pointe en dehors de l'espace d'adressage accessible.
D'autres erreurs peuvent se produire, suivant le type d'objet associé à fd. POSIX permet à un read interrompu par un signal de renvoyer soit le nombre d'octets lus à ce point, soit -1, et de placer errno à EINTR."
]

{ #category : #'function names' }
OCNPosixLibrary >> readFunctionName [
	^'read'
]

{ #category : #'TCP API' }
OCNPosixLibrary >> receiveFrom: socketId [
	self
		receiveFrom: self socketId
		buffer: self alienDataBuffer
		ofSize: self alienDataBufferSize
		flags: 0
		result: self alienResult.	"<--------"
	^ self receivedString
]

{ #category : #'socket functions' }
OCNPosixLibrary >> receiveFrom: socketId buffer: dataBuffer ofSize: dataBufferSize flags: flagsByte result: result [

	| alienMethod |
	alienMethod := self alienMethodNamed: self receiveFunctionName.
	alienMethod
		primFFICallResult: result
		withArguments: {socketId. dataBuffer pointer. dataBufferSize. flagsByte}.
	
"#include <sys/socket.h>

ssize_t recv(int socket, void *buffer, size_t length, int flags);

DESCRIPTION

The recv() function receives a message from a connection-mode or connectionless-mode socket. It is normally used with connected sockets because it does not permit the application to retrieve the source address of received data. The function takes the following arguments:
socket
Specifies the socket file descriptor.
buffer
Points to a buffer where the message should be stored.
length
Specifies the length in bytes of the buffer pointed to by the buffer argument.
flags
Specifies the type of message reception. Values of this argument are formed by logically OR'ing zero or more of the following values:
MSG_PEEK
Peeks at an incoming message. The data is treated as unread and the next recv() or similar function will still return this data.
MSG_OOB
Requests out-of-band data. The significance and semantics of out-of-band data are protocol-specific.
MSG_WAITALL
Requests that the function block until the full amount of data requested can be returned. The function may return a smaller amount of data if a signal is caught, if the connection is terminated, if MSG_PEEK was specified, or if an error is pending for the socket.
The recv() function returns the length of the message written to the buffer pointed to by the buffer argument. For message-based sockets such as SOCK_DGRAM and SOCK_SEQPACKET, the entire message must be read in a single operation. If a message is too long to fit in the supplied buffer, and MSG_PEEK is not set in the flags argument, the excess bytes are discarded. For stream-based sockets such as SOCK_STREAM, message boundaries are ignored. In this case, data is returned to the user as soon as it becomes available, and no data is discarded.

If the MSG_WAITALL flag is not set, data will be returned only up to the end of the first message.

If no messages are available at the socket and O_NONBLOCK is not set on the socket's file descriptor, recv() blocks until a message arrives. If no messages are available at the socket and O_NONBLOCK is set on the socket's file descriptor, recv() fails and sets errno to [EAGAIN] or [EWOULDBLOCK].

RETURN VALUE

Upon successful completion, recv() returns the length of the message in bytes. If no messages are available to be received and the peer has performed an orderly shutdown, recv() returns 0. Otherwise, -1 is returned and errno is set to indicate the error. 
ERRORS

The recv() function will fail if:
[EAGAIN] or [EWOULDBLOCK]

The socket's file descriptor is marked O_NONBLOCK and no data is waiting to be received; or MSG_OOB is set and no out-of-band data is available and either the socket's file descriptor is marked O_NONBLOCK or the socket does not support blocking to await out-of-band data.
[EBADF]
The socket argument is not a valid file descriptor.
[ECONNRESET]
A connection was forcibly closed by a peer.
[EFAULT]
The buffer parameter can not be accessed or written.
[EINTR]
The recv() function was interrupted by a signal that was caught, before any data was available.
[EINVAL]
The MSG_OOB flag is set and no out-of-band data is available.
[ENOTCONN]
A receive is attempted on a connection-mode socket that is not connected.
[ENOTSOCK]
The socket argument does not refer to a socket.
[EOPNOTSUPP]
The specified flags are not supported for this socket type or protocol.
[ETIMEDOUT]
The connection timed out during connection establishment, or due to a transmission timeout on active connection.
The recv() function may fail if:

[EIO]
An I/O error occurred while reading from or writing to the file system.
[ENOBUFS]
Insufficient resources were available in the system to perform the operation.
[ENOMEM]
Insufficient memory was available to fulfill the request.
[ENOSR]
There were insufficient STREAMS resources available for the operation to complete."
]

{ #category : #'function names' }
OCNPosixLibrary >> receiveFunctionName [
	^'recv'
]

{ #category : #accessing }
OCNPosixLibrary >> receivedString [
	| numberOfBytesReceived |
	numberOfBytesReceived := self latestPosixResult.
	numberOfBytesReceived == 0
		ifTrue: [ ^ '' ].
	^ self alienDataBuffer strcpyFrom: 1 ofSize: numberOfBytesReceived
]

{ #category : #'TCP API' }
OCNPosixLibrary >> sendData: data to: socketId [
	| sentDataSize |
	sentDataSize := data byteSize.
	sentDataSize > self alienDataBufferSize
		ifTrue: [ self alienDataBufferOfSize: sentDataSize ].
	self alienDataBuffer
		replaceFrom: 1
		to: sentDataSize
		with: data
		startingAt: 1.
	self
		sendTo: socketId
		buffer: self alienDataBuffer
		ofSize: sentDataSize
		flags: 0
		result: self alienResult.
	^ self latestPosixResult
]

{ #category : #'function names' }
OCNPosixLibrary >> sendFunctionName [
	^'send'
]

{ #category : #'socket functions' }
OCNPosixLibrary >> sendTo: socketId buffer: buffer ofSize: size flags: flagsByte result: result [
"ssize_t send(int socket, const void *buffer, size_t length, int flags);"

	|  alienMethod |
	alienMethod := self alienMethodNamed: self sendFunctionName.
	alienMethod
		primFFICallResult: result
		withArguments: {socketId. buffer pointer. size. flagsByte}.
	
	
"#include <sys/socket.h>

ssize_t send(int socket, const void *buffer, size_t length, int flags);

DESCRIPTION

socket
Specifies the socket file descriptor.
buffer
Points to the buffer containing the message to send.
length
Specifies the length of the message in bytes.
flags
Specifies the type of message transmission. Values of this argument are formed by logically OR'ing zero or more of the following flags:
MSG_EOR
Terminates a record (if supported by the protocol)
MSG_OOB
Sends out-of-band data on sockets that support out-of-band communications. The significance and semantics of out-of-band data are protocol-specific.
The send() function initiates transmission of a message from the specified socket to its peer. The send() function sends a message only when the socket is connected (including when the peer of a connectionless socket has been set via connect()).

The length of the message to be sent is specified by the length argument. If the message is too long to pass through the underlying protocol, send() fails and no data is transmitted.

Successful completion of a call to send() does not guarantee delivery of the message. A return value of -1 indicates only locally-detected errors.

If space is not available at the sending socket to hold the message to be transmitted and the socket file descriptor does not have O_NONBLOCK set, send() blocks until space is available. If space is not available at the sending socket to hold the message to be transmitted and the socket file descriptor does have O_NONBLOCK set, send() will fail. The select() and poll() functions can be used to determine when it is possible to send more data.

The socket in use may require the process to have appropriate privileges to use the send() function.

RETURN VALUE

Upon successful completion, send() returns the number of bytes sent. Otherwise, -1 is returned and errno is set to indicate the error.
APPLICATION USAGE

The send() function is identical to sendto() with a null pointer dest_len argument, and to write() if no flags are used.
ERRORS

The send() function will fail if:
[EAGAIN] or [EWOULDBLOCK]

The socket's file descriptor is marked O_NONBLOCK and the requested operation would block.
[EBADF]
The socket argument is not a valid file descriptor.
[ECONNRESET]
A connection was forcibly closed by a peer.
[EDESTADDRREQ]
The socket is not connection-mode and no peer address is set.
[EFAULT]
The buffer parameter can not be accessed.
[EINTR]
A signal interrupted send() before any data was transmitted.
[EMSGSIZE]
The message is too large be sent all at once, as the socket requires.
[ENOTCONN]
The socket is not connected or otherwise has not had the peer prespecified.
[ENOTSOCK]
The socket argument does not refer to a socket.
[EOPNOTSUPP]
The socket argument is associated with a socket that does not support one or more of the values set in flags.
[EPIPE]
The socket is shut down for writing, or the socket is connection-mode and is no longer connected. In the latter case, and if the socket is of type SOCK_STREAM, the SIGPIPE signal is generated to the calling process.
The send() function may fail if:

[EACCES]
The calling process does not have the appropriate privileges.
[EIO]
An I/O error occurred while reading from or writing to the file system.
[ENETDOWN]
The local interface used to reach the destination is down.
[ENETUNREACH]
No route to the network is present.
[ENOBUFS]
Insufficient resources were available in the system to perform the operation.
[ENOSR]
There were insufficient STREAMS resources available for the operation to complete."
]

{ #category : #'socket functions' }
OCNPosixLibrary >> shutdown: socketId usingMethod: aFlag [

	(self alienMethodNamed: self shutdownFunctionName) primFFICallResult: self alienResult with: socketId with: aFlag.
	^ self latestPosixResult 
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

{ #category : #'function names' }
OCNPosixLibrary >> shutdownFunctionName [
	^ 'shutdown'
]

{ #category : #'function names' }
OCNPosixLibrary >> socketCreationFunctionName [
	^ 'socket'
]

{ #category : #'socket functions' }
OCNPosixLibrary >> socketDomain: communicationDomain type: socketType protocol: socketProtocol [
	"int socket(int domain, int type, int protocol);
See description in comment below
"

	|  alienMethod |
	alienMethod := self alienMethodNamed: self socketCreationFunctionName.
	alienMethod
		primFFICallResult: self alienResult
		withArguments:
			{communicationDomain.
			socketType.
			socketProtocol}.
	^ self latestPosixResult 
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
