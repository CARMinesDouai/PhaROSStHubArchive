Class {
	#name : #EtatLongerMur,
	#superclass : #Etat,
	#instVars : [
		'thread',
		'distance',
		'positionDepart'
	],
	#category : #IronMines
}

{ #category : #'as yet unclassified' }
EtatLongerMur >> action [
	self initiliserObjectif.
	self thread: self newThread.
	self thread resume
]

{ #category : #position }
EtatLongerMur >> initialiserObjectif [
	positionDepart:= self kobuki odom position.
]
