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

{ #category : #'as yet unclassified' }
OCNBench class >> initialize [ 
	randomStringsDict := Dictionary new
]

{ #category : #benchmarking }
OCNBench >> connectOceanSocket [
	| library serverAddress |
	socket := OCNConversationTcpSocket new.
	library := OCNNetworkLibraryProxyFactory networkLibraryProxy.
	serverAddress := OCNIPV4SocketAddress loopbackAddressWithPort:  self serverPort.	"localhost should have a server"
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

	| fileStream randomString shorterSize sizeToGenerate sizeAlreadyExisting existingString index |
	
	sizeToGenerate := self randomStringSize.
	
	randomStringsDict isEmpty ifTrue: [ | sizeToReadFromFile|
		sizeToReadFromFile := sizeToGenerate min: 2000.
		"retrieve random string from source file"
		fileStream := (StandardFileStream readOnlyFileNamed: Smalltalk changesName).
		[ randomString := (fileStream next: sizeToReadFromFile) ] ensure: [ fileStream close].	
		
		"replace non-ascii characters"
		randomString withIndexDo: [ :v :i | ((randomString at: i) asciiValue > 127) ifTrue: [ randomString at: i put: $a ] ].
		randomStringsDict at: sizeToReadFromFile put: randomString
	].
	
	randomStringsDict 
		at: sizeToGenerate 
		ifPresent: [:value| self dataToSend: value. ^self].
			
	sizeAlreadyExisting := randomStringsDict keys max.
	existingString := randomStringsDict at: sizeAlreadyExisting.
		
	randomString := ByteString new: sizeToGenerate.
	index := 0.
			
	 [ index < sizeToGenerate ] whileTrue: [ |sizeToCopy|
		sizeToCopy := sizeToGenerate - index.
		sizeToCopy := sizeToCopy min: sizeAlreadyExisting.
			
		randomString replaceFrom: index + 1
			to: index + sizeToCopy
			with: existingString
			startingAt: 1.
		index := index + sizeToCopy.
	].
		
	self dataToSend: randomString.
	randomStringsDict at: sizeToGenerate put: randomString

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
