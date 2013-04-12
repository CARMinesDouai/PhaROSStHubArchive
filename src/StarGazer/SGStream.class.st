Class {
	#name : #SGStream,
	#superclass : #Object,
	#instVars : [
		'serialStream'
	],
	#category : #'StarGazer-Stream'
}

{ #category : #'as yet unclassified' }
SGStream class >> for: aSerialStream [ 
	^ self new serialStream: aSerialStream; yourself.
]

{ #category : #clean }
SGStream >> cleanUpBuffer [
	serialStream cleanUpBuffer
]

{ #category : #cleanup }
SGStream >> cleanup [
	serialStream cleanup.
]

{ #category : #reading }
SGStream >> nextMessage [ 
	^ self nextMessage: 100.
]

{ #category : #reading }
SGStream >> nextMessage: anAmmountOfTimes [ 
	| message times | 
	
	times := 0.	
	 [ 
		times := times + 1.
		message := self nextMessageOrNoMessage. 
	] doWhileTrue: [
		
		((message = SGMessage NoMessage) ifTrue: [ (Delay forMilliseconds: 100) wait. true. ] ifFalse: [ false ]) and: [ times < anAmmountOfTimes]. 
	].
	
	message = SGMessage NoMessage ifTrue: [ SGError signal: 'Timeout'].
	
	^ message.
]

{ #category : #reading }
SGStream >> nextMessageOrNoMessage [
	| message start  |
	
	" Find the begin of message mark "
	serialStream upTo: SGProtocol messageStart.
	
	" consume it "
	start := serialStream next.
	
	(start = SGProtocol messageStart) ifFalse: [
		" if the token is not the expected, can be that is nothing to read, or maybe that there was nothing in the bus and suddenly something appeared"
		message:= (start isEmpty or: [ start = nil ]) ifTrue: [
			SGMessage NoMessage.
		] ifFalse: [
			self nextMessage.		
		]
	] ifTrue: [
		" If its the expected token, then i just build a message with the content "
		message := SGMessage for: (serialStream upTo: SGProtocol messageEnd).
	].

	^ message.
	
	" The close message mark will be consumed by the next upTo call." 
	


]

{ #category : #writing }
SGStream >> nextPutCommand: aCommand [ 
	^ self nextPutMessage: SGProtocol typeWrite, 
								aCommand.
]

{ #category : #writing }
SGStream >> nextPutMessage: aMessageString [
	^ serialStream nextPutAll: SGProtocol messageStart, aMessageString, SGProtocol messageEnd.
]

{ #category : #writing }
SGStream >> nextPutReadFor: aParameterOrCommand [
	^ self nextPutMessage: SGProtocol typeRead, aParameterOrCommand.
]

{ #category : #writing }
SGStream >> nextPutWrite: aStringValue for: aParameter [  
	^ self nextPutMessage: SGProtocol typeWrite, 
								aParameter, 
								SGProtocol separator, 
								aStringValue asString.
]

{ #category : #accessing }
SGStream >> serialStream: aSerialStream [
	serialStream := aSerialStream 
]
