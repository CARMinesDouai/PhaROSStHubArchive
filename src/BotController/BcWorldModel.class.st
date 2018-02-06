"
I represent a world model built on every Sense step of a Sense-Plan-Act robot controller
"
Class {
	#name : #BcWorldModel,
	#superclass : #Object,
	#category : #'BotController-WorldModel'
}

{ #category : #'initialize-release' }
BcWorldModel >> initialize [
	super initialize.
	self reset.
]

{ #category : #'initialize-release' }
BcWorldModel >> reset [
	^self
]
