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
SGStream >> serialStream: aSerialStream [
	serialStream := aSerialStream 
]
