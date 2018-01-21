Class {
	#name : #BcWorldModelBuilder,
	#superclass : #BcControllerPart,
	#instVars : [
		'worldModel'
	],
	#category : #'BotController-WorldModel'
}

{ #category : #building }
BcWorldModelBuilder >> newWorldModel [
	self subclassResponsibility
]

{ #category : #building }
BcWorldModelBuilder >> updateWorldModel [
	self worldModel: self newWorldModel
]

{ #category : #accessing }
BcWorldModelBuilder >> worldModel [
	^ worldModel
]

{ #category : #accessing }
BcWorldModelBuilder >> worldModel: anObject [
	worldModel := anObject
]
