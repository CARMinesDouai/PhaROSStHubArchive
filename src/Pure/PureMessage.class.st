Class {
	#name : #PureMessage,
	#superclass : #Object,
	#instVars : [
		'responseArray',
		'target'
	],
	#category : #'Pure-Messages'
}

{ #category : #'initialize-release' }
PureMessage class >> correctResponse: tableau [
	| correction index |
	correction := Array  new: (tableau size ) .
	index :=1.
	tableau do: [:contenu | 
				correction at:index put: ((contenu asInteger )printStringBase:16).
				index:= index+1. 
				].
	index :=1.
	correction := correction do: [:contenu | 
				(contenu size=1) ifTrue: [correction at: index put: ('0',contenu value) asString ]ifFalse: [correction at: index put: (contenu value)asString ] .
				index:= index+1.
			].
	^correction 
]

{ #category : #'initialize-release' }
PureMessage class >> initializeFromArray:  tableau [
	| response |
	response := PureResponse new.
	response responseArray: (self correctResponse: tableau ).
	((response responseArray at: 1)= 'FF')ifTrue:[
		^PureNotification initializeFromArray: tableau.
		]ifFalse:[
		^PureResponse initializeFromArray: tableau.
		].
]

{ #category : #accessing }
PureMessage >> responseArray [
	^ responseArray
]

{ #category : #accessing }
PureMessage >> responseArray: anObject [
	responseArray := anObject
]

{ #category : #accessing }
PureMessage >> target [
	^ target
]

{ #category : #accessing }
PureMessage >> target: anObject [
	target := anObject
]
