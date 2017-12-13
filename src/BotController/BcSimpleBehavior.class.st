Class {
	#name : #BcSimpleBehavior,
	#superclass : #BcBehavior,
	#category : #'BotController-Behaviors'
}

{ #category : #'initialize-release' }
BcSimpleBehavior >> defaultBodyClass [
	^BcNullTwoWheelBody
]

{ #category : #'initialize-release' }
BcSimpleBehavior >> initialize [
	super initialize.
	self body: self defaultBodyClass new.
]

{ #category : #actions }
BcSimpleBehavior >> leftSpeed: newLeftSpeed rightSpeed: newRightSpeed [
	self body leftSpeed: newLeftSpeed rightSpeed: newRightSpeed
]
