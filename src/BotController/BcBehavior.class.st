Class {
	#name : #BcBehavior,
	#superclass : #Object,
	#instVars : [
		'controller'
	],
	#category : #'BotController-Controllers'
}

{ #category : #accessing }
BcBehavior >> body [
	^self controller body
]

{ #category : #accessing }
BcBehavior >> controller [
	^ controller
]

{ #category : #accessing }
BcBehavior >> controller: anObject [
	controller := anObject
]

{ #category : #stepping }
BcBehavior >> step [
	self subclassResponsibility
]
