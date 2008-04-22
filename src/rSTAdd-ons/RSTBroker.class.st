"
I'm the door to other image and the door for other images to come in.

ForwardedExceptionSet is an ExceptionSet with all exceptions that are forwarded to remote clients
"
Class {
	#name : #RSTBroker,
	#superclass : #TcpService,
	#instVars : [
		'status',
		'logging',
		'brokerID',
		'proxies',
		'proxiesMutex',
		'lastRemoteBrokers',
		'exportedObjects',
		'rememberer',
		'maintenancer',
		'resolved',
		'address',
		'loggerMutex',
		'logFileName'
	],
	#classVars : [
		'ForwardedExceptionSet'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'rSTAdd-ons'
}

{ #category : #'*rSTAdd-ons' }
RSTBroker class >> defaultAddress [
	"Answers the default ip address for the service.
	Note: to listen only localhost is the safest default 
	but is probably better not trust too much in defaults 
	and configure things consciously"
	^ '127.0.0.1' 
]

{ #category : #'*rSTAdd-ons' }
RSTBroker class >> defaultPort [
	"Answers the default port to listen."
	^ 9999
]

{ #category : #'*rSTAdd-ons' }
RSTBroker class >> export: anObject as: aString [
	"Makes anObject to be remotely accessed as aString"

	^ self instance export: anObject as: aString 
]

{ #category : #'*rSTAdd-ons' }
RSTBroker class >> export: anObject named: aString [ 
	
	self flag: #deprecated. "use #export:as: it has better intention revelaing"
	
	^ self export: anObject  as: aString 
]

{ #category : #'*rSTAdd-ons' }
RSTBroker class >> initialize [

	"Not everybody starts service in images the same way
	specially of it should be controlled or coupled 
	to external configurations (typical of production environments)"
	
	self flag: #check "use #install and #uninstall"
]

{ #category : #'*rSTAdd-ons' }
RSTBroker class >> initializeInstance [

	^ instance := super new

]

{ #category : #'*rSTAdd-ons' }
RSTBroker class >> install [
	"Makes the receiver to autostart with the image"
	Smalltalk addToStartUpList: self.
	Smalltalk addToShutDownList: self.
	ForwardedExceptionSet := ExceptionSet new.
	ForwardedExceptionSet add: Error
]

{ #category : #'*rSTAdd-ons' }
RSTBroker class >> instance [
	
	^ instance ifNil:[self initializeInstance]


]

{ #category : #'*rSTAdd-ons' }
RSTBroker class >> isStarted [

	^ instance notNil and:[
	instance isStarted]
]

{ #category : #'instance creation' }
RSTBroker class >> new [
	self error: 'you must use #instance'
]

{ #category : #'*rSTAdd-ons' }
RSTBroker class >> reset [
	self stop
]

{ #category : #'*rSTAdd-ons' }
RSTBroker class >> shutDown [
	instance ifNotNil:[instance pause]
]

{ #category : #'*rSTAdd-ons' }
RSTBroker class >> start [
	"Starts the service with defaults"
	^ self startOnPort: self defaultPort 
]

{ #category : #'*rSTAdd-ons' }
RSTBroker class >> startOn: anAddress port: aPort [
	"Start the service in specified address and port (no logging)"
	^ self
		startOn: anAddress 
		port: aPort 
		logging: false
		
]

{ #category : #'*rSTAdd-ons' }
RSTBroker class >> startOn: anAddress port: aPort logging: aBoolean [
	"start the Broker with the default features"
	^ self instance
			startOn: anAddress
			port: aPort
			logging: aBoolean 
		
]

{ #category : #'*rSTAdd-ons' }
RSTBroker class >> startOnPort: aPort [
	"Starts the service in default address and specified port"

	^ self 
		startOn: self defaultAddress
		port: aPort
]

{ #category : #'*rSTAdd-ons' }
RSTBroker class >> startOnPort: aPort logging: aBoolean [
	"Start in default address in the specified port and logging"
	
	^ self 
		startOn: self defaultAddress 
		port: aPort
		logging: aBoolean
]

{ #category : #'*rSTAdd-ons' }
RSTBroker class >> startUp [
	instance ifNotNil: [instance resume]
]

{ #category : #'*rSTAdd-ons' }
RSTBroker class >> stop [
	"stop the running broker"
	instance ifNotNil:[instance stop].
	instance := nil
]

{ #category : #'*rSTAdd-ons' }
RSTBroker class >> uninstall [
	"Makes the receiver to be removed from the autostart list of this image"
	Smalltalk removeFromStartUpList: self.
	Smalltalk removeFromShutDownList: self.

]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> address [
	^ address
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> address: anObject [
	address := anObject
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> addressAndPort: brokerIDString [ 
	"Parse brokerIDString to get address and port.
	Be aware of the default this receiver will use
	when not a complete broker id string is sent."
	
	| colonPos serverAddress serverPort |
	colonPos := brokerIDString findString: ':'.
	colonPos isZero
		ifTrue: [""
			serverAddress := brokerIDString.
			serverPort := self class defaultPort]
		ifFalse: [""
			serverAddress := brokerIDString first: colonPos - 1.
			serverPort := (brokerIDString allButFirst: colonPos) asInteger].
	^ {NetNameResolver addressForName: serverAddress. serverPort}
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> allProxies [
	"Answers all proxies in the receiver.
	Note: this query should be made atomically because... (?)"

	self flag: #pleaseCompleteComment.
	self isStopped ifTrue:[^ #()].
	
	^ proxiesMutex	critical: [	
		proxies values reject: [:each | each isNil]]
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> basicLogMessage: aString [
	
	self loggerMutex critical:[|file|
		[(FileDirectory default fileExists: self logFileName)
				ifTrue:[
					file := FileDirectory default oldFileNamed: self logFileName. 
					file setToEnd]
				ifFalse:[file := FileDirectory default newFileNamed: self logFileName].
			file 
				cr;
				nextPut: Character lf;
				nextPutAll: (Date today printFormat: #(3 2 1 $/ 1 1 2 ));
				space;
				nextPutAll: Time now print24;
				nextPut: $:;
				space;
				nextPutAll: aString;
				yourself] ensure:[file close]]
	
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> brokerID [
	^brokerID
]

{ #category : #maintenance }
RSTBroker >> clientSideMaintenance [
	"Notify to the remote brokers wich proxies are alive
	and delete unused remote brokers.
	Ignore if no remote brokers are detected."

	| allRemoteObjectID currentRemoteBrokers |
	allRemoteObjectID := self allProxies 
				collect: [:each | each xxxRemoteObjectID].
	currentRemoteBrokers := (allRemoteObjectID 
				collect: [:each | each brokerID]) asSet.
	self keepAliveRemoteObjects: allRemoteObjectID
		inRemoteBrokers: currentRemoteBrokers.
	lastRemoteBrokers ifNotNilDo:[:lrb|
		self releaseRemoteBrokers: (lrb copyWithoutAll: currentRemoteBrokers)].
	lastRemoteBrokers := currentRemoteBrokers
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> connectTo: brokerIDString [ 
	| addressAndPort socket |
	addressAndPort := self addressAndPort: brokerIDString.
	socket := nil.
	3 timesRepeat: 
			[socket ifNotNil: [socket closeAndDestroy].
			socket := Socket newTCP.
			
			[socket 
				connectTo: addressAndPort first
				port: addressAndPort second 
				waitForConnectionFor: self secondsToWaitForSocketConnection] 
					on: ConnectionTimedOut
					do: [:timeOutEx |
							self logException: timeOutEx.
							Processor yield].
			socket isConnected ifTrue: [^ SocketStream on: socket]].
	RSTRemoteObjectUnreachable 
		signal: 'Cannot connect to: ' , brokerIDString asString
]

{ #category : #'connection - client' }
RSTBroker >> deserializeObject: aByteArray [
	"mp 12/15/2005 16:42"
	"deserialize aByteArray to an Object"

	^ ReferenceStream unStream: aByteArray
]

{ #category : #accessing }
RSTBroker >> endingTag [
	"mp 1/6/2006 12:43"
	
	^ '<RSTEOF>'
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> export: anObject as: aString [ 
	"Exports anObject reacheable with the name aString.
	Other images will be able to send #someMessage to anObject by evaluating:  
	'aString@<serviceIP>:<port>' asLocalObject someMessage."
	
	anObject remoteType = #copy ifTrue: [
		self logWarning: ['exporting object with #remoteType = #copy (' , anObject asString , ')']].
	rememberer rememberForEver: anObject naming:aString.
	exportedObjects at: aString put: anObject.
	self logMessage: ['object: ' , anObject asString , ' exported with name:' , aString]
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> export: anObject named: aString [ 
	
	self flag: #deprecated. "use #export:as:"
	^ self export: anObject as: aString 
]

{ #category : #initialization }
RSTBroker >> initializeClientSide [
	"mp 11/27/2005 19:41"
	"initialize client side"

	proxies := WeakValueDictionary new.
	proxiesMutex := Semaphore forMutualExclusion.
	lastRemoteBrokers := #()
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> initializeLogFileName [

	^ logFileName := 'rST.log'
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> initializeLoggerMutex [

	^ loggerMutex := Mutex new
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> initializeLogging [
	
	^ logging := false
]

{ #category : #initialization }
RSTBroker >> initializeServerSide [
	"mp 11/27/2005 19:42"

	"initialize server side"
 
	exportedObjects := RSTWeakKeyManager new.
	exportedObjects onNewKey: 
			[:object :key | 
			"new exported objects will live some time, so the other images  
		can send me a notification"

			rememberer 
				remember: object
				forSeconds: 6 * 60 * 60
				naming: self brokerID].
	rememberer := RSTRememberer new
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> isStarted [
	^ status = #running
]

{ #category : #maintenance }
RSTBroker >> keepAliveRemoteObjects: allRemoteObjectID inRemoteBrokers: currentRemoteBrokers [ 
	currentRemoteBrokers do: [:remoteImage | 
		| objectsIDs |
		objectsIDs := allRemoteObjectID 
						select: [:remoteObjectID | remoteObjectID brokerID = remoteImage]
						thenCollect: [:remoteObjectID | remoteObjectID objectID].
			
		[self 
			sendExecutor: (RSTLivingReferencesExecutor 
								from: self brokerID
								objectIDs: objectsIDs)
			toBroker: remoteImage] 
		on: RSTRemoteObjectUnreachable
		do: []]
]

{ #category : #'resolving objects' }
RSTBroker >> localObjectFor: aRemoteObjectID [ 
	"answer a proxy if the reference points to other VM, otherwise answer  
	the 'real' object"
	^ self objectFor: aRemoteObjectID ifRemote: #asProxy
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> logError: aBlock [ 
	"Logs the value of aBlog as error "
	self logMessage: ['** ERROR: ' , aBlock value asString]
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> logException: aException [ 
	"Logs an Exception description as an Error"
	self logError: [aException asString , ', description:' , aException description asString]
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> logFileName [

	^ 'rST.log'
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> logMessage: aBlock [ 
	"evaluates the block and log the result (when logging is off the block is  
	not evaluated, so the code to compose the message is not evaluated)"
	self logging ifTrue:[
		self basicLogMessage: aBlock value]
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> logWarning: aBlock [ 
	"Logs the value of aBlock as warning"
	self logMessage: ['** WARNING: ' , aBlock value asString]
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> loggerMutex [
	^ loggerMutex ifNil:[self initializeLoggerMutex]
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> loggerMutex: anObject [
	loggerMutex := anObject
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> logging [
	^ logging ifNil:[self initializeLogging]
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> logging: anObject [
	logging := anObject
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> maintenance [
	"periodical maintenance task"
	self	logMessage: ['starting maintenance'].
	rememberer ifNotNilDo:[:r| r maintenance].
	self clientSideMaintenance.
	self	logMessage: ['maintenance finished']
]

{ #category : #maintenance }
RSTBroker >> maintenanceInterval [
	"answer the Interval in seconds to wait between #maintenance and  
	#maintenance"
	^ 3 * 60
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> maintenanceLoop [
	"send #maintenance between time and time, but asure (with the  
	semaphore) no workers are running"

	self flag: #deprecated.  "this creates references to the broker making hard to uninstantiate it"
	
	[(Delay forSeconds: self maintenanceInterval) wait.
	[self maintenance] forkAt: Processor highIOPriority ] repeat
]

{ #category : #'resolving objects' }
RSTBroker >> objectFor: aRemoteObjectID ifRemote: aSelector [ 
	"answer a proxy if the reference points to other VM, otherwise answer  
	the 'real' object"

	^ self brokerID = aRemoteObjectID brokerID 
		ifTrue: 
			[exportedObjects at: aRemoteObjectID objectID
				ifAbsent: [RSTObjectNotFound signal: aRemoteObjectID objectID asString]]
		ifFalse: [aRemoteObjectID perform: aSelector]
]

{ #category : #'private - running' }
RSTBroker >> pause [
	status = #running 
		ifTrue: [
			self stopMaintenancer.
			status := #paused.
			self logMessage: ['Paused!']]
		ifFalse: [self logMessage: ['Invalid pause! (status=' , status asString , ')']]
]

{ #category : #printing }
RSTBroker >> printOn: aStream [ 
	super printOn: aStream.
	aStream
		nextPutAll: ' brokerID:';
		nextPutAll: (self brokerID ifNotNilDo:[:id| id] ifNil: ['broker whitout ID']);
		nextPutAll: ' status:';
		nextPutAll: status asString
]

{ #category : #'connection - server' }
RSTBroker >> process: aSocket [ 
	"process a new open socket"
	
	| stream |
	[| executor result |
	stream := SocketStream on: aSocket.
	executor := self receiveObjectFrom: stream.
	result := executor executeIn: self.
	self sendObject: result through: stream]
		ensure: [stream close]
]

{ #category : #'connection - server' }
RSTBroker >> processRemoteMessage: aRemoteMessage [ 
	"send aRemoteMessage to the local receiver"
	
	| target localArguments |
	self logMessage: ['received remote message: "' , aRemoteMessage asString , '"'].
	target := exportedObjects
				at: aRemoteMessage to objectID
				ifAbsent: [^ RSTObjectTransporter
						exception: (RSTObjectNotFound new messageText: aRemoteMessage to objectID asString)].
	localArguments := aRemoteMessage arguments collect: [:each | each resolve].
	[| result | 
	result := target perform: aRemoteMessage selector withArguments: localArguments.
	^ self transporterFor: result]
		on: ForwardedExceptionSet
		do: [:exception | 
			self logException: exception.
			^ RSTObjectTransporter exception: (RSTRemoteException on: exception)]
]

{ #category : #'resolving objects' }
RSTBroker >> proxyFor: aRemoteObjectID [ 
	"answer a proxy for aRemoteObjectID"
	^ self proxyFor: aRemoteObjectID ifAbsent: RSTRemoteObjectProxy
]

{ #category : #'resolving objects' }
RSTBroker >> proxyFor: aRemoteObjectID ifAbsent: aProxyClass [
	"Noury Bouraqadi 9/28/2006 22:38"
	"answer a proxy for aRemoteObjectID"
	| proxy |
	proxiesMutex critical: [
		proxy := proxies at: aRemoteObjectID ifAbsent: [].
		"nil means 2 possible things:  
		1) we never creates a proxy for this RemoteObjectID.  
		2) we created a proxy, but the weak reference forget it"
		proxy isNil ifTrue: [
			proxy := aProxyClass remoteObjectID: aRemoteObjectID.
			(proxy remoteType == #copy)  "Avoid building a proxy on exported pass-by copy objects"
				ifTrue: [proxy := proxy yourself]
				ifFalse: [proxies at: aRemoteObjectID put: proxy]]].
	^ proxy
]

{ #category : #'connection - client' }
RSTBroker >> receiveObjectFrom: socketStream [ 
	"mp 1/6/2006 12:50"
	^ [self
		deserializeObject: (socketStream upToAll: self endingTag)]
		on: Exception
		do: [:ex | 
			|rstException|
			rstException := RSTRemoteObjectUnreachable new.
			rstException messageText: ex messageText.
			ex resignalAs: rstException]
]

{ #category : #maintenance }
RSTBroker >> releaseRemoteBrokers: remoteBrokers [
	"mp 12/19/2005 13:21"
	"Notify obsolete remote brokers that we don't have 
	references on them anymore"

	remoteBrokers do: [:remoteImage | 
		self 
			sendExecutor: (RSTLivingReferencesExecutor from: self brokerID objectIDs: #())
			toBroker: remoteImage]
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> remoteBroker: brokerIDString references: objectsIDsCollection [ 
	"process a notification from a remote image of referenced objects"
	| referencedObjects |
	referencedObjects := objectsIDsCollection
				collect: [:objectID | ""
					exportedObjects
						at: objectID
						ifAbsent: []].
	"forget the old objects, meanwhile the object are alive becouse  
	referencedObjects holds references"
	rememberer forgetAllNamed: brokerIDString.
	"now remember the news"
	referencedObjects
		do: [:object | "the broker has 1 day to contact me again"
			rememberer
				remember: object
				forSeconds: 24 * 60 * 60
				naming: brokerIDString]
]

{ #category : #'resolving objects' }
RSTBroker >> remoteObjectIDFor: anObject [ 
	"answer a RemoteObjectID for aObject"

	| objectID |
	objectID := exportedObjects keyFor: anObject.
	^RSTRemoteObjectID brokerID: self brokerID objectID: objectID
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> remoteValuableValue: aRemoteValuable [
	"Values aRemoteValuable and returns its answer"
	
	^ aRemoteValuable value
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> reset [
	"mp 11/27/2005 19:41"

	Socket initializeNetwork.
	brokerID := address asIpString , ':' , self portNumber asString.
	self initializeClientSide.
	self initializeServerSide.
	self startMaintenancer
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> resume [
	status = #paused
		ifTrue: [
			self startMaintenancer.
			status := #running.
			self logMessage: ['Resumed!']]
		ifFalse: [self logMessage: ['Invalid resume! (status=' , status asString , ')']]
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> runWhile: aBlock [
	"Creates the socket listener and setup myself as handler"
	[(BoundTcpListener on: address port: self portNumber handler: self)
		listenWhile: aBlock] ensure: [self unassignPort]

]

{ #category : #'connection - client - sockets' }
RSTBroker >> secondsToWaitForSocketConnection [
	^ 3
]

{ #category : #'connection - client' }
RSTBroker >> sendExecutor: anExecutor toBroker: brokerIDString [ 
	"send anExecutor to brokerIDString"

	| resultTransporter result |
	self withSocketStreamTo: brokerIDString do: [:socketStream | 
		self logMessage: [String cr , 'sending:' , anExecutor asString].
		self sendObject: anExecutor through: socketStream.
		resultTransporter := self receiveObjectFrom: socketStream].
	self logMessage: [String cr , 'answer: ' , resultTransporter asString].
	result := resultTransporter resolve.
	^result
]

{ #category : #'private - running' }
RSTBroker >> sendGoodbye [
	"notify to the remote images that I'll never user the references again"

	| remoteImages |
	remoteImages := (self allProxies 
				collect: [:each | each xxxRemoteObjectID brokerID]) asSet.
	remoteImages addAll: lastRemoteBrokers.
	[self releaseRemoteBrokers: remoteImages]
		on: RSTRemoteObjectUnreachable
		do: []
]

{ #category : #'connection - client' }
RSTBroker >> sendMessage: aMessage to: aRemoteObjectID [ 
	"send aMessage to aRemoteObjectID"
	| remoteMessage |
	remoteMessage _ RSTRemoteMessage
				message: aMessage
				to: aRemoteObjectID
				using: self.
	^ self sendExecutor: remoteMessage toBroker: aRemoteObjectID brokerID
]

{ #category : #'connection - client' }
RSTBroker >> sendObject: anExecutor through: socketStream [ 
	"mp 1/6/2006 12:49"
	
	socketStream 
		nextPutAll: (self serializeObject: anExecutor);
		nextPutAll: self endingTag;
		flush
]

{ #category : #'connection - client' }
RSTBroker >> serializeAndZipObject: anObject [
	"mp 12/15/2005 16:42"
	"serialize anObject as a GZipped ByteArray"
	
	| ref zipped |
	ref := ReferenceStream streamedRepresentationOf: anObject.
	zipped := GZipWriteStream on: ref.
	zipped nextPutAll: ref.
	zipped close.
	^ zipped
]

{ #category : #'connection - client' }
RSTBroker >> serializeObject: anObject [
	"mp 12/15/2005 16:42"
	"serialize anObject as a ByteArray"

	^ ReferenceStream streamedRepresentationOf: anObject
]

{ #category : #'connection - server' }
RSTBroker >> serve: aSocket [ 
	"this method is invoked by ConnectioHandler when a new connection is  
	established"
	[self process: aSocket]
		forkAt: Processor lowIOPriority
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> startMaintenancer [

	maintenancer := [
		"Send #maintenance to the receiver once in a while"
		[(Delay forSeconds: self maintenanceInterval) wait.
		[self maintenance] forkAt: Processor highIOPriority ] repeat] forkAt: Processor highIOPriority
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> startOn: anAddress port: anInteger logging: aBoolean [ 
	"Start the service I provide."
	
	self 
		startOn: anAddress 
		port: anInteger 
		priority: self defaultPriority
		logging: aBoolean 

]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> startOn: anAddress port: aPort priority: aPriority logging: aBoolean [ 
	"Setup and start the service I provide."

	(anAddress isKindOf: ByteArray)
		ifTrue:[address := anAddress]
		ifFalse:[ self assert: anAddress isIpAddress.
			address := NetNameResolver addressFromString: anAddress].
	portNumber := aPort.
	priority := aPriority.
	logging := aBoolean.
	self reset.

	self name: 'rST-Broker'.
	self start.
	status := #running.
	self logMessage: ['rSTBroker running as ' , self brokerID]
]

{ #category : #initialization }
RSTBroker >> startOnPort: anInteger logging: aBoolean [ 
	"start this broker"

	logging := aBoolean.

	"Start myself as a TcpService, since I subclass it"
	self initializeOnPort: anInteger priority: self defaultPriority.
	self name: 'rST-Broker'.
	self reset.
	self start.
	status := #running.
	self logMessage: ['rSTBroker running as ' , self brokerID]
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> stop [
	"Stops the receiver service."
	
	super stop.
	status := #stopped.
	
	self stopMaintenancer.

	exportedObjects ifNotNilDo:[:eo| eo depurate].
	exportedObjects := nil.
	"Purge rememberer"
	rememberer ifNotNilDo:[:r| 
		r forgetAll.
		rememberer := nil].
	
	proxies := nil.
	proxiesMutex := nil.
	lastRemoteBrokers := nil.
	
	"uncomment when connection error get handled"
	"self sendGoodbye."
	self waitForStop.
	self class removeService: self.
		
	self logMessage: ['Stopped!'].

]

{ #category : #logging }
RSTBroker >> stopLogging [
	"mp 4/26/2006 17:00"
	
	logging ifTrue: [RSTDialectIndependency instance closeLogFile]
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> stopMaintenancer [
	"Stops the maintenance process."
	
	maintenancer ifNotNilDo:[:m| m terminate].
	maintenancer := nil
]

{ #category : #'resolving objects' }
RSTBroker >> transporterFor: anObject [ 
	"answer the appropiate transporter for anObject"
	anObject isRemote ifTrue: [
		^ RSTObjectTransporter reference: anObject xxxRemoteObjectID].
	^ anObject remoteType = #copy
		ifTrue: [RSTObjectTransporter copy: anObject]
		ifFalse: [RSTObjectTransporter reference: (self remoteObjectIDFor: anObject)]
]

{ #category : #'connection - client' }
RSTBroker >> unzipAndDserializeObject: aGZippedObject [
	"mp 12/15/2005 16:42"
	"serialize anObject as a GZipped ByteArray"
	
	| ref zipped unzipped buffer |

	ref := (ReferenceStream on: ((RWBinaryOrTextStream with: ByteArray new) reset; binary)).
	
	zipped := GZipReadStream on: aGZippedObject encodedStream contents.
	unzipped := ReadStream on: zipped contents.
	"buffer := ByteArray new: 50000."
	"[unzipped atEnd] whileFalse: ["
		ref nextPutAll: "("unzipped" nextInto: buffer)]".
	"ref close."
	zipped close.
	unzipped close.
	^ ref next
]

{ #category : #'connection - client - sockets' }
RSTBroker >> withSocketStreamTo: brokerIDString do: aBlock [ 
	"mp 12/15/2005 11:02"
	"evaluate aBlock when an open socket to brokerIDString"
	| socketStream |
	socketStream := self connectTo: brokerIDString.
	[aBlock value: socketStream]
		ensure: [socketStream close]
]
