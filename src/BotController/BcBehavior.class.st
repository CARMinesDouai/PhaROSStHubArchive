Class {
	#name : #BcBehavior,
	#superclass : #Object,
	#instVars : [
		'body'
	],
	#category : #'BotController-Behaviors'
}

{ #category : #'instance creation' }
BcBehavior class >> body: aBody [
	^self new 
		body: aBody ;
		yourself
]

{ #category : #'instance creation' }
BcBehavior class >> onTurtleBot [
	^self body: BcTurtleBot
]

{ #category : #accessing }
BcBehavior >> body [
	^ body
]

{ #category : #accessing }
BcBehavior >> body: anObject [
	body := anObject
]

{ #category : #accessing }
BcBehavior >> maxForwardLateralSpeed [
	^self body maxForwardLateralSpeed
]

{ #category : #accessing }
BcBehavior >> minBackwardLateralSpeed [
	^self body minBackwardLateralSpeed
]

{ #category : #accessing }
BcBehavior >> minForwardLateralSpeed [
	^self body minForwardLateralSpeed.
]
