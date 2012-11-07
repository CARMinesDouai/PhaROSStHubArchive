Class {
	#name : #Capteur,
	#superclass : #Object,
	#instVars : [
		'numero',
		'valeur'
	],
	#category : #'Pure-Afficheur'
}

{ #category : #accessing }
Capteur >> numero [
	^ numero
]

{ #category : #accessing }
Capteur >> numero: anObject [
	numero := anObject
]

{ #category : #accessing }
Capteur >> valeur [
	^ valeur
]

{ #category : #accessing }
Capteur >> valeur: anObject [
	valeur := anObject
]
