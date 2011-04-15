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
	timeOutCounter := 10.
	delay := (Delay forMilliseconds: 150) wait.
	[aSocketStream isDataAvailable] whileFalse: [
		timeOutCounter = 0 ifTrue: [self error: self className, 'TimeOut waiting for data'].
		timeOutCounter := timeOutCounter - 1.
		delay wait].
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
