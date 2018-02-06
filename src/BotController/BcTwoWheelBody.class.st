"
I am a two wheeld robot body. My motion is performed by controlling the rotation of two driving wheels.

Public API and Key Messages

- lastLaserScan: 

    Instance Variables
	latestLaserScan:		<Collection of PNGLaserEcho>


"
Class {
	#name : #BcTwoWheelBody,
	#superclass : #BcBody,
	#instVars : [
		'latestLaserScan'
	],
	#category : #'BotController-Bodies'
}

{ #category : #'instance creation' }
BcTwoWheelBody class >> robulab [
	^self new
		dimensions: BcTwoWheelBodyDimensions robulab;
		yourself
]

{ #category : #'instance creation' }
BcTwoWheelBody class >> turtleBot [
	^self new
		dimensions: BcTwoWheelBodyDimensions turtleBot;
		yourself
]

{ #category : #accessing }
BcTwoWheelBody >> interWheelsDistance [
	^self dimensions interWheelsDistance
]

{ #category : #accessing }
BcTwoWheelBody >> laserToSideDistance [
	^self dimensions laserToSideDistance
]

{ #category : #sensing }
BcTwoWheelBody >> latestLaserScan [
	^latestLaserScan ifNil: [ #() ]
]

{ #category : #sensing }
BcTwoWheelBody >> latestLaserScan: echoes [
	latestLaserScan := echoes.
	self announce: (BcLaserScanAnnouncement echoes: echoes)
]

{ #category : #acting }
BcTwoWheelBody >> leftSpeed: newLeftSpeed rightSpeed: newRightSpeed [
	| annoucement |
	annoucement := BcSpeedLeftRightAnnouncement left: newLeftSpeed right: newRightSpeed.
	self announce: annoucement.
	self velocityForward: newLeftSpeed + newRightSpeed rotation: (newLeftSpeed - newRightSpeed) / self interWheelsDistance
]

{ #category : #sensing }
BcTwoWheelBody >> onLaserScanDo: aBlock [
	self subscribe: BcLaserScanAnnouncement do: aBlock
]

{ #category : #sensing }
BcTwoWheelBody >> startLaserScanner [
	self subclassResponsibility

]

{ #category : #sensing }
BcTwoWheelBody >> stopLaserScanner [
	self subclassResponsibility
]
