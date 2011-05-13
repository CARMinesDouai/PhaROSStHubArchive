Class {
	#name : #OCNTcpReceivingServerForTest,
	#superclass : #OCNTcpServerForTest,
	#instVars : [
		'receivedData'
	],
	#category : #'Ocean-Kernel-TestSupport'
}

{ #category : #'initialize-release' }
OCNTcpReceivingServerForTest >> initialize [ 
	super initialize.
	receivedData := String new
]

{ #category : #accessing }
OCNTcpReceivingServerForTest >> interactThrough: aSocketStream [
	|delay timeOutCounter |
	delay := (Delay forMilliseconds: 150).
	[aSocketStream isDataAvailable] whileFalse: [ delay wait. ].
	[aSocketStream  isDataAvailable] whileTrue: 
			[aSocketStream socket dataAvailable ifTrue: [aSocketStream receiveData].
			receivedData := receivedData,  aSocketStream nextAllInBuffer.
			delay wait.
			].

]

{ #category : #accessing }
OCNTcpReceivingServerForTest >> receivedData [
	^receivedData
]
