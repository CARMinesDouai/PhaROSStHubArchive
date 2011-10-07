Class {
	#name : #OCNBench,
	#superclass : #Object,
	#instVars : [
		'socket',
		'serverShell',
		'timeToRunValues',
		'iterationsCount',
		'stringGenerator'
	],
	#category : #'Ocean-Benchmarks'
}

{ #category : #benchmarking }
OCNBench >> connectOceanSocket [
	| library serverAddress |
	socket := OCNConversationTcpSocket new.
	library := OCNNetworkLibraryProxyFactory networkLibraryProxy.
	serverAddress := OCNIpv4Address loopbackAddressWithPort:  self serverPort.	"localhost should have a server"
	socket connectToServer: serverAddress
]

{ #category : #benchmarking }
OCNBench >> connectOldSocket [
	| serverAddress |
	socket := Socket newTCP.
	serverAddress := NetNameResolver addressForName: '127.0.0.1'.
	socket connectTo: serverAddress port: self serverPort
]

{ #category : #server }
OCNBench >> createServerShell [ 
	self subclassResponsibility 
]

{ #category : #'initialize-release' }
OCNBench >> dataToSend [ 
	^self stringGenerator dataToSend 
]

{ #category : #'initialize-release' }
OCNBench >> defaultIterationsCount [
	^10
]

{ #category : #'initialize-release' }
OCNBench >> initialize [ 
	super initialize.
	self iterationsCount: self defaultIterationsCount.
]

{ #category : #accessing }
OCNBench >> iterationsCount [
	^ iterationsCount
]

{ #category : #accessing }
OCNBench >> iterationsCount: anObject [
	iterationsCount := anObject
]

{ #category : #'initialize-release' }
OCNBench >> resetTimeToRunValues [
	timeToRunValues := OrderedCollection new
]

{ #category : #server }
OCNBench >> serverPort [
	^9123
]

{ #category : #server }
OCNBench >> startServer [
	serverShell := self createServerShell.
	serverShell exec: 'nc -4 -l ' , self serverPort printString.
	(Delay forMilliseconds: 100) wait
]

{ #category : #server }
OCNBench >> stopServer [ 
	serverShell kill ; waitForStop 
]

{ #category : #server }
OCNBench >> stopServerAndCleanUp [ 
	serverShell 
		kill;
		deleteStdOutFile
]

{ #category : #accessing }
OCNBench >> stringGenerator [
	^ stringGenerator
]

{ #category : #accessing }
OCNBench >> stringGenerator: anObject [
	stringGenerator := anObject
]

{ #category : #benchmarking }
OCNBench >> timeToRun: aBlock [
	self timeToRun: aBlock setUpBlock: [  ] tearDownBlock: [  ]
]

{ #category : #benchmarking }
OCNBench >> timeToRun: aBlock setUpBlock: setUpBlock tearDownBlock: tearDownBlock. [
	self resetTimeToRunValues.
	self iterationsCount timesRepeat: [ 
		setUpBlock value.
		[
			timeToRunValues add: [aBlock value] timeToRun
		] ensure: tearDownBlock
	]
]
