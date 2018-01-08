Class {
	#name : #BcTwoWheelBody,
	#superclass : #Object,
	#instVars : [
		'latestLaserScan'
	],
	#category : #'BotController-Bodies'
}

{ #category : #acting }
BcTwoWheelBody >> interWheelsDistance [
	self subclassResponsibility
]

{ #category : #sensing }
BcTwoWheelBody >> latestLaserScan [
	^latestLaserScan ifNil: [ #() ]
]

{ #category : #acting }
BcTwoWheelBody >> leftSpeed: newLeftSpeed rightSpeed: newRightSpeed [
	self velocityForward: newLeftSpeed + newRightSpeed rotation: (newLeftSpeed - newRightSpeed) / self interWheelsDistance
]

{ #category : #sensing }
BcTwoWheelBody >> onLaserScanDo: aBlock [
	self subclassResponsibility
]

{ #category : #acting }
BcTwoWheelBody >> shutDown [
	self stop
]

{ #category : #sensing }
BcTwoWheelBody >> startLaserScanner [
	self onLaserScanDo: [ : echoes | latestLaserScan := echoes].

]

{ #category : #acting }
BcTwoWheelBody >> startUp [
	^self
]

{ #category : #acting }
BcTwoWheelBody >> stop [
	self velocityForward: 0 rotation: 0
]

{ #category : #sensing }
BcTwoWheelBody >> stopLaserScanner [
	self subclassResponsibility
]

{ #category : #acting }
BcTwoWheelBody >> velocityForward: forwardSpeed [
	self velocityForward: forwardSpeed rotation: 0

]

{ #category : #acting }
BcTwoWheelBody >> velocityForward: forwardSpeed rotation: rotationSpeed [
	self subclassResponsibility
]

{ #category : #acting }
BcTwoWheelBody >> velocityRotation: rotationSpeed [
	self velocityForward: 0 rotation: rotationSpeed

]
