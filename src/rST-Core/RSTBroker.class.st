"
I'm the door to other image and the door for other images to come in.

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
		'resolved'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'rST-Core'
}

{ #category : #'connection - server' }
RSTBroker class >> export: anObject named: aString [ 
	"Noury Bouraqadi 10/3/2006 23:57"
	
	self instance export: anObject named: aString 

]

{ #category : #'initialize-release' }
RSTBroker class >> initialize [
	"
	RSTBroker initialize
	"
	Smalltalk addToStartUpList: self.
	Smalltalk addToShutDownList: self
]

{ #category : #'instance creation' }
RSTBroker class >> instance [
	"answer the broker singleton"
	^ instance 
		ifNil: [self error: 'RSTBroker not started! (see methods in category "running")']
		ifNotNil: [instance]
]

{ #category : #'instance creation' }
RSTBroker class >> new [
	self error: 'you must use #instance'
]

{ #category : #running }
RSTBroker class >> reset [
	self stop.
	RSTBroker services do: [:s| 
		s unregister.
		s waitForStop].

]

{ #category : #snapshots }
RSTBroker class >> shutDown [
	instance isNil ifFalse:[instance pause]
]

{ #category : #running }
RSTBroker class >> start [
	"start the Broker in the defalut port with the default features"
	^ self startOnPort: 9999
]

{ #category : #running }
RSTBroker class >> startOnPort: portInteger [ 
	"start the Broker with the default features"
	^ self
		startOnPort: portInteger
		logging: false
		
]

{ #category : #running }
RSTBroker class >> startOnPort: portInteger logging: loggingBoolean [
	"start the Broker with full control of features"
	self stop.
	^ instance _ super new
				startOnPort: portInteger
				logging: loggingBoolean
]

{ #category : #snapshots }
RSTBroker class >> startUp [
	instance isNil
		ifFalse: [instance resume]
]

{ #category : #running }
RSTBroker class >> stop [
	"stop the running broker"
	instance ifNotNil: [
		instance unregister.
		instance waitForStop].
	instance := nil
]

{ #category : #'connection - client - sockets' }
RSTBroker >> addressAndPort: brokerIDString [ 
	"parses brokerIDString and get address and port"
	| colonPos serverAddress serverPort |
	colonPos _ brokerIDString findString: ':'.
	colonPos isZero
		ifTrue: [""
			serverAddress _ brokerIDString.
			serverPort _ '9999']
		ifFalse: [""
			serverAddress _ brokerIDString first: colonPos - 1.
			serverPort _ brokerIDString allButFirst: colonPos].
	^ {NetNameResolver addressForName: serverAddress. serverPort asInteger}
]

{ #category : #'resolving objects' }
RSTBroker >> allProxies [
	"anser a collection with all proxies"
	| allProxies |
	proxiesMutex
		critical: [""
			allProxies _ proxies values
						reject: [:each | each isNil]].
	^ allProxies
]

{ #category : #accessing }
RSTBroker >> brokerID [
	^brokerID
]

{ #category : #maintenance }
RSTBroker >> clientSideMaintenance [
	"notify to the remote brokers wich proxies are alive
	and delete unused remote brokers"

	| allRemoteObjectID currentRemoteBrokers |
	allRemoteObjectID := self allProxies 
				collect: [:each | each xxxRemoteObjectID].
	currentRemoteBrokers := (allRemoteObjectID 
				collect: [:each | each brokerID]) asSet.
	self keepAliveRemoteObjects: allRemoteObjectID
		inRemoteBrokers: currentRemoteBrokers.
	self releaseRemoteBrokers: (lastRemoteBrokers 
				copyWithoutAll: currentRemoteBrokers).
	lastRemoteBrokers := currentRemoteBrokers
]

{ #category : #'connection - client - sockets' }
RSTBroker >> connectTo: brokerIDString [
	"Noury Bouraqadi 9/21/2006 16:15" 
	"open a socket to brokerIDString"
	| addressAndPort socket |
	addressAndPort := self addressAndPort: brokerIDString.
	socket := nil.
	3 timesRepeat: [
		socket ifNotNil: [socket closeAndDestroy].
		socket := Socket newTCP.
		[socket 
			connectTo: addressAndPort first 
			port: addressAndPort second] 
		on: ConnectionTimedOut do: [:timeOutEx|
				self logException: timeOutEx.
				(Delay forMilliseconds: 100) wait].
		socket isConnected ifTrue: [^ SocketStream on: socket]].
	RSTRemoteObjectUnreachable signal: 'Cannot connect to: ' , brokerIDString asString
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

{ #category : #'connection - server' }
RSTBroker >> export: anObject named: aString [ 
	"export anObject with name aString, so other squeaks can connect to  
	anObject with:  
	remoteObject _ 'aString@localip:port' asRemoteObjectID asLocalObject."
	anObject remoteType = #copy ifTrue: [
		self logWarning: ['exporting object with #remoteType = #copy (' , anObject asString , ')']].
	rememberer rememberForEver: anObject naming:aString.
	exportedObjects at: aString put: anObject.
	self logMessage: ['object: ' , anObject asString , ' exported with name:' , aString]
]

{ #category : #initialization }
RSTBroker >> initializeClientSide [
	"mp 11/27/2005 19:41"
	"initialize client side"

	proxies := WeakValueDictionary new.
	proxiesMutex := Semaphore forMutualExclusion.
	lastRemoteBrokers := #()
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

{ #category : #logging }
RSTBroker >> logError: aBlock [ 
	"logs an error message"
	self
		logMessage: ['** ERROR: ' , aBlock value asString]
]

{ #category : #logging }
RSTBroker >> logException: aException [ 
	"logs an Exception as an Error"
	self
		logError: [aException asString , ', description:' , aException description asString]
]

{ #category : #logging }
RSTBroker >> logMessage: aBlock [ 
	"evaluates the block and log the result (when logging is off the block is  
	not evaluated, so the code to compose the message is not evaluated)"
	logging
		ifTrue: [RSTDialectIndependency instance logMessage: aBlock]
]

{ #category : #logging }
RSTBroker >> logWarning: aBlock [ 
	"log a warning message"
	self
		logMessage: ['** WARNING: ' , aBlock value asString]
]

{ #category : #maintenance }
RSTBroker >> maintenance [
	"periodical maintenance task"
	self
		logMessage: ['starting maintenance'].
	rememberer maintenance.
	self clientSideMaintenance.
	self
		logMessage: ['maintenance finished']
]

{ #category : #maintenance }
RSTBroker >> maintenanceInterval [
	"answer the Interval in seconds to wait between #maintenance and  
	#maintenance"
	^ 3 * 60
]

{ #category : #maintenance }
RSTBroker >> maintenanceLoop [
	"send #maintenance between time and time, but asure (with the  
	semaphore) no workers are running"
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
		nextPutAll: self brokerID;
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
		on: Exception
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

{ #category : #'connection - server' }
RSTBroker >> remoteBroker: brokerIDString references: objectsIDsCollection [ 
	"process a notification from a remote image of referenced objects"
	| referencedObjects |
	referencedObjects _ objectsIDsCollection
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

{ #category : #initialization }
RSTBroker >> reset [
	"mp 11/27/2005 19:41"

	Socket initializeNetwork.
	brokerID := NetNameResolver localAddressString , ':' , self portNumber asString.
	self initializeClientSide.
	self initializeServerSide.
	self startMaintenancer
]

{ #category : #'private - running' }
RSTBroker >> resume [
	status = #paused
		ifTrue: [
			self startMaintenancer.
			status := #running.
			self logMessage: ['Resumed!']]
		ifFalse: [self logMessage: ['Invalid resume! (status=' , status asString , ')']]
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

{ #category : #'private - running' }
RSTBroker >> startMaintenancer [
maintenancer _ [self maintenanceLoop]
				forkAt: Processor highIOPriority
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

{ #category : #'private - running' }
RSTBroker >> stop [
	"PRIVATE: use RSTBroker stop"
	super stop.
	self stopMaintenancer.
	"uncomment when connection error get handled"
	"self sendGoodbye."
	status := #stopped.
	self logMessage: ['Stopped!'].
	self stopLogging
]

{ #category : #logging }
RSTBroker >> stopLogging [
	"mp 4/26/2006 17:00"
	
	logging ifTrue: [RSTDialectIndependency instance closeLogFile]
]

{ #category : #'private - running' }
RSTBroker >> stopMaintenancer [
maintenancer ifNotNil:[
	maintenancer terminate.
	maintenancer := nil]
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
