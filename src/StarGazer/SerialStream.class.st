Class {
	#name : #SerialStream,
	#superclass : #Object,
	#instVars : [
		'buffer',
		'position',
		'io'
	],
	#category : #'StarGazer-Stream'
}

{ #category : #construction }
SerialStream class >> defaultFor: aSerialPort [
	^ self threaded: aSerialPort.
]

{ #category : #construction }
SerialStream class >> forIO: anIOStrategy [ 
	^ self new io: anIOStrategy ; yourself.
]

{ #category : #construction }
SerialStream class >> monothread: aSerialPort [
	^ self forIO: (SSMonoThreadStrategy for: aSerialPort ).
]

{ #category : #construction }
SerialStream class >> threaded: aSerialPort [
	^ self forIO: (SSDedicatedThreadStrategy  for: aSerialPort ).
]

{ #category : #cleaup }
SerialStream >> becomeMonothread [ 
	io := io becomeMonothread.
]

{ #category : #cleaup }
SerialStream >> cleanUpBuffer [
	buffer := ''.
	position := 0.
	io cleanUpBuffer.
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
SerialStream >> io: anIOStrategy [
	io := anIOStrategy.
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
	io nextPutAll: aCharacter asString; flush.
]

{ #category : #accessing }
SerialStream >> nextPutAll: aStringOrByteArray [
	io nextPutAll: aStringOrByteArray.
]

{ #category : #accessing }
SerialStream >> readPort [
	buffer := (buffer copyFrom: position + 1 to: buffer size), io read.  
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
