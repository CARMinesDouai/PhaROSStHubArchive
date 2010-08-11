"
I'm the Transporter for Objects that are parameters or results of messages sendings.
"
Class {
	#name : #RSTObjectTransporter,
	#superclass : #Object,
	#instVars : [
		'type',
		'object',
		'resolved'
	],
	#category : #'rST-Core'
}

{ #category : #'instance creation' }
RSTObjectTransporter class >> copy: anObject [ 
	"creates a Transporter for a copy of anObject "
	^ self new initializeObject: anObject type: #copy
]

{ #category : #'instance creation' }
RSTObjectTransporter class >> exception: anException [ 
	"creates a Transporter for anException "
	^ self new initializeObject: anException type: #exception
]

{ #category : #'instance creation' }
RSTObjectTransporter class >> reference: aRemoteObjectID [ 
	"creates a Transporter for a reference to aRemoteObjectID"
	^ self new initializeObject: aRemoteObjectID type: #reference
]

{ #category : #initialization }
RSTObjectTransporter >> initializeObject: anObject type: aSymbol [
	object := anObject.
	type := aSymbol
]

{ #category : #printing }
RSTObjectTransporter >> printOn: aStream [ 
	"super printOn: aStream."
	aStream 
		"nextPutAll: ' ';"
		nextPutAll: type asString;
		nextPutAll: ' = ''';
		nextPutAll: object asString;
		nextPut: $'
]

{ #category : #accessing }
RSTObjectTransporter >> resolve [
	"resolve the transported object for local use"
	^ type caseOf: {
		[#reference] -> [object asLocalObject].
		[#copy] -> [object].
		[#exception] -> [object signal]}
]
