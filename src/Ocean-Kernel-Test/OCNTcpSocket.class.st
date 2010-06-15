Class {
	#name : #OCNTcpSocket,
	#superclass : #Object,
	#instVars : [
		'socketId',
		'isConnected',
		'isClosed',
		'alienResult',
		'alienDataBuffer'
	],
	#category : #'Ocean-Kernel'
}

{ #category : #accessing }
OCNTcpSocket >> alienDataBuffer [
	^ alienDataBuffer
]

{ #category : #accessing }
OCNTcpSocket >> alienDataBuffer: anObject [
	alienDataBuffer := anObject
]

{ #category : #accessing }
OCNTcpSocket >> alienDataBufferSize [
	^1000
]

{ #category : #accessing }
OCNTcpSocket >> alienResult [
	^ alienResult
]

{ #category : #accessing }
OCNTcpSocket >> alienResult: anObject [
	alienResult := anObject
]

{ #category : #connection }
OCNTcpSocket >> close [
	(self isClosed not & self isConnected) ifTrue: [
			self isClosed: ((OCNConstants socketLibrary close: self socketId) = 0)
	]
]

{ #category : #communication }
OCNTcpSocket >> communicationResult [
	^ self alienResult signedLongAt: 1
]

{ #category : #connection }
OCNTcpSocket >> connectToServer: serverAddress [
	| result primitiveAddress |
	primitiveAddress := serverAddress primitiveAddress.
	result := OCNConstants socketLibrary 
		connect: self socketId serverAddress: primitiveAddress serverAddressSize: serverAddress primitiveAddressSize.
	primitiveAddress free.
	(result = 0)  
		ifTrue: [
			self isConnected: true.
			self initializeAlienIVs]
		ifFalse: [self isConnected: false]
]

{ #category : #'lowlevel initialization' }
OCNTcpSocket >> createDescriptorWithDomain: communicationDomain type: socketType protocol: socketProtocol [
	| result |
	result := OCNConstants socketLibrary 
		socketDomain: communicationDomain type: socketType protocol: socketProtocol.
	self socketId: (result signedLongAt: 1)
]

{ #category : #'initialize-release' }
OCNTcpSocket >> initialize [ 
	super initialize.
	self isConnected: false.
	self isClosed: false.

]

{ #category : #'initialize-release' }
OCNTcpSocket >> initializeAlienIVs [
	self alienDataBuffer: (Alien newGC: self alienDataBufferSize + 1).
	self alienResult: (Alien newGC: 4).

]

{ #category : #connection }
OCNTcpSocket >> isClosed [
	^isClosed
]

{ #category : #testing }
OCNTcpSocket >> isClosed: anObject [
	isClosed := anObject
]

{ #category : #testing }
OCNTcpSocket >> isConnected [ 
	^isConnected
]

{ #category : #testing }
OCNTcpSocket >> isConnected: aBoolean [ 
	(aBoolean & self isClosed) ifTrue: [ 
		self isClosed: false
	].
	isConnected := aBoolean 
]

{ #category : #testing }
OCNTcpSocket >> isDescriptorCreated [
	self socketId ifNil: [^false].
	^self socketId ~= -1
]

{ #category : #communication }
OCNTcpSocket >> receive [
	self isConnected ifFalse: [Error signal: 'Socket not connected'].
	OCNConstants socketLibrary
		receiveFrom: self socketId buffer: self alienDataBuffer ofSize: self alienDataBufferSize result: self alienResult.
	self communicationResult = -1 ifTrue: [^''].
	^self alienDataBuffer strcpy
]

{ #category : #communication }
OCNTcpSocket >> send: data [
	| sentDataSize |
	self isConnected
		ifFalse: [ Error signal: 'Socket not connected' ].
	sentDataSize := data byteSize min: self alienDataBufferSize.
	self alienDataBuffer
		replaceFrom: 1
		to: sentDataSize
		with: data
		startingAt: 1.
	OCNConstants socketLibrary
		sendTo: self socketId
		buffer: self alienDataBuffer
		ofSize: sentDataSize
		withFlag: 0
		result: self alienResult.
	^ self communicationResult
]

{ #category : #accessing }
OCNTcpSocket >> socketId [
	^ socketId
]

{ #category : #accessing }
OCNTcpSocket >> socketId: anObject [
	socketId := anObject
]
