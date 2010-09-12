Class {
	#name : #OCNBench,
	#superclass : #Object,
	#instVars : [
		'socket',
		'serverShell',
		'dataToSend',
		'timeToRunValues'
	],
	#category : #'Ocean-Benchmarks'
}

{ #category : #benchmarking }
OCNBench >> connectOceanSocket [
	| library serverAddress |
	socket := OCNTcpSocket new.
	library := OCNConstants socketLibrary.
	socket createDescriptorWithDomain: library PfInet type: library SockStream protocol: library IpProtoTcp.
	serverAddress := OCNIPV4SocketAddress new.
	serverAddress
		family: library AfInet;
		ip: #[127 0 0 1];
		port: self serverPort.	"localhost should have a server"
	socket connectToServer: serverAddress
]

{ #category : #'initialize-release' }
OCNBench >> createRandomString [
	| allCharacters dataToSendStream |
	allCharacters := Character alphabet.
	dataToSendStream := WriteStream on: (String new: self randomStringSize).
	self randomStringSize timesRepeat: [ dataToSendStream nextPut: allCharacters atRandom ].
	dataToSend := dataToSendStream contents.

]

{ #category : #server }
OCNBench >> createServerShell [ 
	self subclassResponsibility 
]

{ #category : #'initialize-release' }
OCNBench >> initialize [ 
	super initialize.
	self createRandomString
]

{ #category : #'initialize-release' }
OCNBench >> randomStringSize [
	^10000000
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
	serverShell kill
]

{ #category : #server }
OCNBench >> stopServerAndCleanUp [ 
	serverShell 
		kill;
		deleteStdOutFile
]

{ #category : #benchmarking }
OCNBench >> timeToRun: aBlock times: iterationsCount [
	self resetTimeToRunValues.
	iterationsCount timesRepeat: [ timeToRunValues add: [aBlock value] timeToRun ]
]
