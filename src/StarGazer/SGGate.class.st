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

{ #category : #'high level protocol' }
SGGate >> get: aParameterName [
	| return  | 
	stream nextPutReadFor: aParameterName.
	
	return := stream nextMessage.
	self halt. 
]

{ #category : #consuming }
SGGate >> hasMessages [
	^ messages size > 0
]

{ #category : #'initialize-release' }
SGGate >> initialize [ 
	messages := SharedQueue new.
]

{ #category : #consuming }
SGGate >> nextMessage [
	^ messages next. 
	
]

{ #category : #producing }
SGGate >> poll [
	[  self singlePoll. ] repeat.
]

{ #category : #'high level protocol' }
SGGate >> set: aParameterName with: aValue [
	| message |
	stream nextPutWrite: aParameterName for: aValue.
	stream nextMessage 
]

{ #category : #producing }
SGGate >> singlePoll [
	| message | 
	
	messages nextPut: stream nextMessage.
	
]

{ #category : #'high level protocol' }
SGGate >> startCalculations [
	| return  | 
	stream nextPutCommand: SGProtocol commandCalcStart.

	" check the messages queue "
	self halt.
]

{ #category : #service }
SGGate >> startPolling [
	polling ifNotNil: [
		polling cancel.
	].
	polling := self paralellize poll.
]

{ #category : #'high level protocol' }
SGGate >> stopCalculations [
	| return  | 
	stream nextPutCommand: SGProtocol commandCalcStop.
	
	
	self halt. 
	" check the messages queue "
]

{ #category : #service }
SGGate >> stopPolling [
	polling ifNotNil: [
		polling cancel.
		polling := nil.
	].
]

{ #category : #'initialize-release' }
SGGate >> usePort: aPort [ 
	stream ifNotNil: [
		polling cancel.	
	].
	stream := aPort asSGStream.
	
]
