Trait {
	#name : #TOCNSocketSendingDataTest,
	#category : #'Ocean-Kernel-Test'
}

{ #category : #requirements }
TOCNSocketSendingDataTest >> assertSendingDataOfSize: dataSize [
	^self explicitRequirement 
]

{ #category : #requirements }
TOCNSocketSendingDataTest >> randomAsciiStringOfSize: size [
	"generate a random string of size"
	^self explicitRequirement 
]

{ #category : #requirements }
TOCNSocketSendingDataTest >> serverShell [
	^self explicitRequirement 
]

{ #category : #requirements }
TOCNSocketSendingDataTest >> socket [
	"the socket to test"
	^self explicitRequirement 
]

{ #category : #'tests sending' }
TOCNSocketSendingDataTest >> testDisconnectionWhileSending [
	self signalFailure: 'Needs non-blocking (multi-threaded FFI call or non-blocking primitives)'
]

{ #category : #'tests sending' }
TOCNSocketSendingDataTest >> testSendingLargeAmountOfDataComparedToSizeOfSocketsDataBuffer [
	self assertSendingDataOfSize: 1000 * self library defaultDataBufferSize.

]

{ #category : #'tests sending' }
TOCNSocketSendingDataTest >> testSendingLessDataThanSocketsDataBufferSize [
	self assertSendingDataOfSize: self library defaultDataBufferSize//2 .

]

{ #category : #'tests sending' }
TOCNSocketSendingDataTest >> testSendingMoreDataThanSizeOfSocketsDataBuffer [
	self assertSendingDataOfSize: 2 * self library defaultDataBufferSize.

]
