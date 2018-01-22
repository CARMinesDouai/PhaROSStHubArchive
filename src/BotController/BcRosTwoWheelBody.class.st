Class {
	#name : #BcRosTwoWheelBody,
	#superclass : #BcTwoWheelBody,
	#instVars : [
		'velocityPublisher',
		'laserSubscriber'
	],
	#category : #'BotController-Bodies'
}

{ #category : #sensing }
BcRosTwoWheelBody >> startLaserScanner [
	self shouldBeImplemented
]

{ #category : #sensing }
BcRosTwoWheelBody >> stopLaserScanner [
	self shouldBeImplemented
]

{ #category : #acting }
BcRosTwoWheelBody >> velocityForward: newForwardSpeed rotation: newRotationSpeed [
	self velocityPublisher
		send: [ :aTwist | 
			aTwist linear x: newForwardSpeed.
			aTwist angular z: newRotationSpeed ].
	super velocityForward: newForwardSpeed rotation: newRotationSpeed
]

{ #category : #accessing }
BcRosTwoWheelBody >> velocityPublisher [
	^ velocityPublisher
]

{ #category : #accessing }
BcRosTwoWheelBody >> velocityPublisher: anObject [
	velocityPublisher := anObject
]
