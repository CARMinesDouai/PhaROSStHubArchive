"
I am a part of a controller. I keep a reference to the controller so I can access other objects such as the body.

    Instance Variables
	controller:		<BcController>

"
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
