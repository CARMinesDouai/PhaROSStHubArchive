"
actor := ATActor for: TranscriptWriteActor.

actor writeALot:'hello'.

(Delay forMilliseconds: 100) wait.
actor suspend.

actor resume.
(Delay forMilliseconds: 100) wait.
actor suspend.

actor write: 'hola'.
actor write: 'hola'.

actor messages size

actor stop.
"
Class {
	#name : #TranscriptWriteActor,
	#superclass : #Object,
	#traits : 'TATActor',
	#classTraits : 'TATActor classTrait',
	#category : #'ActIT-Examples'
}

{ #category : #messages }
TranscriptWriteActor >> write: aString [

	self logCr: aString.
]

{ #category : #messages }
TranscriptWriteActor >> writeALot: aString [

	('received message ', thisContext selector printString) logCr.
	('receiver is ', self asString) logCr.
	1 to: 100 do: [ :i | self write: aString ]
]

{ #category : #messages }
TranscriptWriteActor >> writeMe [

	self logCr.
]
