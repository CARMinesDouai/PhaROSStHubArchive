Trait {
	#name : #OCNTSocketSendingDataTest,
	#category : #'Ocean-Kernel-Test'
}

{ #category : #requirements }
OCNTSocketSendingDataTest >> assertSendingDataOfSize: dataSize [
	^self explicitRequirement 
]

{ #category : #requirements }
OCNTSocketSendingDataTest >> randomAsciiStringOfSize: size [
	"generate a random string of size"
	^self explicitRequirement 
]

{ #category : #requirements }
OCNTSocketSendingDataTest >> serverShell [
	^self explicitRequirement 
]

{ #category : #requirements }
OCNTSocketSendingDataTest >> socket [
	"the socket to test"
	^self explicitRequirement 
]

{ #category : #'tests sending' }
OCNTSocketSendingDataTest >> testDisconnectionWhileSending [
	self signalFailure: 'Needs non-blocking (multi-threaded FFI call or non-blocking primitives)'
]

{ #category : #'tests sending' }
OCNTSocketSendingDataTest >> testSendingLargeAmountOfDataComparedToSizeOfSocketsDataBuffer [
	self assertSendingDataOfSize: 1000 * self library defaultDataBufferSize.

]

{ #category : #'tests sending' }
OCNTSocketSendingDataTest >> testSendingLessDataThanSocketsDataBufferSize [
	self assertSendingDataOfSize: self library defaultDataBufferSize//2 .

]

{ #category : #'tests sending' }
OCNTSocketSendingDataTest >> testSendingMoreDataThanSizeOfSocketsDataBuffer [
	self assertSendingDataOfSize: 2 * self library defaultDataBufferSize.

]
