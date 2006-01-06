Class {
	#name : #FastSocketStream,
	#superclass : #Object,
	#instVars : [
		'recentlyRead',
		'socket',
		'inBuffer',
		'outBuffer',
		'inNextToWrite',
		'outNextToWrite',
		'lastRead',
		'timeout',
		'autoFlush',
		'bufferSize',
		'binary',
		'shouldSignal'
	],
	#category : #'Network-Kernel'
}

{ #category : #example }
FastSocketStream class >> finger: userName [
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
FastSocketStream class >> on: socket [
	"Create a socket stream on a connected server socket."

	^self basicNew initialize socket: socket
]

{ #category : #'instance creation' }
FastSocketStream class >> openConnectionToHost: hostIP port: portNumber [
	| socket |
	socket _ Socket new.
	socket connectTo: hostIP port: portNumber.
	^self on: socket
]

{ #category : #'instance creation' }
FastSocketStream class >> openConnectionToHostNamed: hostName port: portNumber [
	| hostIP |
	hostIP _ NetNameResolver addressForName: hostName timeout: 20.
	^self openConnectionToHost: hostIP port: portNumber
]

{ #category : #private }
FastSocketStream >> adjustInBuffer: bytesRead [
	"Adjust markers and possibly grow inBuffer or move data down.
	Currently grows through doubling when less than 1024 bytes are left.
	Never shrinks. Returns the position in the buffer where any new
	data can be found."

	| old |
	bytesRead = 0 ifTrue: [^inNextToWrite].
	old _ inNextToWrite.
	inNextToWrite _ inNextToWrite + bytesRead.
	(inBuffer size - inNextToWrite) < 1024
		ifTrue: [
			"Hit the roof, move data down (if enough has been read) or do we grow?"
			(lastRead > 512)
				ifTrue: [^old - self moveInBufferDown]
				ifFalse: [self growInBuffer]].
	^old
]

{ #category : #private }
FastSocketStream >> adjustOutBuffer: bytesToWrite [
	"Possibly grow outBuffer to accommodate the new data.
	Currently grows through doubling when less
	than 1024 bytes are left. If bytesToWrite is even
	larger we double that instead. Never shrinks."

	(outBuffer size - outNextToWrite - bytesToWrite) < 1024 ifTrue: [
		outBuffer _ (self streamBuffer: ((outBuffer size max: bytesToWrite) * 2))
						replaceFrom: 1 to: outBuffer size with: outBuffer startingAt: 1]
]

{ #category : #configuration }
FastSocketStream >> ascii [
	"Tell the SocketStream to send data
	as Strings instead of ByteArrays.
	This is default."

	binary := false.
	self resetBuffers
]

{ #category : #testing }
FastSocketStream >> atEnd [
	"There is nothing more to read when
	there is no more data in our inBuffer, the socket
	is disconnected and there is none available on the socket.
	Note that we need to check isConnected before isDataAvailable,
	otherwise data may sneak in in the meantime. But we check the
	buffer first, because it is faster."

	self isInBufferEmpty ifFalse: [^false].
	^self isConnected not
		and: [self isDataAvailable not]
]

{ #category : #configuration }
FastSocketStream >> autoFlush [
	"If autoFlush is enabled data will be sent through
	the socket (flushed) when the bufferSize is reached
	or the SocketStream is closed. Otherwise the user
	will have to send #flush manually.
	Close will always flush. Default is false."

	^autoFlush
]

{ #category : #configuration }
FastSocketStream >> autoFlush: aBoolean [
	"If autoFlush is enabled data will be sent through
	the socket (flushed) when the bufferSize is reached
	or the SocketStream is closed. Otherwise the user
	will have to send #flush manually.
	Close will always flush. Default is false."

	autoFlush := aBoolean
]

{ #category : #configuration }
FastSocketStream >> binary [
	"Tell the SocketStream to send data
	as ByteArrays instead of Strings.
	Default is ascii."

	binary := true.
	self resetBuffers
]

{ #category : #configuration }
FastSocketStream >> bufferSize [
	"Default buffer size is 4kb.
	increased from earlier 2000 bytes."
	
	^bufferSize
]

{ #category : #configuration }
FastSocketStream >> bufferSize: anInt [
	"Default buffer size is 4kb.
	increased from earlier 2000 bytes."

	bufferSize := anInt
]

{ #category : #private }
FastSocketStream >> checkFlush [
	"If autoFlush is true we flush if
	we have reached the bufferSize
	of data in the outBuffer."

	(autoFlush and: [outNextToWrite > bufferSize])
		ifTrue: [self flush]
]

{ #category : #control }
FastSocketStream >> close [
	"Flush any data still not sent
	and take care of the socket."

	self flush.
	socket closeAndDestroy: 30
]

{ #category : #'stream out' }
FastSocketStream >> cr [
	self nextPutAll: String cr
]

{ #category : #'stream out' }
FastSocketStream >> crlf [
	self nextPutAll: String crlf
]

{ #category : #printing }
FastSocketStream >> debug [
	"Display debug info."

	| data |
	data _ self inBufferSize.
	^String streamContents: [:s |
		s
			nextPutAll: 'Buffer size: ', inBuffer size asString;cr;
			nextPutAll: 'InBuffer data size: ', data asString; cr;
			nextPutAll: 'In data (20):', (inBuffer copyFrom: lastRead + 1 to: lastRead + (data min: 20)); cr;
			nextPutAll: 'OutBuffer data size: ', (outNextToWrite - 1) asString; cr;
			nextPutAll: 'Out data (20):', (outBuffer copyFrom: 1 to: ((outNextToWrite - 1) min: 20)); cr]
]

{ #category : #control }
FastSocketStream >> flush [
	"If the other end is connected and we have something
	to send, then we send it and reset the outBuffer."

	((outNextToWrite > 1) and: [socket isOtherEndClosed not])
		ifTrue: [
			[socket sendData: outBuffer count: outNextToWrite - 1]
				on: ConnectionTimedOut
				do: [:ex | shouldSignal ifFalse: ["swallow"]].
			outNextToWrite _ 1]
]

{ #category : #private }
FastSocketStream >> growInBuffer [
	"Grows through doubling."

	self resizeInBuffer: inBuffer size * 2
]

{ #category : #configuration }
FastSocketStream >> inBufferSize [
	"Answers the current size of data in the inBuffer."

	^inNextToWrite - lastRead - 1
]

{ #category : #'initialize-release' }
FastSocketStream >> initialize [
	autoFlush _ true.
	shouldSignal _ true.
	recentlyRead _ 0.
	bufferSize _ 4096.
	self ascii
]

{ #category : #testing }
FastSocketStream >> isBinary [
	^binary
]

{ #category : #testing }
FastSocketStream >> isConnected [
	"The stream is connected if the socket is."

	^socket isConnected
]

{ #category : #testing }
FastSocketStream >> isDataAvailable [
	"It the inbuffer is empty, we check the socket for data.
	If it claims to have data available to read, we try to read
	some once and recursively call this method again.
	If something really was available it is now in the inBuffer.
	This is because there has been spurious
	dataAvailable when there really is no data to get."
 
	self isInBufferEmpty ifFalse: [^true].
	^socket dataAvailable
		ifFalse: [false]
		ifTrue: [self receiveDataIfAvailable; isDataAvailable]
]

{ #category : #testing }
FastSocketStream >> isEmpty [
	"Test if there are more data to read."

	^self isInBufferEmpty and: [self isDataAvailable not]
]

{ #category : #testing }
FastSocketStream >> isInBufferEmpty [
	"Any data in the buffer?"
 
	^lastRead + 1 = inNextToWrite
]

{ #category : #testing }
FastSocketStream >> isOtherEndConnected [
	^socket isOtherEndClosed not
]

{ #category : #private }
FastSocketStream >> moveInBufferDown [
	"Move down contents of inBuffer to the start.
	Return distance moved."

	| sz distanceMoved |
	sz _ inNextToWrite - lastRead - 1.
	inBuffer replaceFrom: 1 to: sz with: inBuffer startingAt: lastRead + 1.
	distanceMoved _ lastRead.
	lastRead _ 0.
	inNextToWrite _ sz + 1.
	^distanceMoved

]

{ #category : #'stream in' }
FastSocketStream >> next [
	"Return next byte, if inBuffer is empty
	we recieve some more data and try again."

	self atEnd ifTrue: [^nil].
	self isInBufferEmpty ifTrue:
		[self receiveData.
		self atEnd ifTrue: [^nil]].
	lastRead _ lastRead + 1.
	^inBuffer at: lastRead
]

{ #category : #'stream in' }
FastSocketStream >> next: anInteger [
	"Answer anInteger bytes of data.

	NOTE: This method doesn't honor timeouts if shouldSignal is false!"

	| start |
	self receiveData: anInteger.
	start _ lastRead + 1.
	lastRead _ (lastRead + anInteger) min: inNextToWrite - 1.
	^inBuffer copyFrom: start to: lastRead
]

{ #category : #'stream in' }
FastSocketStream >> nextAllInBuffer [
	"Return all data currently in the inBuffer,"

	^self nextInBuffer: inNextToWrite - lastRead - 1
]

{ #category : #'stream in' }
FastSocketStream >> nextAvailable [
	"Answer all the data currently available,
	in buffer or in socket."

	self isInBufferEmpty ifFalse: [^self nextAllInBuffer].
	self isDataAvailable ifTrue: [self receiveData].
	^self nextAllInBuffer
]

{ #category : #'stream in' }
FastSocketStream >> nextAvailable: howMany [
	"Answer all the data currently available,
	in buffer or in socket - but limited to <howMany>."

	self isInBufferEmpty ifFalse: [^self nextInBuffer: howMany].
	self isDataAvailable ifTrue: [self receiveData].
	^self nextInBuffer: howMany
]

{ #category : #'stream in' }
FastSocketStream >> nextInBuffer: anInteger [
	"Answer anInteger bytes of data at most,
	but only from the inBuffer."

	| start amount |
	amount _ anInteger min: (inNextToWrite - lastRead - 1).
	start _ lastRead + 1.
	lastRead _ lastRead + amount.
	^inBuffer copyFrom: start to: lastRead
]

{ #category : #'stream in' }
FastSocketStream >> nextLine [
	^self nextLineCrLf
]

{ #category : #'stream in' }
FastSocketStream >> nextLineCrLf [
	^self upToAll: String crlf
]

{ #category : #'stream in' }
FastSocketStream >> nextLineLf [
	| nextLine |
	nextLine := self upToAll: String lf.
	^nextLine
]

{ #category : #'stream out' }
FastSocketStream >> nextPut: char [
	"Put a single Character or byte onto the stream."

	| toPut |
	toPut _ binary ifTrue: [char asInteger] ifFalse: [char asCharacter].
	self adjustOutBuffer: 1.
	outBuffer at: outNextToWrite put: toPut.
	outNextToWrite _ outNextToWrite + 1.
	self checkFlush
]

{ #category : #'stream out' }
FastSocketStream >> nextPutAll: aCollection [
	"Put a String or a ByteArray onto the stream.
	Currently a large collection will allocate a large buffer."

	| toPut |
	toPut _ binary ifTrue: [aCollection asByteArray] ifFalse: [aCollection asString].
	self adjustOutBuffer: toPut size.
	outBuffer replaceFrom: outNextToWrite to: outNextToWrite + toPut size - 1 with: toPut startingAt: 1.
	outNextToWrite _ outNextToWrite + toPut size.
	self checkFlush
]

{ #category : #'stream out' }
FastSocketStream >> nextPutAllFlush: aCollection [
	"Put a String or a ByteArray onto the stream.
	You can use this if you have very large data - it avoids
	copying into the buffer (and avoids buffer growing)
	and also flushes any other pending data first."

	| toPut |
	toPut _ binary ifTrue: [aCollection asByteArray] ifFalse: [aCollection asString].
	self flush. "first flush pending stuff, then directly send"
	socket isOtherEndClosed ifFalse: [
		[socket sendData: toPut count: toPut size]
			on: ConnectionTimedOut
			do: [:ex | shouldSignal ifFalse: ["swallow"]]]
]

{ #category : #configuration }
FastSocketStream >> noTimeout [
	"Do not use timeout."

	timeout := 0
]

{ #category : #configuration }
FastSocketStream >> outBufferSize [
	"Answers the current size of data in the outBuffer."

	^outNextToWrite - 1
]

{ #category : #'stream in' }
FastSocketStream >> peek [
	"Return next byte, if inBuffer is empty
	we recieve some more data and try again.
	Do not consume the byte."

	self atEnd ifTrue: [^nil].
	self isInBufferEmpty ifTrue:
		[self receiveData.
		self atEnd ifTrue: [^nil]].
	^inBuffer at: lastRead
]

{ #category : #'stream in' }
FastSocketStream >> peek: anInteger [
	"Answer anInteger bytes of data.
	Do not consume data.

	NOTE: This method doesn't honor timeouts if shouldSignal is false!"

	| start |
	self receiveData: anInteger.
	start _ lastRead + 1.
	^inBuffer copyFrom: start to: ((lastRead + anInteger) min: inNextToWrite - 1).
]

{ #category : #'stream in' }
FastSocketStream >> peekFor: aCharacterOrByte [
	"Read and return next character or byte
	if it is equal to the argument.
	Otherwise return false."

	| nextObject |
	self atEnd ifTrue: [^false].
	self isInBufferEmpty ifTrue: 
		[self receiveData.
		self atEnd ifTrue: [^false]].
	nextObject _ inBuffer at: lastRead.
	nextObject = aCharacterOrByte ifTrue: [
		lastRead _ lastRead + 1.
		^true].
	^false

]

{ #category : #'stream in' }
FastSocketStream >> peekForAll: aString [
	"Answer whether or not the next string of characters in the receiver
	matches aString. If a match is made, advance over that string in the receiver and
	answer true. If no match, then leave the receiver alone and answer false.
	We use findString:startingAt: to avoid copying.

	NOTE: This method doesn't honor timeouts if shouldSignal is false!"

	| sz start |
	sz _ aString size.
	self receiveData: sz.
	(inNextToWrite - lastRead - 1) < sz ifTrue: [^false].
	start _ lastRead + 1.
	(inBuffer findString: aString startingAt: start) = start
		ifFalse: [^false].
	lastRead _ lastRead + sz.
	^true
]

{ #category : #printing }
FastSocketStream >> printOn: aStream [
	"Display buffer sizes."

	aStream nextPutAll: self class name.
	inBuffer ifNotNil: [
		aStream nextPutAll: '[inbuf:',
		(inBuffer size / 1024) rounded asString, 'kb/outbuf:',
		(outBuffer size / 1024) rounded asString, 'kb]']
]

{ #category : #'private-socket' }
FastSocketStream >> receiveAvailableData [
	"Receive available data (as much as fits in the inBuffer)
	but not waiting for more to arrive.
	Return the position in the buffer where the
	new data starts, regardless if anything
	was read, see #adjustInBuffer."
	
	recentlyRead _ socket receiveAvailableDataInto: inBuffer startingAt: inNextToWrite.
	^self adjustInBuffer: recentlyRead
]

{ #category : #'private-socket' }
FastSocketStream >> receiveData [
	"Receive data with timeout if it has been set.
	If shouldSignal is false we use the Socket methods
	that swallow those Exceptions, if it is true the
	caller will have to handle those Exceptions.
	Return the position in the buffer where the
	new data starts, regardless if anything
	was read, see #adjustInBuffer."
	
	recentlyRead := shouldSignal ifTrue: [
		self shouldTimeout ifTrue: [
				socket receiveDataSignallingTimeout: timeout
					into: inBuffer startingAt: inNextToWrite]
			ifFalse: [
				socket receiveDataSignallingClosedInto: inBuffer
					startingAt: inNextToWrite]]
				ifFalse: [
		self shouldTimeout ifTrue: [
			"This case is tricky, if it times out and is swallowed
			how does other methods calling this method repeatedly
			get to know that? And what should they do?"
				socket receiveDataTimeout: timeout
					into: inBuffer startingAt: inNextToWrite]
			ifFalse: [
				socket receiveDataInto: inBuffer
					startingAt: inNextToWrite]].
	^self adjustInBuffer: recentlyRead
]

{ #category : #control }
FastSocketStream >> receiveData: nBytes [
	"Keep reading the socket until we have nBytes
	in the inBuffer or we reach the end. This method
	does not return data, but can be used to make sure
	data has been read into the buffer from the Socket
	before actually reading it from the FastSocketStream.
	Mainly used internally. We could also adjust the buffer
	to the expected amount of data and avoiding several
	incremental grow operations.

	NOTE: This method doesn't honor timeouts if shouldSignal
	is false! And frankly, I am not sure how to handle that
	case or if I care - I think we should always signal."

	[self atEnd not and: [nBytes > self inBufferSize]]
		whileTrue: [self receiveData]
]

{ #category : #'private-socket' }
FastSocketStream >> receiveDataIfAvailable [
	"Only used to check that there really is data to read
	from the socket after it signals dataAvailable.
	It has been known to signal true and then still
	not have anything to read. See also isDataAvailable.
	Return the position in the buffer where the
	new data starts, regardless if anything
	was read, see #adjustInBuffer."

	recentlyRead _ socket receiveSomeDataInto: inBuffer startingAt: inNextToWrite.
	^self adjustInBuffer: recentlyRead
]

{ #category : #control }
FastSocketStream >> recentlyRead [
	"Return the number of bytes read
	during the last socket operation."
	
	^recentlyRead
]

{ #category : #private }
FastSocketStream >> resetBuffers [
	"Recreate the buffers with default start sizes."

	inBuffer _ self streamBuffer: bufferSize.
	lastRead _ 0.
	inNextToWrite _ 1.
	outBuffer _ self streamBuffer: bufferSize.
	outNextToWrite _ 1
]

{ #category : #private }
FastSocketStream >> resizeInBuffer: newSize [
	"Resize the inBuffer by recreating it.
	This also has the effect of getting rid of
	dead data above inNextToWrite.
	<newSize> must >= inBuffer size!"

	inBuffer _ (self streamBuffer: newSize)
					replaceFrom: 1 to: inNextToWrite - 1 with: inBuffer startingAt: 1
]

{ #category : #'stream out' }
FastSocketStream >> send: aStringOrByteArray withEndingTag: aString [
	"Sends a String or a ByteArray and then flush
	causing it to block until sent."

	self nextPutAllFlush: aStringOrByteArray, aString; flush
]

{ #category : #'stream out' }
FastSocketStream >> sendCommand: aString [
	"Sends a String ending it with CR LF and then flush
	causing it to block until sent."

	self nextPutAll: aString, String crlf; flush
]

{ #category : #configuration }
FastSocketStream >> shouldSignal [
	"If shouldSignal is enabled the Socket Exceptions
	ConnectionClosed and ConnectionTimedOut
	will not be swallowed. Default is true.
	For more info, see #shouldSignal:"

	^shouldSignal
]

{ #category : #configuration }
FastSocketStream >> shouldSignal: aBoolean [
	"If shouldSignal is enabled the Socket Exceptions
	ConnectionClosed and ConnectionTimedOut will not be swallowed.
	Default is true. And please - don't set it to false - it is better to
	use an exception handler (see below)  and several methods
	in this class will not honour timeouts (says so in their method comments).
	Also, it is quite hard to understand what for example #upToEnd
	should return to indicate a timeout.
	
	Wrap your use of SocketStream with a handler like:
	
	[stuff _ mySocketStream next: 10]
		on: ConnectionClosed, ConnectionTimedOut
		do: [:ex |
			Transcript show: 'Oops! Did not get my ten bytes!;cr]
	"

	shouldSignal := aBoolean
]

{ #category : #testing }
FastSocketStream >> shouldTimeout [
	^self timeout > 0
]

{ #category : #'stream in' }
FastSocketStream >> skip: anInteger [
	"Skip a number of bytes.
	This is faster than #next: since it does not
	have to copy and return a new String or ByteArray.

	NOTE: This method doesn't honor timeouts if shouldSignal is false!"

	self receiveData: anInteger.
	lastRead _ (lastRead + anInteger) min: inNextToWrite - 1
]

{ #category : #configuration }
FastSocketStream >> socket [
	^socket
]

{ #category : #configuration }
FastSocketStream >> socket: aSocket [
	socket _ aSocket
]

{ #category : #'stream out' }
FastSocketStream >> space [
	self nextPut: Character space
]

{ #category : #private }
FastSocketStream >> streamBuffer: size [
	"Create a buffer of the correct class and given size."

	^(self isBinary
		ifTrue: [ByteArray]
		ifFalse: [String]) new: size
]

{ #category : #configuration }
FastSocketStream >> timeout [
	"Lazily initialized unless it has been set explicitly."

	timeout ifNil: [timeout := Socket standardTimeout].
	^timeout
]

{ #category : #configuration }
FastSocketStream >> timeout: seconds [
	timeout := seconds
]

{ #category : #'stream in' }
FastSocketStream >> upTo: aCharacterOrByte [
	"Return data up to, but not including given character or byte.
	
	NOTE: Does not honour timeouts if shouldSignal is false!
	
	This method looks a bit complicated, and this is mainly because there is no fast search method
	in String that takes a stoppingAt: argument. This means we need to ignore getting hits in the
	dead buffer area above inNextToWrite.
	Another measure is that this implementation is greedy and will load data into the buffer
	until there is nothing more available, or it has loaded 100kb - and not until then we search the buffer.

	A totally non greedy variant would search on every loop."

	| index result lastRecentlyRead searchedSoFar |
	searchedSoFar _ 0.
	lastRecentlyRead _ 0.
	index _ 0.
	[self atEnd not and: [
		((lastRecentlyRead = 0 and: [self isInBufferEmpty not]) or: [self inBufferSize > 100000]) ifTrue: [
			"Data begins at lastRead + 1, we add searchedSoFar as offset."
			index _ inBuffer indexOf: aCharacterOrByte startingAt: lastRead + searchedSoFar + 1.
			searchedSoFar _ self inBufferSize.
			(index > 0 and: [(index + 1) > inNextToWrite]) ifTrue: [
				"Oops, hit in dead buffer area.
				This is probably due to old data, so we ignore it.
				No point in cleaning the dead area to avoid hits - it will still search it."
				index _ 0]].
		index = 0]]
				whileTrue: [
					recentlyRead = 0
						ifTrue: ["blocking call for now, we don't want to poll"
							self receiveData]
						ifFalse: [
							self receiveAvailableData].
					lastRecentlyRead _ recentlyRead].
	index > 0
		ifTrue: ["found it"
			result _ self nextInBuffer: index - lastRead - 1.
			self skip: 1.
			^ result]
		ifFalse: ["atEnd"
			^ self nextAllInBuffer]
]

{ #category : #'stream in' }
FastSocketStream >> upToAll: aStringOrByteArray [
	"Answer a subcollection from the current access position to the occurrence (if any, but not
	inclusive) of aStringOrByteArray. If aCollection is not in the stream, answer the entire rest of
	the stream.
	
	NOTE: Does not honour timeouts if shouldSignal is false!
	
	This method looks a bit complicated, and this is mainly because there is no fast search method
	in String that takes a stoppingAt: argument. This means we need to ignore getting hits in the
	dead buffer area above inNextToWrite.
	Another measure is that this implementation is greedy and will load data into the buffer
	until there is nothing more available, or it has loaded 100kb - and not until then we search the buffer.

	A totally non greedy variant would search on every loop."

	| index sz result lastRecentlyRead searchedSoFar |
	sz _ aStringOrByteArray size.
	searchedSoFar _ 0.
	lastRecentlyRead _ 0.
	index _ 0.
	[self atEnd not and: [
		((lastRecentlyRead = 0 and: [self isInBufferEmpty not]) or: [self inBufferSize > 100000]) ifTrue: [
			"Data begins at lastRead + 1, we add searchedSoFar as offset and backs up sz - 1
			so that we can catch any borderline hits."
			index _ inBuffer indexOfSubCollection: aStringOrByteArray
						startingAt: lastRead + searchedSoFar - sz + 2.
			searchedSoFar _ self inBufferSize.
			(index > 0 and: [(index + sz) > inNextToWrite]) ifTrue: [
				"Oops, hit partially or completely in dead buffer area.
				This is probably due to old data, so we ignore it.
				No point in cleaning the dead area to avoid hits - it will still search it."
				index _ 0]].
		index = 0]]
				whileTrue: [
					recentlyRead = 0
						ifTrue: ["blocking call for now, we don't want to poll"
							self receiveData]
						ifFalse: [
							self receiveAvailableData].
					lastRecentlyRead _ recentlyRead].
	index > 0
		ifTrue: ["found it"
			result _ self nextInBuffer: index - lastRead - 1.
			self skip: sz.
			^ result]
		ifFalse: ["atEnd"
			^ self nextAllInBuffer]
]

{ #category : #'stream in' }
FastSocketStream >> upToEnd [
	"Answer all data coming in on the socket until the socket
	is closed by the other end, or we get a timeout.
	This means this method catches ConnectionClosed by itself.
	
	NOTE: Does not honour timeouts if shouldSignal is false!"

	[[self atEnd] whileFalse: [self receiveData]]
		on: ConnectionClosed
		do: [:ex | "swallow it"]. 
	^self nextAllInBuffer
]
