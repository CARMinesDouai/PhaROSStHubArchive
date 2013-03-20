Class {
	#name : #SGPort,
	#superclass : #Object,
	#instVars : [
		'stream',
		'messages',
		'polling'
	],
	#category : #'StarGazer-Kernel'
}

{ #category : #construction }
SGPort class >> atPort: aPort [

	^ self new usePort: aPort; yourself.
]

{ #category : #construction }
SGPort class >> atPortId: aPortId [
	| serial |
	
	serial := SerialPort new.
	serial baudRate: self defaultBaudRate; openPort: aPortId.
	
	^ self atPort: serial. 
]

{ #category : #defaults }
SGPort class >> bufferSize [
	^100
]

{ #category : #defaults }
SGPort class >> defaultBaudRate [ 
	^ 9600
]

{ #category : #defaults }
SGPort class >> defaultPortID [ 
	^ '/dev/ttyUSB0'.
]

{ #category : #accessing }
SGPort >> initialize [ 
	messages := SharedQueue new: SGPort bufferSize.
]

{ #category : #accessing }
SGPort >> nextMessage [
	^ messages next. 
	
]

{ #category : #accessing }
SGPort >> poll [
	| message | 
	[
		message := stream readString.
		
	]
]

{ #category : #accessing }
SGPort >> usePort: aPort [ 
	stream ifNotNil: [
		polling cancel.	
	].
	stream := aPort asSGStream.
	polling := self parallelize poll. 
]
