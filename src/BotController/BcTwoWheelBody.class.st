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

{ #category : #acting }
BcTwoWheelBody >> leftSpeed: newLeftSpeed rightSpeed: newRightSpeed [
	self velocityForward: newLeftSpeed + newRightSpeed rotation: (newLeftSpeed - newRightSpeed) / self interWheelsDistance
]

{ #category : #sensing }
BcTwoWheelBody >> onLaserScanDo: aBlock [
	self subclassResponsibility
]

{ #category : #sensing }
BcTwoWheelBody >> startLaserScanner [
	self onLaserScanDo: [ : echoes | latestLaserScan := echoes].

]

{ #category : #acting }
BcTwoWheelBody >> stop [
	self velocityForward: 0 rotation: 0
]

{ #category : #sensing }
BcTwoWheelBody >> stopLaserScanner [
	self subclassResponsibility
]
