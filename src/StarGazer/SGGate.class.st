Class {
	#name : #SGGate,
	#superclass : #Object,
	#instVars : [
		'stream',
		'state',
		'landMarkReadingCallback'
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
	^ '/dev/ttyUSB1'.
]

{ #category : #announcing }
SGGate >> announceLandMarkReading [
	(landMarkReadingCallback ifNil:[[]]) cull: self.
]

{ #category : #clean }
SGGate >> cleanUpBuffer [
	stream cleanUpBuffer.
]

{ #category : #'high level protocol' }
SGGate >> command: aParameterName with: aValue [
	^ self state command: aParameterName with: aValue.
]

{ #category : #'high level protocol' }
SGGate >> finalize [
	state finalize.
]

{ #category : #'high level protocol' }
SGGate >> get: aParameterName [
	^ self state get: aParameterName.
	
]

{ #category : #consuming }
SGGate >> hasMessages [
	^ state hasMessages.
]

{ #category : #consuming }
SGGate >> nextMessage [
		^ state nextMessage.
	
]

{ #category : #announcing }
SGGate >> onLandMarkReading: aBlock [
	landMarkReadingCallback := aBlock.
]

{ #category : #'high level protocol' }
SGGate >> set: aParameterName with: aValue [
	^ self state set: aParameterName with: aValue.
]

{ #category : #'high level protocol' }
SGGate >> startCalculating [
	^ self state startCalculating.
]

{ #category : #builf }
SGGate >> startMapBuilding [
	self command:  SGProtocol mapMode with: 'Start'.
	self state startMapBuilding.
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
SGGate >> stopCalculating [
	^ self state stopCalculating .
]

{ #category : #accessing }
SGGate >> stream [
	^ stream
]

{ #category : #'initialize-release' }
SGGate >> usePort: aPort [ 
	stream ifNotNil: [
		self stopCalculating.
	].
	stream := aPort asSGStream.
	
]
