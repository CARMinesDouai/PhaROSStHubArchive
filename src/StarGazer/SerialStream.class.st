Class {
	#name : #SerialStream,
	#superclass : #Object,
	#instVars : [
		'port',
		'buffer',
		'position'
	],
	#category : #'StarGazer-Stream'
}

{ #category : #construction }
SerialStream class >> for: aSerialPort [
	^ self new port: aSerialPort; yourself.
]

{ #category : #cleaup }
SerialStream >> cleanUpBuffer [
	buffer := ''.
	position := 0.
]

{ #category : #cleanup }
SerialStream >> cleanup [
	"10 timesRepeat: [
		position := 0.
		buffer := ''.
		self readPort.
		buffer isEmpty ifTrue: [ ^ self ].	
	].
	SGError signal: 'Error cleaning up Posible status error'.
	"
]

{ #category : #accessing }
SerialStream >> initialize [ 
	buffer := String new.
	position := 0.
]

{ #category : #accessing }
SerialStream >> next [
	^ self next: 1.
]

{ #category : #accessing }
SerialStream >> next: anAmount [
	| start ret |

	(buffer isEmpty or: [ buffer size < (position + anAmount) ] ) ifTrue: [
		self readPort.
	].
	buffer isEmpty ifTrue: [  ^ '' ].
	
	start := position + 1.
	position :=( position + anAmount) min: buffer size.
	
	ret:= buffer copyFrom: start to: position. 
	^ ret.
]

{ #category : #accessing }
SerialStream >> nextPut: aCharacter [  
	port nextPutAll: aCharacter asString; flush.
]

{ #category : #accessing }
SerialStream >> nextPutAll: aStringOrByteArray [
	Transcript show: aStringOrByteArray ; cr.
	port nextPutAll: aStringOrByteArray.
]

{ #category : #accessing }
SerialStream >> port: aSerialPort [
	port := aSerialPort 
]

{ #category : #accessing }
SerialStream >> readPort [
	buffer := (buffer copyFrom: position + 1 to: buffer size), port readString.  
	position := 0.  
	
	
]

{ #category : #accessing }
SerialStream >> upTo: anObject [ 
	"fast version using indexOf:"
	| start end intent |
	
	intent := 0.
	[
		end := buffer indexOfSubCollection: anObject startingAt: position + 1 ifAbsent: [ 0 ].
		end = 0 and: [ intent < 10 ].
	] whileTrue: [
		intent := intent + 1. 
		self readPort.
	].

	(end = 0 or: [end = (position + 1)]) ifTrue: [ ^ ''].

	start := position + 1.
	position := end.

	
	^buffer copyFrom: start to: (end-1)
	





]
