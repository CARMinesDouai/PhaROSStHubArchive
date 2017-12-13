Class {
	#name : #BcRosTwoWheelBody,
	#superclass : #BcTwoWheelBody,
	#instVars : [
		'velocityPublisher'
	],
	#category : #'BotController-Body'
}

{ #category : #actions }
BcRosTwoWheelBody >> velocityForward: forwardSpeed rotation: rotationSpeed [
	self velocityPublisher
		send: [ :aTwist | 
			aTwist linear x: forwardSpeed.
			aTwist angular z: rotationSpeed ]
]

{ #category : #accessing }
BcRosTwoWheelBody >> velocityPublisher [
	^ velocityPublisher
]

{ #category : #accessing }
BcRosTwoWheelBody >> velocityPublisher: anObject [
	velocityPublisher := anObject
]
