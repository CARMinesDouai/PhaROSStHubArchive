Class {
	#name : #SGGate,
	#superclass : #Object,
	#instVars : [
		'stream',
		'messages',
		'state'
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

{ #category : #consuming }
SGGate >> deployMessage: aMessage [
	^ messages nextPut: aMessage. 
	
]

{ #category : #'high level protocol' }
SGGate >> get: aParameterName [
	^ self state get: aParameterName.
	
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

{ #category : #consuming }
SGGate >> nextMessageOrNoMessage [
	
	^ messages next ifNil:[ SGMessage NoMessage ].
]

{ #category : #'high level protocol' }
SGGate >> set: aParameterName with: aValue [
	^ self state set: aParameterName with: aValue.
]

{ #category : #'high level protocol' }
SGGate >> startCalculations [
	^ self state startCalculating.
]

{ #category : #accessing }
SGGate >> state [ 
	^ state
]

{ #category : #accessing }
SGGate >> state: aState [
	state := aState.
]

{ #category : #'high level protocol' }
SGGate >> stopCalculations [
	^ self state stopCalculating .
]

{ #category : #accessing }
SGGate >> stream [
	^ stream
]

{ #category : #'initialize-release' }
SGGate >> usePort: aPort [ 
	stream ifNotNil: [
		self stopCalculations.
	].
	stream := aPort asSGStream.
	state := SGStopped for: self.
	state command: SGProtocol commandCalcStop.
]
