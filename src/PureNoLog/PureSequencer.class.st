Class {
	#name : #PureSequencer,
	#superclass : #Object,
	#instVars : [
		'currentRequestId',
		'mutex'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'PureNoLog-Kernel'
}

{ #category : #'as yet unclassified' }
PureSequencer class >> instance [
	instance ifNil: [
		instance := super new.	
	].
	^ instance.
]

{ #category : #'as yet unclassified' }
PureSequencer class >> new [
	self error: ' Use Instance instead of new!'.
]

{ #category : #'as yet unclassified' }
PureSequencer class >> reset [
	instance := nil.

]

{ #category : #'as yet unclassified' }
PureSequencer >> consumeRequestId [
	| current ret | 
	
	mutex critical: [
		current := currentRequestId.	
		self incrementRequestId.
	].

	((currentRequestId printStringBase: 16) size = 1) ifTrue: [ 
			current := ('0',(currentRequestId printStringBase: 16))asString 
	] ifFalse: [
			current := (currentRequestId printStringBase: 16)
	].
	
	
	^ current.
	

]

{ #category : #'as yet unclassified' }
PureSequencer >> incrementRequestId [
	currentRequestId := currentRequestId +1 .
	(currentRequestId >= 255) ifTrue:[
		currentRequestId := 1.
	].

]

{ #category : #'as yet unclassified' }
PureSequencer >> initialize [ 
	currentRequestId := 0.
	mutex := Mutex new.
]
