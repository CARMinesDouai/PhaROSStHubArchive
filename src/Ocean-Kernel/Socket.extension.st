Extension { #name : #Socket }

{ #category : #'*Ocean-Kernel-TestSupport' }
Socket >> initialize: socketType withBufferOfSize: n [
	"Initialize a new socket handle. If socket creation fails, socketHandle will be set to nil."

	| semaIndex readSemaIndex writeSemaIndex |
	semaphore := Semaphore new.
	readSemaphore := Semaphore new.
	writeSemaphore := Semaphore new.
	semaIndex := Smalltalk registerExternalObject: semaphore.
	readSemaIndex := Smalltalk registerExternalObject: readSemaphore.
	writeSemaIndex := Smalltalk registerExternalObject: writeSemaphore.
	socketHandle := self
		primSocketCreateNetwork: 0
		type: socketType
		receiveBufferSize: n
		sendBufSize: n
		semaIndex: semaIndex
		readSemaIndex: readSemaIndex
		writeSemaIndex: writeSemaIndex.
	socketHandle isNil
		ifTrue: [ 
			"socket creation failed"
			Smalltalk unregisterExternalObject: semaphore.
			Smalltalk unregisterExternalObject: readSemaphore.
			Smalltalk unregisterExternalObject: writeSemaphore.
			readSemaphore := writeSemaphore := semaphore := nil ]
		ifFalse: [ self register ]
]

{ #category : #'*Ocean-Kernel-TestSupport' }
Socket class >> newUDPWithBufferOfSize: n [
	"Create a socket and initialise it for UDP"
	self initializeNetwork.
	^[ super new initialize: UDPSocketType withBufferOfSize: n ]
		repeatWithGCIf: [ :socket | socket isValid not ]
]

{ #category : #'*Ocean-Kernel-TestSupport' }
Socket >> primSocketBind: socketID to: anIntFromIPAddress port: aPortNumber [
	<primitive: 'primitiveSocketBindToPort' module: 'SocketPlugin'>
	self primitiveFailed
]
