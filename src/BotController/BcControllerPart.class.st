Class {
	#name : #BcControllerPart,
	#superclass : #Object,
	#instVars : [
		'controller'
	],
	#category : #'BotController-Controllers'
}

{ #category : #'instance creation' }
BcControllerPart class >> controller: aController [
	^self new
		controller: aController;
		yourself
]

{ #category : #accessing }
BcControllerPart >> body [
	^self controller body
]

{ #category : #accessing }
BcControllerPart >> controller [
	^ controller
]

{ #category : #accessing }
BcControllerPart >> controller: anObject [
	controller := anObject
]
