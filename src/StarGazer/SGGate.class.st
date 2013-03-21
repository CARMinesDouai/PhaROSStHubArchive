Class {
	#name : #SGGate,
	#superclass : #Object,
	#instVars : [
		'stream',
		'messages',
		'polling'
	],
	#category : #'StarGazer-Kernel'
}

{ #category : #construction }
SGGate class >> atPort: aPort [

	^ self new usePort: aPort; yourself.
]

{ #category : #construction }
SGGate class >> atPortId: aPortId [
	| serial |
	
	serial := SerialPort new.
	serial baudRate: self defaultBaudRate; openPort: aPortId.
	
	^ self atPort: serial. 
]

{ #category : #defaults }
SGGate class >> bufferSize [
	^100
]

{ #category : #defaults }
SGGate class >> defaultBaudRate [ 
	^ 9600
]

{ #category : #defaults }
SGGate class >> defaultPortID [ 
	^ '/dev/ttyUSB0'.
]

{ #category : #accessing }
SGGate >> get: aParameterName [
	| return  | 
	stream nextPutReadFor: aParameterName.
	
	return := stream nextMessage.
	self halt. 
]

{ #category : #accessing }
SGGate >> hasMessages [
	^ messages size > 0
]

{ #category : #accessing }
SGGate >> initialize [ 
	messages := SharedQueue new.
]

{ #category : #accessing }
SGGate >> nextMessage [
	^ messages next. 
	
]

{ #category : #accessing }
SGGate >> poll [
	[  self singlePoll. ] repeat.
]

{ #category : #accessing }
SGGate >> set: aParameterName with: aValue [
	| message |
	stream nextPutWrite: aParameterName for: aValue.
	stream nextMessage 
]

{ #category : #accessing }
SGGate >> singlePoll [
	| message | 
	
	messages add: stream nextMessage.
	
]

{ #category : #accessing }
SGGate >> startCalculations [
	| return  | 
	stream nextPutCommand: SGProtocol commandCalcStart.
	
	return := stream nextMessage.
	self halt. 
]

{ #category : #accessing }
SGGate >> stopCalculations [
	| return  | 
	stream nextPutCommand: SGProtocol commandCalcStop.
	
	return := stream nextMessage.
	self halt. 
]

{ #category : #accessing }
SGGate >> usePort: aPort [ 
	stream ifNotNil: [
		polling cancel.	
	].
	stream := aPort asSGStream.
	"polling := self parallelize poll."
]
