Class {
	#name : #SGPort,
	#superclass : #Object,
	#instVars : [
		'port'
	],
	#category : #'StarGazer-Kernel'
}

{ #category : #construction }
SGPort class >> atPort: aPort [

	^ self new port: aPort; yourself.
]

{ #category : #construction }
SGPort class >> atPortId: aPortId [
	| serial |
	
	serial := SerialPort new.
	serial baudRate: self defaultBaudRate; openPort: aPortId.
	
	^ self atPort: serial. 
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
SGPort >> nextMessage [
	port readString.
]

{ #category : #accessing }
SGPort >> port: aPort [ 
	port := aPort.
]
