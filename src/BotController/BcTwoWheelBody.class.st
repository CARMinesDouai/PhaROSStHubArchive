Class {
	#name : #BcTwoWheelBody,
	#superclass : #BcBody,
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
