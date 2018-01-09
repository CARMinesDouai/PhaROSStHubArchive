Class {
	#name : #BcRunner,
	#superclass : #Object,
	#instVars : [
		'controller'
	],
	#category : #'BotController-Controllers'
}

{ #category : #'instance creation' }
BcRunner class >> controller: aController [
	^self new
		controller: aController;
		yourself
]

{ #category : #accessing }
BcRunner >> controller [
	^ controller
]

{ #category : #accessing }
BcRunner >> controller: anObject [
	controller := anObject
]

{ #category : #living }
BcRunner >> start [
	self subclassResponsibility 
]

{ #category : #living }
BcRunner >> stop [
	self subclassResponsibility 
]
