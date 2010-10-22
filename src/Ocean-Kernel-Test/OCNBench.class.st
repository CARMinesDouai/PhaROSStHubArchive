Class {
	#name : #OCNBench,
	#superclass : #Object,
	#instVars : [
		'socket',
		'serverShell',
		'dataToSend',
		'timeToRunValues',
		'iterationsCount',
		'randomStringSize'
	],
	#classVars : [
		'randomStringsDict'
	],
	#category : #'Ocean-Benchmarks'
}

{ #category : #'class initialization' }
OCNBench class >> initialize [ 
	randomStringsDict := Dictionary new
]

{ #category : #benchmarking }
OCNBench >> connectOceanSocket [
	| library serverAddress |
	socket := OCNTcpSocket new.
	library := OCNNetworkLibraryProxyFactory networkLibraryProxy.
	serverAddress := OCNIPV4SocketAddress new.
	serverAddress
		family: library AfInet;
		ip: #[127 0 0 1];
		port: self serverPort.	"localhost should have a server"
	socket connectToServer: serverAddress
]

{ #category : #benchmarking }
OCNBench >> connectOldSocket [
	| serverAddress |
	socket := Socket newTCP.
	serverAddress := NetNameResolver addressForName: '127.0.0.1'.
	socket connectTo: serverAddress port: self serverPort
]

{ #category : #'initialize-release' }
OCNBench >> createRandomString [
	| allCharacters dataToSendStream |
	randomStringsDict 
		at: self randomStringSize 
		ifPresent: [:value| ^self dataToSend: value].
	allCharacters := Character alphabet.
	dataToSendStream := WriteStream on: (String new: self randomStringSize).
	self randomStringSize timesRepeat: [ dataToSendStream nextPut: allCharacters atRandom ].
	self dataToSend: dataToSendStream contents.
	randomStringsDict at: self randomStringSize put: self dataToSend

]

{ #category : #'initialize-release' }
OCNBench >> createRandomStringOfSize: dataSize [
	self randomStringSize: dataSize.
	self createRandomString.
	^self dataToSend
]

{ #category : #server }
OCNBench >> createServerShell [ 
	self subclassResponsibility 
]

{ #category : #accessing }
OCNBench >> dataToSend [
	^ dataToSend
]

{ #category : #accessing }
OCNBench >> dataToSend: anObject [
	^ dataToSend := anObject
]

{ #category : #'initialize-release' }
OCNBench >> defaultIterationsCount [
	^10
]

{ #category : #'initialize-release' }
OCNBench >> initialize [ 
	super initialize.
	self createRandomString.
	self iterationsCount: self defaultIterationsCount
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
OCNBench >> randomStringSize [
	^randomStringSize ifNil: [randomStringSize := 10000000]
]

{ #category : #accessing }
OCNBench >> randomStringSize: anObject [
	^ randomStringSize := anObject
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
