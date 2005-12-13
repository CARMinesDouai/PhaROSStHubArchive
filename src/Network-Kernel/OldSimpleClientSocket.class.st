"
This class supports client for simple network protocols based on sending textual commands and responses. Examples of such protocols include POP3 (mail retrieval), SMTP (mail posting), HTTP (web browsing), and NTTP (network news). Some simple examples are presented as class methods, but a full-service client of some service should be implemented as a subclass.

The basic services provided by this class are:
	sendCommand:			-- sends a command line terminate with <CR><LF>
	getResponse				-- gets a single-line response to a command
	getMultilineResponse	-- gets a multiple line response terminated by a period
							-- on a line by itself

There are variants of the getResponse commands that display lines on the screen as they are being received. Linefeeds are stripped out of all responses.

The 'get' commands above make use of an internal buffer.  So intermixing these two commands and regular Socket recieve commands can cause problems.
"
Class {
	#name : #OldSimpleClientSocket,
	#superclass : #OldSocket,
	#instVars : [
		'buffer',
		'bufferPos'
	],
	#classVars : [
		'CrLf',
		'LF',
		'CR'
	],
	#category : #'Network-Kernel'
}

{ #category : #queries }
OldSimpleClientSocket class >> crLf [

	^ CrLf

]

{ #category : #'POP mail example' }
OldSimpleClientSocket class >> extractDateFromAndSubjectFromHeader: headerString [

	| date from subject s lineBuf c line i |
	date _ from _ subject _ ''.
	s _ ReadStream on: headerString.
	lineBuf _ WriteStream on: ''.
	[s atEnd] whileFalse: [
		c _ s next.
		c = CR
			ifTrue: [
				line _ lineBuf contents.
				(line beginsWith: 'Date: ')	ifTrue: [date _ line copyFrom: 7 to: line size].
				(line beginsWith: 'From: ')	ifTrue: [from _ line copyFrom: 7 to: line size].
				(line beginsWith: 'Subject: ')	ifTrue: [subject _ line copyFrom: 10 to: line size].
				lineBuf _ WriteStream on: '']
			ifFalse: [lineBuf nextPut: c]].

	i _ date indexOf: $' ifAbsent: [0].
	date _ date copyFrom: i + 1 to: date size.
	^ (self simpleDateString: date), ', ', from, ':
  ', subject

]

{ #category : #'other examples' }
OldSimpleClientSocket class >> finger: userName [
	"OldSimpleClientSocket finger: 'stp'"

	| addr s |
	addr _ NetNameResolver promptUserForHostAddress.
	s _ OldSimpleClientSocket new.
	Transcript show: '---------- Connecting ----------'; cr.
	s connectTo: addr port: 79.  "finger port number"
	s waitForConnectionUntil: self standardDeadline.
	s sendCommand: userName.
	Transcript show: s getResponse.
	s closeAndDestroy.
	Transcript show: '---------- Connection Closed ----------'; cr; endEntry.

]

{ #category : #'remote cursor example' }
OldSimpleClientSocket class >> forkingRemoteCursorSender [
	"This is the client side of a test that sends samples of the local input sensor state to the server, which may be running on a local or remote host. This method opens the connection, then forks a process to send the cursor data. Data is sent continuously until the user clicks in a 20x20 pixel square at the top-left corner of the display. The server should be started first. Note the server's address, since this method will prompt you for it."
	"SimpleClientSocket forkingRemoteCursorSender"

	| sock addr stopRect |
	Transcript show: 'starting remote cursor sender'; cr.
	Transcript show: 'initializing network'; cr.
	Socket initializeNetwork.
	addr _ NetNameResolver promptUserForHostAddress.
	Transcript show: 'opening connection'; cr.
	sock _ OldSimpleClientSocket new.
	sock connectTo: addr port: 54323.
	sock waitForConnectionUntil: self standardDeadline.
	(sock isConnected) ifFalse: [self error: 'sock not connected'].
	Transcript show: 'connection established'; cr.

	stopRect _ 0@0 corner: 20@20.  "click in this rectangle to stop sending"
	Display reverse: stopRect.
	["the sending process"
		[(stopRect containsPoint: Sensor cursorPoint) and:
		 [Sensor anyButtonPressed]]
			whileFalse: [
				sock sendCommand: self sensorStateString.
				(Delay forMilliseconds: 20) wait].

		sock waitForSendDoneUntil: self standardDeadline.
		sock destroy.
		Transcript show: 'remote cursor sender done'; cr.
		Display reverse: stopRect.
	] fork.

]

{ #category : #'other examples' }
OldSimpleClientSocket class >> httpTestHost: hostName port: port url: url [
	"This test fetches a URL from the given host and port."
	"SimpleClientSocket httpTestHost: 'www.disney.com' port: 80 url: '/'"
	"Tests URL fetch through a local HTTP proxie server:
		(SimpleClientSocket
			httpTestHost: '127.0.0.1'
			port: 8080
			url: 'HTTP://www.exploratorium.edu/index.html')"

	| hostAddr s result buf bytes totalBytes t |
	Transcript cr; show: 'starting http test'; cr.
	Socket initializeNetwork.
	hostAddr _ NetNameResolver addressForName: hostName timeout: 10.
	hostAddr = nil ifTrue: [^ self inform: 'Could not find an address for ', hostName].

	s _ OldSimpleClientSocket new.
	Transcript show: '---------- Connecting ----------'; cr.
	s connectTo: hostAddr port: port.
	s waitForConnectionUntil: "self standardDeadline" (Socket deadlineSecs: 10).
	(s isConnected) ifFalse: [
		s destroy.
		^ self inform: 'could not connect'].
	Transcript show: 'connection open; waiting for data'; cr.

	s sendCommand: 'GET ', url, ' HTTP/1.0'.
	s sendCommand: 'User-Agent: Squeak 1.19'.
	s sendCommand: 'ACCEPT: text/html'.	"always accept plain text"
	s sendCommand: 'ACCEPT: application/octet-stream'.  "also accept binary data"
	s sendCommand: ''.  "blank line"

	result _ WriteStream on: (String new: 10000).
	buf _ String new: 10000.
	totalBytes _ 0.
	t _ Time millisecondsToRun: [
		[s isConnected] whileTrue: [
			s waitForDataUntil: (Socket deadlineSecs: 5).
			bytes _ s receiveDataInto: buf.
			1 to: bytes do: [:i | result nextPut: (buf at: i)].
			totalBytes _ totalBytes + bytes.
			Transcript show: totalBytes printString, ' bytes received'; cr]].

	s destroy.
	Transcript show: '---------- Connection Closed ----------'; cr; endEntry.
	Transcript show: 'http test done; ', totalBytes printString, ' bytes read in '.
	Transcript show: ((t / 1000.0) roundTo: 0.01) printString, ' seconds'; cr.
	Transcript show: ((totalBytes asFloat / t) roundTo: 0.01) printString, ' kBytes/sec'; cr.
	Transcript endEntry.
	(StringHolder new contents: (result contents))
		openLabel: 'HTTP Test Result: URL Contents'.

]

{ #category : #'class initialization' }
OldSimpleClientSocket class >> initialize [
	"SimpleClientSocket initialize"

	CR _ Character cr.
	LF _ Character linefeed.

	"string for command line termination:"
	CrLf _ String with: CR with: LF.

]

{ #category : #'net news example' }
OldSimpleClientSocket class >> nntpTest [
	"SimpleClientSocket nntpTest"

	| addr s headers msgs header allNewsGroups |
	addr _ NetNameResolver promptUserForHostAddress.
	s _ OldSimpleClientSocket new.
	Transcript show: '---------- Connecting ----------'; cr.
	s connectTo: addr port: 119.  "119 is the NNTP port number"
	s waitForConnectionUntil: self standardDeadline.
	Transcript show: s getResponse.
	s sendCommand: 'group comp.lang.smalltalk'.
	Transcript show: s getResponse.

	"get all the message headers for the current newsgroup"
	s sendCommand: 'xover 1-1000000'.
	headers _ s getMultilineResponseShowing: true.

	"print the headers of the first 10 messages of comp.lang.smalltalk"
	s sendCommand: 'listgroup comp.lang.smalltalk'.
	msgs _ self parseIntegerList: s getMultilineResponse.
	msgs ifNotNil: [
		1 to: 5 do: [:i |
			s sendCommand: 'head ', (msgs at: i) printString.
			header _ s getMultilineResponse.
			Transcript show: (self extractDateFromAndSubjectFromHeader: header); cr]].

	"get a full list of usenet newsgroups"
	s sendCommand: 'newgroups 010101 000000'.
	allNewsGroups _ s getMultilineResponse.
	Transcript show: allNewsGroups size printString, ' bytes in full newsgroup list'; cr.

	Transcript show: 'Sending quit...'; cr.
	s sendCommand: 'QUIT'.
	Transcript show: s getResponse.
	s closeAndDestroy.
	Transcript show: '---------- Connection Closed ----------'; cr; endEntry.

	(headers ~~ nil and:
	 [self confirm: 'show article headers from comp.lang.smalltalk?'])
		ifTrue: [
			(StringHolder new contents: (self parseHeaderList: headers))
				openLabel: 'Newsgroup Headers'].

	(allNewsGroups ~~ nil and:
	 [self confirm: 'show list of all newsgroups available on your server?'])
		ifTrue: [
			(StringHolder new contents: allNewsGroups)
				openLabel: 'All Usenet Newsgroups'].

]

{ #category : #'net news example' }
OldSimpleClientSocket class >> parseHeaderList: aString [
	"Parse a list of newsgroup headers."

	| results s lineStart |
	results _ WriteStream on: (String new: aString size).
	s _ ReadStream on: aString.
	[s atEnd]
		whileFalse: [
			lineStart _ s position + 1.
			3 timesRepeat: [s skipTo: Character tab].  "find fourth tab"
			lineStart to: s position - 1 do: [:i | results nextPut: (aString at: i)].
			results cr.
			s skipTo: Character cr].
	^ results contents

]

{ #category : #'net news example' }
OldSimpleClientSocket class >> parseIntegerList: aString [
	"Parse a list of integers, each on a line by itself."

	| s out |
	s _ ReadStream on: aString.
	s skipTo: Character cr.  "skip the first line"
	out _ OrderedCollection new.
	[s atEnd]
		whileFalse: [
			out addLast: (Integer readFrom: s).
			s skipTo: Character cr].
	^ out asArray

]

{ #category : #'net news example' }
OldSimpleClientSocket class >> parseNTTPMsgList: aString [
	"Parse a list of integers, each on a line by itself."

	| s out |
	s _ ReadStream on: aString.
	s skipTo: Character cr.  "skip the first line"
	out _ OrderedCollection new.
	[s atEnd]
		whileFalse: [
			out addLast: (Integer readFrom: s).
			s skipTo: Character cr].
	^ out asArray

]

{ #category : #'remote cursor example' }
OldSimpleClientSocket class >> parseSensorStateString: aString [
	"Parse the given sensor stat string and return an array whose first element is the cursor point and whose second is the cursor button state."
	"SimpleClientSocket parseSensorStateString: SimpleClientSocket sensorStateString"

	| s buttons x y |
	s _ ReadStream on: aString.
	x _ Integer readFrom: s.
	s skipSeparators.
	y _ Integer readFrom: s.
	s skipSeparators.
	buttons _ Integer readFrom: s.
	^ Array with: x@y with: buttons

]

{ #category : #'POP mail example' }
OldSimpleClientSocket class >> popTest [
	"SimpleClientSocket popTest"

	| addr userName userPassword s msgs header |
	addr _ NetNameResolver promptUserForHostAddress.
	userName _ FillInTheBlank
		request: 'What is your email name?'
		initialAnswer: 'johnm'.
	userPassword _ FillInTheBlank
		request: 'What is your email password?'.

	s _ OldSimpleClientSocket new.
	Transcript show: '---------- Connecting ----------'; cr.
	s connectTo: addr port: 110.  "110 is the POP3 port number"
	s waitForConnectionUntil: self standardDeadline.
	Transcript show: s getResponse.
	s sendCommand: 'USER ', userName.
	Transcript show: s getResponse.
	s sendCommand: 'PASS ', userPassword.
	Transcript show: s getResponse.
	s sendCommand: 'LIST'.

	"the following should be tweaked to handle an empy mailbox:"
	msgs _ self parseIntegerList: s getMultilineResponse.

	1 to: (msgs size min: 5) do: [ :i |
		s sendCommand: 'TOP ', (msgs at: i) printString, ' 0'.
		header _ s getMultilineResponse.
		Transcript show: (self extractDateFromAndSubjectFromHeader: header); cr].

	msgs size > 0 ifTrue: [
		"get the first message"
		s sendCommand: 'RETR 1'.
		Transcript show: s getMultilineResponse].

	Transcript show: 'closing connection'; cr.
	s sendCommand: 'QUIT'.
	s closeAndDestroy.
	Transcript show: '---------- Connection Closed ----------'; cr; endEntry.

]

{ #category : #'remote cursor example' }
OldSimpleClientSocket class >> remoteCursorReceiver [
	"Wait for a connection, then display data sent by the client until the client closes the stream. This server process is usually started first (optionally in a forked process), then the sender process is started (optionally on another machine). Note this machine's address, which is printed in the transcript, since the sender process will ask for it."
	"[SimpleClientSocket remoteCursorReceiver] fork"

	| sock response |
	Transcript show: 'starting remote cursor receiver'; cr.
	Transcript show: 'initializing network'; cr.
	Socket initializeNetwork.
	Transcript show: 'my address is ', NetNameResolver localAddressString; cr.
	Transcript show: 'opening connection'; cr.
	sock _ OldSimpleClientSocket new.
	sock listenOn: 54323.
	sock waitForConnectionUntil: (Socket deadlineSecs: 60).
	sock isConnected
		ifFalse: [
			 sock destroy.
			Transcript show: 'remote cursor receiver did not receive a connection in 60 seconds; aborting.'.
			^ self].
	Transcript show: 'connection established'; cr.

	[sock isConnected]
		whileTrue: [
			sock dataAvailable
				ifTrue: [
					response _ sock getResponse.
					response displayOn: Display at: 10@10]
				ifFalse: [
					"if no data available, let other processes run for a while"
					(Delay forMilliseconds: 20) wait]].

	sock destroy.
	Transcript show: 'remote cursor receiver done'; cr.

]

{ #category : #'remote cursor example' }
OldSimpleClientSocket class >> remoteCursorTest [
	"This version of the remote cursor test runs both the client and the server code in the same loop."
	"SimpleClientSocket remoteCursorTest"

	| sock1 sock2 samplesToSend samplesSent done t |
	Transcript show: 'starting remote cursor test'; cr.
	Transcript show: 'initializing network'; cr.
	Socket initializeNetwork.
	Transcript show: 'opening connection'; cr.
	sock1 _ OldSimpleClientSocket new.
	sock2 _ OldSimpleClientSocket new.
	sock1 listenOn: 54321.
	sock2 connectTo: (NetNameResolver localHostAddress) port: 54321.
	sock1 waitForConnectionUntil: self standardDeadline.
	sock2 waitForConnectionUntil: self standardDeadline.
	(sock1 isConnected) ifFalse: [self error: 'sock1 not connected'].
	(sock2 isConnected) ifFalse: [self error: 'sock2 not connected'].
	Transcript show: 'connection established'; cr.

	samplesToSend _ 100.
	t _ Time millisecondsToRun: [
		samplesSent _ 0.
		done _ false.
		[done]
			whileFalse: [
				(sock1 sendDone and: [samplesSent < samplesToSend]) ifTrue: [
					sock1 sendCommand: self sensorStateString.
					samplesSent _ samplesSent + 1].
				sock2 dataAvailable ifTrue: [
					sock2 getResponse displayOn: Display at: 10@10].
				done _ samplesSent = samplesToSend]].
	sock1 destroy.
	sock2 destroy.
	Transcript show: 'remote cursor test done'; cr.
	Transcript show:
		samplesSent printString, ' samples sent in ',
		t printString, ' milliseconds'; cr.
	Transcript show: ((samplesSent * 1000) // t) printString, ' samples/sec'; cr.

]

{ #category : #'remote cursor example' }
OldSimpleClientSocket class >> sensorStateString [
	"SimpleClientSocket sensorStateString"

	| pt buttons s |
	pt _ Sensor cursorPoint.
	buttons _ Sensor primMouseButtons.
	s _ WriteStream on: (String new: 100).
	s nextPutAll: pt x printString.
	s space.
	s nextPutAll: pt y printString.
	s space.
	s nextPutAll: buttons printString.
	^ s contents

]

{ #category : #'POP mail example' }
OldSimpleClientSocket class >> simpleDateString: dateString [

	| s |
	s _ ReadStream on: dateString.
	s skipTo: $,.  "scan thru first comma"
	s atEnd ifTrue: [s reset].  "no comma found; reset s"
	s skipSeparators.
	^ (Date readFrom: s) mmddyyyy

]

{ #category : #'other examples' }
OldSimpleClientSocket class >> timeTest [
	"SimpleClientSocket timeTest"

	| addr s |
	addr _ NetNameResolver promptUserForHostAddress.
	s _ OldSimpleClientSocket new.
	Transcript show: '---------- Connecting ----------'; cr.
	s connectTo: addr port: 13.  "time port number"
	s waitForConnectionUntil: self standardDeadline.
	Transcript show: s getResponse.
	s closeAndDestroy.
	Transcript show: '---------- Connection Closed ----------'; cr; endEntry.

]

{ #category : #'as yet unclassified' }
OldSimpleClientSocket >> displayString: aString [
	"Display the given string on the Display. Used for testing."

	| s |
	aString isEmpty ifTrue: [^ self].
	aString size > 60
		ifTrue: [s _ aString copyFrom: 1 to: 60]  "limit to 60 characters"
		ifFalse: [s _ aString].

	s displayOn: Display.

]

{ #category : #'as yet unclassified' }
OldSimpleClientSocket >> getMultilineResponse [
	"Get a multiple line response to the last command, filtering out LF characters. A multiple line response ends with a line containing only a single period (.) character."

	^ self getMultilineResponseShowing: false.

]

{ #category : #'as yet unclassified' }
OldSimpleClientSocket >> getMultilineResponseShowing: showFlag [
	"Get a multiple line response to the last command. A multiple line response ends with a line containing only a single period (.) character. Linefeed characters are filtered out. If showFlag is true, each line is shown in the upper-left corner of the Display as it is received."

	| response done chunk |
	response _ WriteStream on: ''.
	done _ false.
	[done] whileFalse: [
		showFlag
			ifTrue: [chunk _ self getResponseShowing: true]
			ifFalse: [chunk _ self getResponse].
		(chunk beginsWith: '.')
			ifTrue: [ response nextPutAll: (chunk copyFrom: 2 to: chunk size) ]
			ifFalse: [ response nextPutAll: chunk ].
		done _ (chunk = ('.', String cr)) ].

	^ response contents

]

{ #category : #'as yet unclassified' }
OldSimpleClientSocket >> getResponse [
	"Get a one-line response from the server.  The final LF is removed from the line, but the CR is left, so that the line is in Squeak's text format"

	^ self getResponseShowing: false

]

{ #category : #'as yet unclassified' }
OldSimpleClientSocket >> getResponseShowing: showFlag [

	| line idx |
	line _ WriteStream on: String new.

	buffer ifNil: [
		buffer _ String new.
		bufferPos _ 0 ].

	[
		"look for a LF in the buffer"
		idx _ buffer indexOf: Character lf startingAt: bufferPos+1 ifAbsent: [ 0 ].
		idx > 0 ifTrue: [
			"found it! we have a line"
			line nextPutAll: (buffer copyFrom: bufferPos+1 to: idx-1).
			bufferPos _ idx.
			^line contents ].
		
		"didn't find it.  add the whole buffer to the line, and retrieve some more data"
		line nextPutAll: (buffer copyFrom: bufferPos+1 to: buffer size).
		bufferPos _ 0.
		buffer _ String new.
		self waitForDataQueryingUserEvery: 30.
		buffer _ self getData.

		true
	] whileTrue.
]

{ #category : #'as yet unclassified' }
OldSimpleClientSocket >> sendCommand: commandString [
	"Send the given command as a single line followed by a <CR><LF> terminator."

	self sendData: commandString, CrLf.

]

{ #category : #'as yet unclassified' }
OldSimpleClientSocket >> waitForDataQueryingUserEvery: seconds [
	"Wait for data to arrive, asking the user periodically if they wish to keep waiting. If they don't wish to keep waiting, destroy the socket and raise an error."

	| gotData |
	gotData _ false.
	[gotData]
		whileFalse: [
			gotData _ self waitForDataUntil: (Socket deadlineSecs: seconds).
			gotData ifFalse: [
				self isConnected ifFalse: [
					self destroy.
					self error: 'server closed connection'].
				(self confirm: 'server not responding; keep trying?')
					ifFalse: [
						self destroy.
						self error: 'no response from server']]].

]
