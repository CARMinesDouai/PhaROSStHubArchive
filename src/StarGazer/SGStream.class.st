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

{ #category : #'as yet unclassified' }
SGStream >> nextMessage [ 
	| message |
	
	" Find the begin of message mark "
	serialStream upTo: SGProtocol messageStart.
	
	" consume it "
	serialStream next.
	
	"Make a message with the content"
   ^ SGMessage for: (serialStream upTo: SGProtocol messageEnd).

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
