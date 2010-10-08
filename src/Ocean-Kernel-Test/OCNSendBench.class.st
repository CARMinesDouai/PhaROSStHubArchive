Class {
	#name : #OCNSendBench,
	#superclass : #OCNBench,
	#category : #'Ocean-Benchmarks'
}

{ #category : #benchmarking }
OCNSendBench class >> timeToSend [
	"self timeToSend"
	|bench|
	Transcript open.
	bench := self new.
	Transcript cr; show: 'Ocean>>Send'.
	bench timeToSendWithOcean do: [:time|
		Transcript cr; show: time].
	Transcript cr; show: 'OldSocket>>Send'.
	bench timeToSendWithOldSocket do: [:time|
		Transcript cr; show: time].

]

{ #category : #server }
OCNSendBench >> createServerShell [
	^ OCNFileStdOutShell onStdOutFileNamed: 'test.log'
]

{ #category : #benchmarking }
OCNSendBench >> timeToSendWithOcean [
	"OCNSendBench new timeToSendWithOcean"

	self startServer.
	self connectOceanSocket.
	[ self timeToRun: [ socket send: dataToSend ] ]
		ensure: [ 
			self stopServerAndCleanUp.
			socket close ].
	^ timeToRunValues
]

{ #category : #benchmarking }
OCNSendBench >> timeToSendWithOldSocket [
	"OCNBench new timeToSendWithOldSocket"

	self startServer.
	self connectOldSocket.
	[ self timeToRun: [ socket sendData: dataToSend ] ]
		ensure: [ 
			self stopServerAndCleanUp.
			socket close ].
	^ timeToRunValues
]