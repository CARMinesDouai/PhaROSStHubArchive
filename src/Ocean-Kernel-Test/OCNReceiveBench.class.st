Class {
	#name : #OCNReceiveBench,
	#superclass : #OCNBench,
	#category : #'Ocean-Benchmarks'
}

{ #category : #benchmarking }
OCNReceiveBench class >> timeToReceive [
	"self timeToReceive"
	|bench|
	Transcript open.
	bench := self new.
	Transcript cr; show: 'Ocean>>receive'.
	bench timeToReceiveWithOcean do: [:time|
		Transcript cr; show: time].
	Transcript cr; show: 'OldSocket>>receive'.
	bench timeToReceiveWithOldSocket do: [:time|
		Transcript cr; show: time].

]

{ #category : #server }
OCNReceiveBench >> createServerShell [ 
	| shell stdIn |
	shell := OCNFileStdInOutShell new	
		stdOutFileName: 'test.log';
		stdInFileName: 'test.in';
		yourself.
	shell deleteStdInFile.
	stdIn := FileStream fileNamed: shell stdInFileName.
	[ stdIn nextPutAll: dataToSend ] ensure: [ stdIn close ].	
	^shell

]

{ #category : #benchmarking }
OCNReceiveBench >> timeToReceiveWithOcean [
	"OCNReceiveBench new timeToReceiveWithOcean"
	| waitForData dataPacket |
	self startServer.
	self connectOceanSocket.
	[ self timeToRun: [ 
	waitForData := true.
	[ waitForData ]
		whileTrue: [
			waitForData := socket receive size > 0]] times: 10 
	]ensure: [ 
			self stopServerAndCleanUp.
			socket close ].
	^ timeToRunValues
]

{ #category : #benchmarking }
OCNReceiveBench >> timeToReceiveWithOldSocket [
]
