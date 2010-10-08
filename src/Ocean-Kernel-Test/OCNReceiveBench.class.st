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

{ #category : #benchmarking }
OCNReceiveBench class >> timeToReceive: iterationsCount [
	"self timeToReceive: 1"
	|bench|
	Transcript open.
	bench := self new.
	bench iterationsCount: iterationsCount.
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
	[ stdIn nextPutAll: self dataToSend ] ensure: [ stdIn close ].	
	^shell

]

{ #category : #benchmarking }
OCNReceiveBench >> timeToReceiveWithOcean [
	"OCNReceiveBench new timeToReceiveWithOcean"

	| waitForData dataPacket blockToBench setUpBlock tearDownBlock |
	blockToBench := [ 
	waitForData := true.
	[ waitForData ] whileTrue: [ waitForData := socket receive size > 0 ] ].
	setUpBlock := [ 
	self startServer.
	self connectOceanSocket ].
	tearDownBlock := [ 
	self stopServerAndCleanUp.
	socket close ].
	self timeToRun: blockToBench setUpBlock: setUpBlock tearDownBlock: tearDownBlock.
	^ timeToRunValues
]

{ #category : #benchmarking }
OCNReceiveBench >> timeToReceiveWithOldSocket [
	"OCNReceiveBench new timeToReceiveWithOldSocket"

	| waitForData dataPacket blockToBench setUpBlock tearDownBlock |
	blockToBench := [ 
	waitForData := true.
	[ waitForData ] whileTrue: [ waitForData := socket receiveData size > 0 ] ].
	setUpBlock := [ 
	self startServer.
	self connectOldSocket ].
	tearDownBlock := [ 
	self stopServerAndCleanUp.
	socket close ].
	self timeToRun: blockToBench setUpBlock: setUpBlock tearDownBlock: tearDownBlock.
	^ timeToRunValues
]
