Class {
	#name : #BcAction,
	#superclass : #Object,
	#instVars : [
		'controller'
	],
	#category : #'BotController-Controllers'
}

{ #category : #'instance creation' }
BcAction class >> controller: aController [
	^self new
		controller: aController;
		yourself
]

{ #category : #accessing }
BcAction >> body [
	^self controller body
]

{ #category : #accessing }
BcAction >> controller [
	^ controller
]

{ #category : #accessing }
BcAction >> controller: anObject [
	controller := anObject
]

{ #category : #stepping }
BcAction >> step [
	self subclassResponsibility
]

{ #category : #accessing }
BcAction >> worldModel [
	^self controller worldModel
]
