Class {
	#name : #BcBody,
	#superclass : #Object,
	#category : #'BotController-Bodies'
}

{ #category : #acting }
BcBody >> shutDown [
	self stop
]

{ #category : #acting }
BcBody >> startUp [
	^self
]

{ #category : #acting }
BcBody >> stop [
	self subclassResponsibility
]

{ #category : #acting }
BcBody >> velocityForward: forwardSpeed [
	self velocityForward: forwardSpeed rotation: 0

]

{ #category : #acting }
BcBody >> velocityForward: forwardSpeed rotation: rotationSpeed [
	self subclassResponsibility
]

{ #category : #acting }
BcBody >> velocityRotation: rotationSpeed [
	self velocityForward: 0 rotation: rotationSpeed

]
