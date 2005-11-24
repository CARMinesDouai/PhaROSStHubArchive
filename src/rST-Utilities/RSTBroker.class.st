"
I'm the door to other image and the door for other images to come in.

"
Class {
	#name : #RSTBroker,
	#superclass : #Object,
	#instVars : [
		'status',
		'port',
		'logging',
		'brokerID',
		'proxies',
		'proxiesMutex',
		'lastRemoteBrokers',
		'exportedObjects',
		'rememberer',
		'connectionHandler',
		'maintenancer'
	],
	#classInstVars : [
		'instance'
	],
	#category : 'rST-Core'
}

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
	^ instance isNil
		ifTrue: [self error: 'RSTBroker not started! (see methods in category "running")']
		ifFalse: [instance]
]

{ #category : #'instance creation' }
RSTBroker class >> new [
	self error: 'you must use #instance'
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
	instance notNil
		ifTrue: [instance stop].
	instance _ nil
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

{ #category : #maintenance }
RSTBroker >> clientSideMaintenance [
	"notify to the remote brokers wich proxies are alive"
	| allRemoteObjectID currentRemoteBrokers |
	allRemoteObjectID _ self allProxies
				collect: [:each | each xxxRemoteObjectID].
	currentRemoteBrokers _ (allRemoteObjectID
				collect: [:each | each brokerID]) asSet.
	""
	currentRemoteBrokers
		do: [:remoteImage | 
			| objectsIDs | 
			objectsIDs _ allRemoteObjectID
						select: [:remoteObjectID | remoteObjectID brokerID = remoteImage]
						thenCollect: [:remoteObjectID | remoteObjectID objectID].
			self
				sendExecutor: (RSTLivingReferencesExecutor from: brokerID objectIDs: objectsIDs)
				toBroker: remoteImage].
	""
	(lastRemoteBrokers copyWithoutAll: currentRemoteBrokers)
		do: [:remoteImage | ""
			self
				sendExecutor: (RSTLivingReferencesExecutor from: brokerID objectIDs: #())
				toBroker: remoteImage].
	lastRemoteBrokers _ currentRemoteBrokers
]

{ #category : #'connection - client - sockets' }
RSTBroker >> connectTo: brokerIDString [ 
	"open a socket to brokerIDString"
	| addressAndPort socket |
	addressAndPort := self addressAndPort: brokerIDString.
	""
	socket := nil.
	3
		timesRepeat: [""
			socket notNil
				ifTrue: [socket closeAndDestroy].
			socket := OldSocket new.
			socket connectTo: addressAndPort first port: addressAndPort second.
			socket
				waitForConnectionUntil: (OldSocket deadlineSecs: 2).
			socket isConnected
				ifTrue: [^ socket]].
	RSTRemoteObjectUnreachable signal: 'Can''t connect to: ' , brokerIDString asString
]

{ #category : #'connection - server' }
RSTBroker >> export: anObject named: aString [ 
	"export anObject with name aString, so other squeaks can connect to  
	anObject with:  
	remoteObject _ 'aString@localip:port' asRemoteObjectID asLocalObject."
	anObject remoteType == #copy
		ifTrue: [self
				logWarning: ['exporting object with #remoteType == #copy (' , anObject asString , ')']].
	rememberer rememberForEver: anObject naming:aString.
	exportedObjects at: aString put: anObject.
	self
		logMessage: ['object: ' , anObject asString , ' exported with name:' , aString]
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
	^ brokerID = aRemoteObjectID brokerID
		ifTrue: [exportedObjects
			at: aRemoteObjectID objectID
			ifAbsent: [RSTObjectNotFound signal: aRemoteObjectID objectID asString]]
		ifFalse: [aRemoteObjectID perform: aSelector]
]

{ #category : #'private - running' }
RSTBroker >> pause [
	status == #running
		ifTrue: [""
			self stopNetwork.
			""
			status _ #paused.
			self
				logMessage: ['Paused!']]
		ifFalse: [""self
				logMessage: ['Invalid pause! (status=' , status asString , ')']]
]

{ #category : #printing }
RSTBroker >> printOn: aStream [ 
	super printOn: aStream.
	aStream nextPutAll: ' brokerID:';
		 nextPutAll: brokerID asString;
		nextPutAll:' status:'; nextPutAll: status asString
]

{ #category : #'connection - server' }
RSTBroker >> process: aSocket [ 
	"process a new open socket"
	[| executor result | 
	executor _ aSocket getObject.
	result _ executor executeIn: self.
	aSocket sendObject: result]
		ensure: [""
			aSocket closeAndDestroy]
]

{ #category : #'connection - server' }
RSTBroker >> processRemoteMessage: aRemoteMessage [ 
	"send aRemoteMessage to the local receiver"
	| target localArguments |
	self
		logMessage: ['received remote message: ' , aRemoteMessage asString].
	target _ exportedObjects
				at: aRemoteMessage to objectID
				ifAbsent: [^ RSTObjectTransporter
						exception: (RSTObjectNotFound new messageText: aRemoteMessage to objectID asString)].
	""
	localArguments _ aRemoteMessage arguments
				collect: [:each | each resolve].
	[| result | 
	result _ target perform: aRemoteMessage selector withArguments: localArguments.
	^ self transporterFor: result]
		on: Exception
		do: [:exception | 
			self logException: exception.
			^ RSTObjectTransporter
				exception: (RSTRemoteException on: exception)]
]

{ #category : #'resolving objects' }
RSTBroker >> proxyFor: aRemoteObjectID [ 
	"answer a proxy for aRemoteObjectID"
	^ self proxyFor: aRemoteObjectID ifAbsent: RSTRemoteObjectProxy
]

{ #category : #'resolving objects' }
RSTBroker >> proxyFor: aRemoteObjectID ifAbsent: aProxyClass [
	"answer a proxy for aRemoteObjectID"
	| proxy |
	proxiesMutex critical: [
		proxy := proxies at: aRemoteObjectID ifAbsent: [].
		"nil means 2 possible things:  
		1) we never creates a proxy for this RemoteObjectID.  
		2) we created a proxy, but the weak reference forget it"
		proxy isNil ifTrue: [
			proxy := aProxyClass remoteObjectID: aRemoteObjectID.
			proxies at: aRemoteObjectID put: proxy]].
	^ proxy
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

	objectID _ exportedObjects keyFor: anObject.
	^ RSTRemoteObjectID brokerID: brokerID objectID: objectID
]

{ #category : #initialization }
RSTBroker >> reset [
	OldSocket initializeNetwork.
	brokerID := NetNameResolver localAddressString , ':' , port asString.

	" 
	initialize client side"
	proxies := WeakValueDictionary new.
	proxiesMutex := Semaphore forMutualExclusion.
	lastRemoteBrokers := #().
	" 
	initialize server side"
	exportedObjects := WeakKeyManager new.
	exportedObjects
		onNewKey: [:object :key | " 
			new exported objects will live some time, so the other images  
			can send me a notification"
			rememberer
				remember: object
				forSeconds: 6 * 60 * 60
				naming: brokerID].
	rememberer := RSTRememberer new.
	""
	self startNetwork
]

{ #category : #'private - running' }
RSTBroker >> resume [
	status == #paused
		ifTrue: [""
			self startNetwork.
			""
			status _ #running.
			self
				logMessage: ['Resumed!']]
		ifFalse: [""
			self
				logMessage: ['Invalid resume! (status=' , status asString , ')']]
]

{ #category : #'connection - client' }
RSTBroker >> sendExecutor: anExecutor toBroker: brokerIDString [ 
	"send anExecutor to brokerIDString"
	| resultTransporter result |
	self
		logMessage: ['sending:' , anExecutor asString].
	self
		withSocketTo: brokerIDString
		do: [:socket | 
			socket sendObject: anExecutor.
			resultTransporter _ socket getObject].
	self
		logMessage: ['sending:' , anExecutor asString , ' answer: ' , resultTransporter asString].
	result _ resultTransporter resolve.
	^ result
]

{ #category : #'private - running' }
RSTBroker >> sendGoodbye [
	"notify to the remote images that I'll never user the references again"
	| remoteImages |
	remoteImages _ (self allProxies
				collect: [:each | each xxxRemoteObjectID brokerID]) asSet.
	remoteImages addAll: lastRemoteBrokers.
	""
	remoteImages
		do: [:remoteImage | ""
			"TODO: ignore posible errors"
			self
				sendExecutor: (RSTLivingReferencesExecutor from: brokerID objectIDs: #())
				toBroker: remoteImage]
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

{ #category : #'private - running' }
RSTBroker >> startConnectionHandler [
	connectionHandler _ RSTConnectionHandler
				onPort: port
				handler: self
				priority: Processor highIOPriority.
	connectionHandler start.
]

{ #category : #'private - running' }
RSTBroker >> startMaintenancer [
maintenancer _ [self maintenanceLoop]
				forkAt: Processor highIOPriority
]

{ #category : #'private - running' }
RSTBroker >> startNetwork [

	self startMaintenancer.
	self startConnectionHandler
]

{ #category : #running }
RSTBroker >> startOnPort: portInteger logging: loggingBoolean [ 
	"start this broker"
	port _ portInteger.
	logging _ loggingBoolean.
	""
	self reset.
	""
	status _ #running.
	self
		logMessage: ['rSTBroker running as ' , brokerID asString]
]

{ #category : #'private - running' }
RSTBroker >> stop [
	"PRIVATE: use RSTBroker stop"
	self stopNetwork.
	"
	uncomment when connection error get handled
	self sendGoodbye."
	status _ #stoped.
	self
		logMessage: ['Stoped!']
]

{ #category : #'private - running' }
RSTBroker >> stopConnectionHandler [
	connectionHandler isNil
		ifFalse: [""
			connectionHandler stop.
			connectionHandler _ nil]
]

{ #category : #'private - running' }
RSTBroker >> stopMaintenancer [
maintenancer isNil ifFalse:[""
	maintenancer terminate.
	maintenancer _ nil]
]

{ #category : #'private - running' }
RSTBroker >> stopNetwork [
	self stopMaintenancer.

	self stopConnectionHandler
]

{ #category : #'resolving objects' }
RSTBroker >> transporterFor: anObject [ 
	"answer the appropiate transporter for anObject"
	anObject isRemote
		ifTrue: [^ RSTObjectTransporter reference: anObject xxxRemoteObjectID].
	^ anObject remoteType == #copy
		ifTrue: [RSTObjectTransporter copy: anObject]
		ifFalse: [RSTObjectTransporter
				reference: (self remoteObjectIDFor: anObject)]
]

{ #category : #'connection - server' }
RSTBroker >> value: aSocket [ 
	"this method is invoked by ConnectioHandler when a new connection is  
	established"
	[self process: aSocket]
		forkAt: Processor lowIOPriority
]

{ #category : #'connection - client - sockets' }
RSTBroker >> withSocketTo: brokerIDString do: aBlock [ 
	"evaluate aBlock when an open socket to brokerIDString"
	| socket |
	socket _ self connectTo: brokerIDString.
	[aBlock value: socket]
		ensure: [socket closeAndDestroy]
]
