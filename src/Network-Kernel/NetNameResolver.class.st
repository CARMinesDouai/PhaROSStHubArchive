"
This class implements TCP/IP style network name lookup and translation facilities.

Attempt to keep track of whether there is a network available.
HaveNetwork	true if last attempt to contact the network was successful.
LastContact		Time of that contact (totalSeconds).
haveNetwork	returns true, false, or #expired.  True means there was contact in the last 30 minutes.  False means contact failed or was false last time we asked.  Get out of false state by making contact with a server in some way (FileList or updates).
"
Class {
	#name : #NetNameResolver,
	#superclass : #Object,
	#classVars : [
		'ResolverReady',
		'DefaultHostName',
		'ResolverUninitialized',
		'ResolverMutex',
		'ResolverSemaphore',
		'ResolverError',
		'ResolverBusy',
		'HaveNetwork'
	],
	#category : #'Network-Kernel'
}

{ #category : #lookups }
NetNameResolver class >> addressForName: aString [
	^self addressForName: aString timeout: 60
]

{ #category : #lookups }
NetNameResolver class >> addressForName: hostName timeout: secs [
	"Look up the given host name and return its address. Return nil if the address is not found in the given number of seconds."
	"NetNameResolver addressForName: 'create.ucsb.edu' timeout: 30"
	"NetNameResolver addressForName: '100000jobs.de' timeout: 30"
	"NetNameResolver addressForName: '1.7.6.4' timeout: 30"
	"NetNameResolver addressForName: '' timeout: 30 (This seems to return nil?)"

	| deadline result |
	self initializeNetwork.
	"check if this is a valid numeric host address (e.g. 1.2.3.4)"
	result _ self addressFromString: hostName.
	result isNil ifFalse: [^result].

	"Look up a host name, including ones that start with a digit (e.g. 100000jobs.de or squeak.org)"
	deadline _ Time millisecondClockValue + (secs * 1000).
	"Protect the execution of this block, as the ResolverSemaphore is used for both parts of the transaction."
	self resolverMutex
		critical: [
			(self waitForResolverReadyUntil: deadline)
				ifTrue: [
					self primStartLookupOfName: hostName.
					(self waitForCompletionUntil: deadline)
						ifTrue: [result _ self primNameLookupResult]
						ifFalse: [(NameLookupFailure hostName: hostName) signal: 'Could not resolve the server named: ', hostName]]
				ifFalse: [(NameLookupFailure hostName: hostName) signal: 'Could not resolve the server named: ', hostName]].
	^result
]

{ #category : #'address string utils' }
NetNameResolver class >> addressFromString: addressString [
	"Return the internet address represented by the given string. The string should contain four positive decimal integers delimited by periods, commas, or spaces, where each integer represents one address byte. Return nil if the string is not a host address in an acceptable format."
	"NetNameResolver addressFromString: '1.2.3.4'"
	"NetNameResolver addressFromString: '1,2,3,4'"
	"NetNameResolver addressFromString: '1 2 3 4'"

	| newAddr s byte delimiter |
	newAddr _ ByteArray new: 4.
	s _ ReadStream on: addressString.
	s skipSeparators.
	1 to: 4 do: [:i |
		byte _ self readDecimalByteFrom: s.
		byte = nil ifTrue: [^ nil].
		newAddr at: i put: byte.
		i < 4 ifTrue: [
			delimiter _ s next.
			((delimiter = $.) or: [(delimiter = $,) or: [delimiter = $ ]])
				ifFalse: [^ nil]]].
	^ newAddr

]

{ #category : #'class initialization' }
NetNameResolver class >> initialize [
	"NetNameResolver initialize"
	"Note: On the Mac, the name resolver is asynchronous (i.e., Squeak can do other things while it is working), but can only handle one request at a time. On other platforms, such as Unix, the resolver is synchronous; a call to, say, the name lookup primitive will block all Squeak processes until it returns."

	"Resolver Status Values"
	ResolverUninitialized _ 0.	"network is not initialized"
	ResolverReady _ 1.			"resolver idle, last request succeeded"
	ResolverBusy _ 2.			"lookup in progress"
	ResolverError _ 3.			"resolver idle, last request failed"

	DefaultHostName _ ''.

]

{ #category : #'network initialization' }
NetNameResolver class >> initializeNetwork [
	"Initialize the network drivers and record the semaphore to be used by the resolver. Do nothing if the network is already initialized. Evaluate the given block if network initialization fails."
	"NetNameResolver initializeNetwork"

	| semaIndex |
	self resolverStatus = ResolverUninitialized
		ifFalse: [^HaveNetwork _ true].  "network is already initialized"

	HaveNetwork _ false.	"in case abort"
	ResolverSemaphore _ Semaphore new.
	semaIndex _ Smalltalk registerExternalObject: ResolverSemaphore.

	"result is nil if network initialization failed, self if it succeeds"
	(self primInitializeNetwork: semaIndex)
		ifNil: [NoNetworkError signal: 'failed network initialization']
		ifNotNil: [HaveNetwork _ true].

]

{ #category : #lookups }
NetNameResolver class >> localAddressString [
	"Return a string representing the local host address as four decimal bytes delimited with decimal points."
	"NetNameResolver localAddressString"

	^ NetNameResolver stringFromAddress: NetNameResolver localHostAddress

]

{ #category : #lookups }
NetNameResolver class >> localHostAddress [
	"Return the local address of this host."
	"NetNameResolver localHostAddress"

	self initializeNetwork.
	^ self primLocalAddress

]

{ #category : #lookups }
NetNameResolver class >> localHostName [
	"Return the local name of this host."
	"NetNameResolver localHostName"

	| hostName |
	hostName _ NetNameResolver
		nameForAddress: self localHostAddress
		timeout: 5.
	^hostName
		ifNil: [self localAddressString]
		ifNotNil: [hostName]
]

{ #category : #lookups }
NetNameResolver class >> nameForAddress: hostAddress timeout: secs [
	"Look up the given host address and return its name. Return nil if the lookup fails or is not completed in the given number of seconds. Depends on the given host address being known to the gateway, which may not be the case for dynamically allocated addresses."
	"NetNameResolver
		nameForAddress: (NetNameResolver addressFromString: '128.111.92.2')
		timeout: 30"

	| deadline result |
	self initializeNetwork.
	deadline _ Time millisecondClockValue + (secs * 1000).
	"Protect the execution of this block, as the ResolverSemaphore is used for both parts of the transaction."
	self resolverMutex
		critical: [
			result _ (self waitForResolverReadyUntil: deadline)
				ifTrue: [
					self primStartLookupOfAddress: hostAddress.
					(self waitForCompletionUntil: deadline)
						ifTrue: [self primAddressLookupResult]
						ifFalse: [nil]]
				ifFalse: [nil]].
	^result

]

{ #category : #primitives }
NetNameResolver class >> primAbortLookup [
	"Abort the current lookup operation, freeing the name resolver for the next query."

	<primitive: 'primitiveResolverAbortLookup' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
NetNameResolver class >> primAddressLookupResult [
	"Return the host name found by the last host address lookup. Returns nil if the last lookup was unsuccessful."

	<primitive: 'primitiveResolverAddressLookupResult' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #'network initialization' }
NetNameResolver class >> primInitializeNetwork: resolverSemaIndex [
	"Initialize the network drivers on platforms that need it, such as the Macintosh, and return nil if network initialization failed or the reciever if it succeeds. Since mobile computers may not always be connected to a network, this method should NOT be called automatically at startup time; rather, it should be called when first starting a networking application. It is a noop if the network driver has already been initialized. If non-zero, resolverSemaIndex is the index of a VM semaphore to be associated with the network name resolver. This semaphore will be signalled when the resolver status changes, such as when a name lookup query is completed."
	"Note: some platforms (e.g., Mac) only allow only one name lookup query at a time, so a manager process should be used to serialize resolver lookup requests."

	<primitive: 'primitiveInitializeNetwork' module: 'SocketPlugin'>
	^ nil  "return nil if primitive fails"

]

{ #category : #primitives }
NetNameResolver class >> primLocalAddress [
	"Return the local address of this host."

	<primitive: 'primitiveResolverLocalAddress' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
NetNameResolver class >> primNameLookupResult [
	"Return the host address found by the last host name lookup. Returns nil if the last lookup was unsuccessful."

	<primitive: 'primitiveResolverNameLookupResult' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
NetNameResolver class >> primNameResolverError [
	"Return an integer reflecting the error status of the last network name resolver request. Zero means no error."

	<primitive: 'primitiveResolverError' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
NetNameResolver class >> primNameResolverStatus [
	"Return an integer reflecting the status of the network name resolver. For a list of possible values, see the comment in the 'initialize' method of this class."

	<primitive: 'primitiveResolverStatus' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
NetNameResolver class >> primStartLookupOfAddress: hostAddr [
	"Look up the given host address in the Domain Name Server to find its name. This call is asynchronous. To get the results, wait for it to complete or time out and then use primAddressLookupResult."

	<primitive: 'primitiveResolverStartAddressLookup' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #primitives }
NetNameResolver class >> primStartLookupOfName: hostName [
	"Look up the given host name in the Domain Name Server to find its address. This call is asynchronous. To get the results, wait for it to complete or time out and then use primNameLookupResult."

	<primitive: 'primitiveResolverStartNameLookup' module: 'SocketPlugin'>
	self primitiveFailed

]

{ #category : #lookups }
NetNameResolver class >> promptUserForHostAddress [
	"Ask the user for a host name and return its address."
	"NetNameResolver promptUserForHostAddress"

	^ NetNameResolver promptUserForHostAddressDefault: ''

]

{ #category : #lookups }
NetNameResolver class >> promptUserForHostAddressDefault: defaultName [
	"Ask the user for a host name and return its address. If the default name is the empty string, use the last host name as the default."
	"NetNameResolver promptUserForHostAddressDefault: ''"

	| default hostName serverAddr |
	defaultName isEmpty
		ifTrue: [default _ DefaultHostName]
		ifFalse: [default _ defaultName].
	hostName _ FillInTheBlank
		request: 'Host name or address?'
		initialAnswer: default.
	hostName isEmpty ifTrue: [^ 0].
	serverAddr _ NetNameResolver addressForName: hostName timeout: 15.
	hostName size > 0 ifTrue: [DefaultHostName _ hostName].
	^ serverAddr
]

{ #category : #private }
NetNameResolver class >> readDecimalByteFrom: aStream [
	"Read a positive, decimal integer from the given stream. Stop when a non-digit or end-of-stream is encountered. Return nil if stream is not positioned at a decimal digit or if the integer value read exceeds 255.
JMM - 000503 fixed didn't work correctly"

	| digitSeen value digit |
	digitSeen _ false.
	value _ 0.
	[aStream atEnd] whileFalse: 
		[digit _ aStream next digitValue.
		(digit < 0 or: [digit > 9]) ifTrue: [
			aStream skip: -1.
			(digitSeen not or: [value > 255]) ifTrue: [^ nil].
			^ value].
		digitSeen _ true.
		value _ (value * 10) + digit].
	(digitSeen not or: [value > 255]) ifTrue: [^ nil].
	^ value

]

{ #category : #lookups }
NetNameResolver class >> resolverError [
	^self primNameResolverError

]

{ #category : #private }
NetNameResolver class >> resolverMutex [
	ResolverMutex ifNil: [ResolverMutex _ Semaphore forMutualExclusion].
	^ResolverMutex
]

{ #category : #lookups }
NetNameResolver class >> resolverStatus [
	^self primNameResolverStatus

]

{ #category : #'address string utils' }
NetNameResolver class >> stringFromAddress: addr [
	"Return a string representing the given host address as four decimal bytes delimited with decimal points."
	"NetNameResolver stringFromAddress: NetNameResolver localHostAddress"

	| s |
	s _ WriteStream on: ''.
	1 to: 3 do: [ :i | (addr at: i) printOn: s. s nextPut: $.].
	(addr at: 4) printOn: s.
	^ s contents

]

{ #category : #private }
NetNameResolver class >> waitForCompletionUntil: deadline [
	"Wait up to the given number of seconds for the resolver to be ready to accept a new request. Return true if the resolver is ready, false if the network is not initialized or the resolver does not become free within the given time period."

	| status |
	status _ self resolverStatus.
	[(status = ResolverBusy) and:
	 [Time millisecondClockValue < deadline]]
		whileTrue: [
			"wait for resolver to be available"
			ResolverSemaphore waitTimeoutMSecs: (deadline - Time millisecondClockValue).
			status _ self resolverStatus].

	status = ResolverReady
		ifTrue: [^ true]
		ifFalse: [
			status = ResolverBusy ifTrue: [self primAbortLookup].
			^ false].

]

{ #category : #private }
NetNameResolver class >> waitForResolverReadyUntil: deadline [
	"Wait up to the given number of seconds for the resolver to be ready to accept a new request. Return true if the resolver is not busy, false if the network is not initialized or the resolver does not become free within the given time period."

	| status |
	status _ self resolverStatus.
	status = ResolverUninitialized ifTrue: [^ false].

	[(status = ResolverBusy) and:
	 [Time millisecondClockValue < deadline]]
		whileTrue: [
			"wait for resolver to be available"
			ResolverSemaphore waitTimeoutMSecs: (deadline - Time millisecondClockValue).
			status _ self resolverStatus].

	^ status ~= ResolverBusy

]
