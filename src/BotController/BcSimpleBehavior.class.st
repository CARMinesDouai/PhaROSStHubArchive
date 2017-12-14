Class {
	#name : #BcSimpleBehavior,
	#superclass : #BcBehaviorOLD,
	#category : #'BotController-OLD-Behaviors'
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
