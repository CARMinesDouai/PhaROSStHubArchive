"
SocketStream provides a Stream interface to Sockets decoupling protocol and other clients from the concrete Socket implementation and idiosyncrasies.

The implementation is based on Bolot Kerimbaev's original version in Comanche.

"
Class {
	#name : #SocketStream,
	#superclass : #Stream,
	#instVars : [
		'socket',
		'inStream',
		'outStream',
		'timeout',
		'autoFlush',
		'buffered',
		'bufferSize'
	],
	#category : #'Network-Kernel'
}

{ #category : #example }
SocketStream class >> finger: userName [
	"SocketStream finger: 'stp'"

	| addr s |
	addr _ NetNameResolver promptUserForHostAddress.
	s _ SocketStream openConnectionToHost: addr port: 79.  "finger port number"
	Transcript show: '---------- Connecting ----------'; cr.
	s sendCommand: userName.
	Transcript show: s getLine.
	s close.
	Transcript show: '---------- Connection Closed ----------'; cr; endEntry.

]

{ #category : #'instance creation' }
SocketStream class >> on: socket [
	"create a socket stream on a server socket"
	^self basicNew initialize socket: socket
]

{ #category : #'instance creation' }
SocketStream class >> openConnectionToHost: hostIP port: portNumber [
	| socket |
	socket _ Socket new.
	socket connectTo: hostIP port: portNumber.
	^self on: socket
]

{ #category : #'instance creation' }
SocketStream class >> openConnectionToHostNamed: hostName port: portNumber [
	| hostIP |
	hostIP _ NetNameResolver addressForName: hostName timeout: 20.
	^self openConnectionToHost: hostIP port: portNumber
]

{ #category : #testing }
SocketStream >> atEnd [
	^self isConnected not
		and: [self isDataAvailable not]
]

{ #category : #accessing }
SocketStream >> autoFlush [
	^autoFlush
]

{ #category : #accessing }
SocketStream >> autoFlush: aBoolean [
	autoFlush := aBoolean
]

{ #category : #accessing }
SocketStream >> bufferSize [
	bufferSize ifNil: [bufferSize := 2000].
	^bufferSize
]

{ #category : #accessing }
SocketStream >> bufferSize: anInt [
	bufferSize := anInt
]

{ #category : #accessing }
SocketStream >> buffered [
	^buffered
]

{ #category : #accessing }
SocketStream >> buffered: aBoolean [
	buffered := aBoolean
]

{ #category : #private }
SocketStream >> checkFlush [
	self buffered
		ifTrue: [self autoFlush
			ifTrue: [self outStream position > self bufferSize
				ifTrue: [self flush]]]
		ifFalse: [self flush]
]

{ #category : #'initialize-release' }
SocketStream >> close [
	self flush.
	self socket closeAndDestroy: 30
]

{ #category : #'stream out' }
SocketStream >> cr [
	self nextPutAll: String cr
]

{ #category : #'stream out' }
SocketStream >> crlf [
	self nextPutAll: String crlf
]

{ #category : #private }
SocketStream >> flush [
	self isOtherEndConnected
		ifTrue: [self socket sendData: self outStream contents].
	self resetOutStream
]

{ #category : #private }
SocketStream >> inStream [
	inStream ifNil: [inStream _ ReadStream on: ''].
	^inStream
]

{ #category : #'initialize-release' }
SocketStream >> initialize [
	buffered := true.
	autoFlush := true
]

{ #category : #testing }
SocketStream >> isConnected [
	^self socket isConnected
]

{ #category : #testing }
SocketStream >> isDataAvailable [
	self inStream atEnd
		ifFalse: [^true].
	self socket dataAvailable
		ifTrue: [self receiveDataIfAvailable].
	^self socket dataAvailable
]

{ #category : #testing }
SocketStream >> isOtherEndConnected [
	^self socket isOtherEndClosed not
]

{ #category : #'stream in' }
SocketStream >> next [
	self atEnd ifTrue: [^nil].
	self inStream atEnd ifTrue: 
		[self receiveData.
		self atEnd ifTrue: [^nil]].
	^self inStream next
]

{ #category : #'stream in' }
SocketStream >> next: anInteger [
	"Answer anInteger bytes of data."
	[self atEnd not and: [self inStream size - self inStream position < anInteger]]
		whileTrue: [self receiveData].
	^self inStream next: anInteger
]

{ #category : #'stream in' }
SocketStream >> nextLine [
	^self nextLineCrLf
]

{ #category : #'stream in' }
SocketStream >> nextLineCrLf [
	| nextLine |
	nextLine _ self upToAll: String crlf.
	^nextLine
]

{ #category : #'stream in' }
SocketStream >> nextLineLf [
	| nextLine |
	nextLine _ self upToAll: String lf.
	^nextLine
]

{ #category : #'stream out' }
SocketStream >> nextPut: char [
	self outStream nextPut: char.
	self checkFlush
]

{ #category : #'stream out' }
SocketStream >> nextPutAll: string [
	self outStream nextPutAll: string.
	self checkFlush
]

{ #category : #accessing }
SocketStream >> noTimeout [
	timeout := 0
]

{ #category : #private }
SocketStream >> outStream [
	outStream ifNil: [outStream _ WriteStream on: (String new: self bufferSize)].
	^outStream
]

{ #category : #'stream in' }
SocketStream >> peekFor: aCharacter [
	self atEnd ifTrue: [^false].
	self inStream atEnd ifTrue: 
		[self receiveData.
		self atEnd ifTrue: [^false]].
	^self inStream peekFor: aCharacter
]

{ #category : #'stream in' }
SocketStream >> peekForAll: aString [
	"<Boolean> Answer whether or not the next string of characters in the receiver
	matches aString.  If a match is made, advance over that string in the receiver and
	answer true.  If no match, then leave the receiver alone and answer false."

	| start tmp |
	[self atEnd not and: [self inStream size - self inStream position < aString size]]
		whileTrue: [self receiveData].
	(self inStream size - self inStream position) >= aString size ifFalse: [^false].
	start := self inStream position + 1.
	tmp := self inStream contents 
		copyFrom: start
		to: (start + aString size - 1).
	tmp = aString ifFalse: [^false].
	self next: aString size.
	^true

]

{ #category : #private }
SocketStream >> pushBack: aString [
	inStream _ ReadStream on: (aString , self inStream contents)
]

{ #category : #private }
SocketStream >> receiveData [
	| buffer bytesRead |

	buffer _ String new: self bufferSize.

	bytesRead := self shouldTimeout
		ifTrue: [self socket receiveDataTimeout: self timeout into: buffer]
		ifFalse: [self socket receiveDataInto: buffer].
	bytesRead > 0
		ifTrue: [
			inStream := ReadStream on: (self inStream upToEnd , (buffer copyFrom: 1 to: bytesRead))]
]

{ #category : #private }
SocketStream >> receiveDataIfAvailable [
	"Only used to check if after dataAvailable on the socket is true that there really are data.
	See also isDataAvailable"
	| buffer bytesRead |

	buffer _ String new: 1.

	bytesRead :=self socket receiveSomeDataInto: buffer.
	bytesRead > 0
		ifTrue: [
			inStream := ReadStream on: (self inStream upToEnd , (buffer copyFrom: 1 to: bytesRead))]
]

{ #category : #private }
SocketStream >> resetInStream [
	inStream _ nil
]

{ #category : #private }
SocketStream >> resetOutStream [
	outStream _ nil
]

{ #category : #'stream out' }
SocketStream >> sendCommand: aString [
	self outStream
		nextPutAll: aString;
		nextPutAll: String crlf.
	self flush
]

{ #category : #testing }
SocketStream >> shouldTimeout [
	^self timeout > 0
]

{ #category : #accessing }
SocketStream >> socket [
	^socket
]

{ #category : #accessing }
SocketStream >> socket: aSocket [
	socket _ aSocket
]

{ #category : #'stream out' }
SocketStream >> space [
	self nextPut: Character space
]

{ #category : #accessing }
SocketStream >> timeout [
	timeout ifNil: [timeout := Socket standardTimeout].
	^timeout
]

{ #category : #accessing }
SocketStream >> timeout: seconds [
	timeout := seconds
]

{ #category : #'stream in' }
SocketStream >> upTo: delim [ 
	| resultStream nextChar |
	resultStream _ WriteStream on: (String new: 100).

	[(nextChar _ self next) = delim]
		whileFalse: [
			nextChar
				ifNil: [^resultStream contents]
				ifNotNil: [resultStream nextPut: nextChar]].

	^resultStream contents
]

{ #category : #'stream in' }
SocketStream >> upToAll: delims [
	| searchBuffer index |
	searchBuffer _ String new.
	[searchBuffer _ searchBuffer , self inStream upToEnd.
	self resetInStream.
	index _ searchBuffer indexOfSubCollection: delims startingAt: 1.
	index = 0 and: [self atEnd not]]
		whileTrue: [self receiveData].

	index = 0 
		ifTrue: [index := 0 max: searchBuffer size]
		ifFalse:
			[self pushBack: (searchBuffer copyFrom: index + delims size to: searchBuffer size)].
	^searchBuffer copyFrom: 1 to: (0 max: index-1)
]

{ #category : #'stream in' }
SocketStream >> upToEnd [
	"Answer a subcollection from the current access position through the last element of the receiver."
	| resultStream |
	resultStream _ WriteStream on: (String new: 100).
	[resultStream nextPutAll: self inStream upToEnd.
	self atEnd not or: [self isDataAvailable]]
		whileTrue: [self receiveData].
	^resultStream contents
]
