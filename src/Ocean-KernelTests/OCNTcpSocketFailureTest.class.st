Class {
	#name : #OCNTcpSocketFailureTest,
	#superclass : #OCNTcpConversationSocketTest,
	#category : #'Ocean-KernelTests'
}

{ #category : #accessing }
OCNTcpSocketFailureTest >> serverClass [
	^OCNActAfterConnectionTcpServerForTest 
]

{ #category : #testing }
OCNTcpSocketFailureTest >> testDisconnectionWhileReceiving [
	| dataSize dataToSend sendSocket |
	dataSize := 100 * socket receiveDataBufferSize. 
	dataToSend := self randomAsciiStringOfSize: dataSize.
	self startServerAndValue: [:server|
		server afterConnectionDo: [:serverSocket|
			sendSocket := serverSocket.
			serverSocket sendData: dataToSend].
		socket connectToServer: server address.
		sendSocket closeAndDestroy.
		self should: [[self socket receive] repeat] raise: Error.
		self assert: self socket isDestroyed.
	]
]

{ #category : #testing }
OCNTcpSocketFailureTest >> testDisconnectionWhileSending [
	| dataSize dataToSend receptionStream |
	dataSize := 100 * socket receiveDataBufferSize. 
	dataToSend := self randomAsciiStringOfSize: dataSize.
	self startServerAndValue: [:server|
		server afterConnectionDo: [:serverSocket|
			serverSocket receiveSomeData. 
			serverSocket closeAndDestroy].
		socket connectToServer: server address.
		self should: [self socket send: dataToSend] raise: OCNTimeOutError.
		self assert: self socket isDestroyed
	] 
]

{ #category : #testing }
OCNTcpSocketFailureTest >> testSocketCreationFailure [
	|tooMuchSockets|
	"self signalFailure: 'make the whole image unsuable because of the Semaphore max limit'. "
	tooMuchSockets := Set new.
	self should: [
		500 timesRepeat: [tooMuchSockets add: self socketClass new]
	] raise: OCNSocketOperationFailureError.
	tooMuchSockets removeAll.
	Smalltalk garbageCollect.
	self shouldnt: [ self socketClass new ] 
		raise: OCNSocketOperationFailureError.
]

{ #category : #testing }
OCNTcpSocketFailureTest >> testSocketRestoredAtImageStartup [
	<expectedFailure>
	self signalFailure: 'socket restored in the same state when image startup'
]
