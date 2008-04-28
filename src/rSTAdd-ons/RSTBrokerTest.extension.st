Extension { #name : #RSTBrokerTest }

{ #category : #'*rSTAdd-ons' }
RSTBrokerTest >> defaultAddress [

	^ RSTBroker defaultAddress
]

{ #category : #'*rSTAdd-ons' }
RSTBrokerTest >> ip [
	self flag: #fix. "Decoupled from windows plattform specific code."	
	^ip ifNil: [ip := RSTBroker defaultAddress]
]

{ #category : #'*rSTAdd-ons' }
RSTBrokerTest >> setUp [

	RSTBroker reset.
	defaultBroker := RSTBroker startOn: self defaultAddress port: self defaultPort logging: true.
	extraBroker := RSTBroker basicNew.
	extraBroker 
		initialize
		startOn: self defaultAddress
		port: self extraPort 
		logging: false
]

{ #category : #'*rSTAdd-ons' }
RSTBrokerTest >> tearDown [
	
	extraBroker ifNotNilDo:[:b| b stop].
	extraBroker := nil.
	
	defaultBroker ifNotNilDo:[:b| b stop].
	defaultBroker := nil.
	
]

{ #category : #'*rSTAdd-ons' }
RSTBrokerTest >> testBasicRemoteBlock [

	|signature|
	defaultBroker export: defaultBroker named: 'rst'.
	extraBroker export: extraBroker named: 'rst'.
	
	signature := SmalltalkImage current imageName.
	self assert: ([Transcript cr; show: signature.
				thisContext assert: SmalltalkImage current imageName = signature. 
				signature] valueAt: '127.0.0.1' port: self extraPort) = SmalltalkImage current imageName
		
]

{ #category : #'*rSTAdd-ons' }
RSTBrokerTest >> testLocalObjectObtainedWithLocalHostAsRemoteBrokerId [

	| exportedObject remoteIdString retreivedObject |
	exportedObject := Object new.
	defaultBroker export: exportedObject named: 'coucou'.
	remoteIdString := 'coucou@localhost:' , self defaultPort printString.
	retreivedObject := remoteIdString asLocalObject.

	self flag: #identity.
	"Identity is inlined by VM and limited to 
	the VM space so #== is a message that has 
	no real sense for remotes.
	Identity will also fail for remotes in the same host but
	from another image."
	
	self assert: retreivedObject = exportedObject
]

{ #category : #'*rSTAdd-ons' }
RSTBrokerTest >> testStartStop [

	| expectedBrokerID |
	self assert: defaultBroker isRunning.
	self assert: extraBroker isRunning.
	RSTBroker stop.
	defaultBroker waitForStop.
	self assert: (RSTBroker instVarNamed: 'instance') isNil.
	RSTBroker startOnPort: self defaultPort.
	self assert: RSTBroker instance isRunning.
	self assert: RSTBroker instance portNumber = self defaultPort.
	expectedBrokerID := RSTBroker defaultAddress, ':', self defaultPort printString.
	self assert: RSTBroker instance brokerID = expectedBrokerID.
	RSTBroker stop.
	self assert: (RSTBroker instVarNamed: 'instance') isNil
]

{ #category : #'*rSTAdd-ons' }
RSTBrokerTest >> testWithRemoteInTemporaryRemoteBlock [

	|signature transcript|
	defaultBroker export: defaultBroker named: 'rst'.
	defaultBroker export: Transcript named: 'Transcript'.
	extraBroker export: extraBroker named: 'rst'.
	
	signature := SmalltalkImage current imageName.
	transcript := ('Transcript@127.0.0.1:', self defaultPort asString) asLocalObject.
	self assert: ([transcript cr; show: signature.
				signature] valueAt: '127.0.0.1' port: self extraPort) = SmalltalkImage current imageName

]
