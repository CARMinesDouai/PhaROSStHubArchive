Class {
	#name : #BcBehaviorOLD,
	#superclass : #Object,
	#instVars : [
		'body'
	],
	#category : #'BotController-OLD-Behaviors'
}

{ #category : #'instance creation' }
BcBehaviorOLD class >> body: aBody [
	^self new 
		body: aBody ;
		yourself
]

{ #category : #'instance creation' }
BcBehaviorOLD class >> onTurtleBot [
	^self body: BcTurtleBot
]

{ #category : #accessing }
BcBehaviorOLD >> body [
	^ body
]

{ #category : #accessing }
BcBehaviorOLD >> body: anObject [
	body := anObject
]

{ #category : #accessing }
BcBehaviorOLD >> maxForwardLateralSpeed [
	^self body maxForwardLateralSpeed
]

{ #category : #accessing }
BcBehaviorOLD >> minBackwardLateralSpeed [
	^self body minBackwardLateralSpeed
]

{ #category : #accessing }
BcBehaviorOLD >> minForwardLateralSpeed [
	^self body minForwardLateralSpeed.
]
