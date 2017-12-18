Class {
	#name : #BcObstacleAvoiderController,
	#superclass : #BcStopOnFrontObstacleController,
	#instVars : [
		'minFrontLeftObstacleDistance',
		'minFrontRightObstacleDistance'
	],
	#category : #'BotController-Controllers'
}

{ #category : #living }
BcObstacleAvoiderController >> farObstacleDistance [
	^1
]

{ #category : #living }
BcObstacleAvoiderController >> laserScan: echoes [
	minFrontLeftObstacleDistance := self farObstacleDistance.
	minFrontRightObstacleDistance := self farObstacleDistance.
	"Front echoes are ones with angle about Float pi / 3"
	echoes do: [ : each | self updateObstacleDistanceFrom: each].
	minFrontObstacleDistance := minFrontLeftObstacleDistance min: minFrontRightObstacleDistance
	
]

{ #category : #living }
BcObstacleAvoiderController >> move [
	| maxSpeed leftSpeed rightSpeed |
	maxSpeed := 0.4.
	leftSpeed := minFrontObstacleDistance min: maxSpeed. 
	rightSpeed := minFrontRightObstacleDistance min: maxSpeed.
	self body leftSpeed: leftSpeed rightSpeed: rightSpeed 
]

{ #category : #living }
BcObstacleAvoiderController >> updateObstacleDistanceFrom: anEcho [
	| obstacleDistance |
	anEcho angle abs < 1 ifFalse: [ ^self ].
	obstacleDistance := anEcho distance * anEcho angle cos.
	anEcho angle < 0 ifTrue: [
		^minFrontLeftObstacleDistance := minFrontLeftObstacleDistance min: obstacleDistance].
	minFrontRightObstacleDistance := minFrontRightObstacleDistance min: obstacleDistance
]
