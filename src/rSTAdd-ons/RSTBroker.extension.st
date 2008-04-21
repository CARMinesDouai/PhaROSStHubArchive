Extension { #name : #RSTBroker }

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

{ #category : #'*rSTAdd-ons' }
RSTBroker classSide >> defaultAddress [
	"Answers the default ip address for the service.
	Note: to listen only localhost is the safest default 
	but is probably better not trust too much in defaults 
	and configure things consciously"
	^ '127.0.0.1' 
]

{ #category : #'*rSTAdd-ons' }
RSTBroker classSide >> defaultPort [
	"Answers the default port to listen."
	^ 9999
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
RSTBroker classSide >> export: anObject as: aString [
	"Makes anObject to be remotely accessed as aString"

	^ self instance export: anObject as: aString 
]

{ #category : #'*rSTAdd-ons' }
RSTBroker classSide >> export: anObject named: aString [ 
	
	self flag: #deprecated. "use #export:as: it has better intention revelaing"
	
	^ self export: anObject  as: aString 
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> export: anObject named: aString [ 
	
	self flag: #deprecated. "use #export:as:"
	^ self export: anObject as: aString 
]

{ #category : #'*rSTAdd-ons' }
RSTBroker classSide >> initialize [

	"Not everybody starts service in images the same way
	specially of it should be controlled or coupled 
	to external configurations (typical of production environments)"
	
	self flag: #check "use #install and #uninstall"
]

{ #category : #'*rSTAdd-ons' }
RSTBroker classSide >> initializeInstance [

	^ instance := super new

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

{ #category : #'*rSTAdd-ons' }
RSTBroker classSide >> install [
	"Makes the receiver to autostart with the image"
	Smalltalk addToStartUpList: self.
	Smalltalk addToShutDownList: self.
	ForwardedExceptionSet := ExceptionSet new.
	ForwardedExceptionSet add: Error
]

{ #category : #'*rSTAdd-ons' }
RSTBroker classSide >> instance [
	
	^ instance ifNil:[self initializeInstance]


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

{ #category : #'*rSTAdd-ons' }
RSTBroker >> remoteValuableValue: aRemoteValuable [
	"Values aRemoteValuable and returns its answer"
	
	^ aRemoteValuable value
]

{ #category : #'*rSTAdd-ons' }
RSTBroker classSide >> reset [
	self stop
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

{ #category : #'*rSTAdd-ons' }
RSTBroker classSide >> shutDown [
	instance ifNotNil:[instance pause]
]

{ #category : #'*rSTAdd-ons' }
RSTBroker classSide >> start [
	"Starts the service with defaults"
	^ self startOnPort: self defaultPort 
]

{ #category : #'*rSTAdd-ons' }
RSTBroker classSide >> startOn: anAddress port: aPort [
	"Start the service in specified address and port (no logging)"
	^ self
		startOn: anAddress 
		port: aPort 
		logging: false
		
]

{ #category : #'*rSTAdd-ons' }
RSTBroker classSide >> startOn: anAddress port: aPort logging: aBoolean [
	"start the Broker with the default features"
	^ self instance
			startOn: anAddress
			port: aPort
			logging: aBoolean 
		
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

{ #category : #'*rSTAdd-ons' }
RSTBroker classSide >> startOnPort: aPort [
	"Starts the service in default address and specified port"

	^ self 
		startOn: self defaultAddress
		port: aPort
]

{ #category : #'*rSTAdd-ons' }
RSTBroker classSide >> startOnPort: aPort logging: aBoolean [
	"Start in default address in the specified port and logging"
	
	^ self 
		startOn: self defaultAddress 
		port: aPort
		logging: aBoolean
]

{ #category : #'*rSTAdd-ons' }
RSTBroker classSide >> startUp [
	instance ifNotNil: [instance resume]
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

{ #category : #'*rSTAdd-ons' }
RSTBroker classSide >> stop [
	"stop the running broker"
	instance ifNotNil:[instance stop].
	instance := nil
]

{ #category : #'*rSTAdd-ons' }
RSTBroker >> stopMaintenancer [
	"Stops the maintenance process."
	
	maintenancer ifNotNil:[
		maintenancer terminate.
		maintenancer := nil]
]

{ #category : #'*rSTAdd-ons' }
RSTBroker classSide >> uninstall [
	"Makes the receiver to be removed from the autostart list of this image"
	Smalltalk removeFromStartUpList: self.
	Smalltalk removeFromShutDownList: self.

]
