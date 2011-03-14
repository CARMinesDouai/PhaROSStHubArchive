Trait {
	#name : #OCNSocketSendingDataTest,
	#category : #'Ocean-Kernel-Test'
}

{ #category : #requirements }
OCNSocketSendingDataTest >> assertSendingDataOfSize: dataSize [
	^self explicitRequirement 
]

{ #category : #requirements }
OCNSocketSendingDataTest >> randomAsciiStringOfSize: size [
	"generate a random string of size"
	^self explicitRequirement 
]

{ #category : #requirements }
OCNSocketSendingDataTest >> serverShell [
	^self explicitRequirement 
]

{ #category : #requirements }
OCNSocketSendingDataTest >> socket [
	"the socket to test"
	^self explicitRequirement 
]

{ #category : #'tests sending' }
OCNSocketSendingDataTest >> testDisconnectionWhileSending [
	self signalFailure: 'Needs non-blocking (multi-threaded FFI call or non-blocking primitives)'
]

{ #category : #'tests sending' }
OCNSocketSendingDataTest >> testSendingLargeAmountOfDataComparedToSizeOfSocketsDataBuffer [
	self assertSendingDataOfSize: 1000 * self library defaultDataBufferSize.

]

{ #category : #'tests sending' }
OCNSocketSendingDataTest >> testSendingLessDataThanSocketsDataBufferSize [
	self assertSendingDataOfSize: self library defaultDataBufferSize//2 .

]

{ #category : #'tests sending' }
OCNSocketSendingDataTest >> testSendingMoreDataThanSizeOfSocketsDataBuffer [
	self assertSendingDataOfSize: 2 * self library defaultDataBufferSize.

]
