Class {
	#name : #RobulabMessage,
	#superclass : #Object,
	#instVars : [
		'responseArray',
		'robulab',
		'idRequete',
		'target'
	],
	#category : #'Pure-Robulab'
}

{ #category : #'initialize-release' }
RobulabMessage class >> initializeFromArray:  tableau [
	| response |
	response := RobulabResponse new.
	response responseArray: (response correctResponse: tableau ).
	((response responseArray at: 1)= 'FF')ifTrue:[
		^RobulabNotification initializeFromArray: tableau.
		]ifFalse:[
		^RobulabResponse initializeFromArray: tableau.
		].
]

{ #category : #'as yet unclassified' }
RobulabMessage >> correctResponse: tableau [
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

{ #category : #accessing }
RobulabMessage >> idRequete [
	^ idRequete
]

{ #category : #accessing }
RobulabMessage >> idRequete: anObject [
	idRequete := anObject
]

{ #category : #'initialize-release' }
RobulabMessage >> initializeFromArray: anArray [
	
]

{ #category : #'initialize-release' }
RobulabMessage >> isNotification [
	^(self idRequete = 'FF')
]

{ #category : #accessing }
RobulabMessage >> responseArray [
	^ responseArray
]

{ #category : #accessing }
RobulabMessage >> responseArray: anObject [
	responseArray := anObject
]

{ #category : #accessing }
RobulabMessage >> robulab [
	^ robulab
]

{ #category : #accessing }
RobulabMessage >> robulab: anObject [
	robulab := anObject
]

{ #category : #accessing }
RobulabMessage >> target [
	^ target
]

{ #category : #accessing }
RobulabMessage >> target: anObject [
	target := anObject
]
