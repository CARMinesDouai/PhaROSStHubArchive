Class {
	#name : #OCNSocket,
	#superclass : #Object,
	#instVars : [
		'socketId',
		'isConnected',
		'isClosed'
	],
	#category : #'Ocean-Kernel'
}

{ #category : #connection }
OCNSocket >> close [
	(self isClosed not & self isConnected) ifTrue: [
			self isClosed: ((OCNConstants socketLibrary close: self socketId) = 0)
	]
]

{ #category : #connection }
OCNSocket >> connectToServer: serverAddress [
	| result primitiveAddress |
	primitiveAddress := serverAddress primitiveAddress.
	result := OCNConstants socketLibrary 
		connect: self socketId serverAddress: primitiveAddress serverAddressSize: serverAddress primitiveAddressSize.
	primitiveAddress free.
	(result = 0)  
		ifTrue: [self isConnected: true]
		ifFalse: [self isConnected: false]
]

{ #category : #'lowlevel initialization' }
OCNSocket >> createDescriptorWithDomain: communicationDomain type: socketType protocol: socketProtocol [
	| result |
	result := OCNConstants socketLibrary 
		socketDomain: communicationDomain type: socketType protocol: socketProtocol.
	self socketId: (result signedLongAt: 1)
]

{ #category : #'initialize-release' }
OCNSocket >> initialize [ 
	super initialize.
	self isConnected: false.
	self isClosed: false.
]

{ #category : #connection }
OCNSocket >> isClosed [
	^isClosed
]

{ #category : #testing }
OCNSocket >> isClosed: anObject [
	isClosed := anObject
]

{ #category : #testing }
OCNSocket >> isConnected [ 
	^isConnected
]

{ #category : #testing }
OCNSocket >> isConnected: aBoolean [ 
	(aBoolean & self isClosed) ifTrue: [ 
		self isClosed: false
	].
	isConnected := aBoolean 
]

{ #category : #testing }
OCNSocket >> isDescriptorCreated [
	self socketId ifNil: [^false].
	^self socketId ~= -1
]

{ #category : #communication }
OCNSocket >> send: data [
	| alienedData result |
	self isConnected ifFalse: [Error signal: 'Socket not connected'].
	alienedData := data asAlien.
	result := OCNConstants socketLibrary
		sendTo: self socketId buffer: alienedData ofSize: data byteSize withFlag: 0.
	alienedData free.
	^result
]

{ #category : #accessing }
OCNSocket >> socketId [
	^ socketId
]

{ #category : #accessing }
OCNSocket >> socketId: anObject [
	socketId := anObject
]
