Class {
	#name : #SGStream,
	#superclass : #Object,
	#instVars : [
		'serialStream'
	],
	#category : #'StarGazer-Kernel'
}

{ #category : #'as yet unclassified' }
SGStream class >> for: aSerialStream [ 
	^ self new serialStream: aSerialStream; yourself.
]

{ #category : #cleanup }
SGStream >> cleanup [
	serialStream cleanup.
]

{ #category : #'as yet unclassified' }
SGStream >> nextMessage [ 
	^ self nextMessage: 100.
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
SGStream >> nextPutCommand: aCommand [ 
	^ self nextPutMessage: SGProtocol typeWrite, 
								aCommand.
]

{ #category : #'as yet unclassified' }
SGStream >> nextPutMessage: aMessageString [
	^ serialStream nextPutAll: SGProtocol messageStart, aMessageString, SGProtocol messageEnd.
]

{ #category : #'as yet unclassified' }
SGStream >> nextPutReadFor: aParameterOrCommand [
	^ self nextPutMessage: SGProtocol typeRead, aParameterOrCommand.
]

{ #category : #'as yet unclassified' }
SGStream >> nextPutWrite: aStringValue for: aParameter [  
	^ self nextPutMessage: SGProtocol typeWrite, 
								aParameter, 
								SGProtocol separator, 
								aStringValue.
]

{ #category : #'as yet unclassified' }
SGStream >> serialStream: aSerialStream [
	serialStream := aSerialStream 
]
