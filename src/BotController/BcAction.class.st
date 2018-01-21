Class {
	#name : #BcAction,
	#superclass : #BcControllerPart,
	#category : #'BotController-Actions'
}

{ #category : #'instance creation' }
BcAction class >> controller: aController [
	^self new
		controller: aController;
		yourself
]

{ #category : #stepping }
BcAction >> perform [
	self subclassResponsibility
]

{ #category : #accessing }
BcAction >> worldModel [
	^self controller worldModel
]
