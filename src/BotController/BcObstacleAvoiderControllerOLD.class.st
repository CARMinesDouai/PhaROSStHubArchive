Class {
	#name : #BcObstacleAvoiderControllerOLD,
	#superclass : #BcStopOnFrontObstacleControllerOLD,
	#instVars : [
		'minFrontLeftObstacleDistance',
		'minFrontRightObstacleDistance'
	],
	#category : #'BotController-Controllers'
}

{ #category : #living }
BcObstacleAvoiderControllerOLD >> laserScan: echoes [
	minFrontLeftObstacleDistance := 100.
	minFrontRightObstacleDistance := minFrontLeftObstacleDistance.
	echoes do: [ : each | self updateObstacleDistanceFrom: each].
	minFrontObstacleDistance := minFrontLeftObstacleDistance min: minFrontRightObstacleDistance
	
]

{ #category : #living }
BcObstacleAvoiderControllerOLD >> maxSpeed [
	^0.3
]

{ #category : #living }
BcObstacleAvoiderControllerOLD >> move [
	| leftSpeed rightSpeed |
	leftSpeed := self turnSpeedFromObstacleDistance: minFrontRightObstacleDistance.
	rightSpeed := self turnSpeedFromObstacleDistance: minFrontLeftObstacleDistance.
Transcript cr;
	show: 'leftSpeed: ';
	show: leftSpeed;
	cr;
	show: 'rightSpeed: ';
	show: rightSpeed;
	cr; cr.
"	self body 
		leftSpeed: leftSpeed 
		rightSpeed: rightSpeed 
"
"	minFrontLeftObstacleDistance < minFrontRightObstacleDistance ifTrue: [ ^self turnRight ].
	self turnLeft"
]

{ #category : #living }
BcObstacleAvoiderControllerOLD >> turnLeft [
	| leftSpeed |
	leftSpeed := self turnSpeedFromObstacleDistance: minFrontRightObstacleDistance.
	"self body 
		leftSpeed: leftSpeed
		rightSpeed: self maxSpeed  
"
]

{ #category : #living }
BcObstacleAvoiderControllerOLD >> turnRight [
	| rightSpeed |
	rightSpeed := self turnSpeedFromObstacleDistance: minFrontLeftObstacleDistance.
	"self body 
		leftSpeed: self maxSpeed 
		rightSpeed: rightSpeed 
"
]

{ #category : #living }
BcObstacleAvoiderControllerOLD >> turnSpeedFromObstacleDistance: distanceToObstacle [
	^distanceToObstacle - self maxSpeed.

]

{ #category : #living }
BcObstacleAvoiderControllerOLD >> updateObstacleDistanceFrom: anEcho [
	| obstacleDistance |
	(self isFrontEcho: anEcho) ifFalse: [ ^self ].
	obstacleDistance := anEcho distance * anEcho angle cos.
	anEcho angle < 0 ifTrue: [
		^minFrontRightObstacleDistance := minFrontRightObstacleDistance min: obstacleDistance].
	minFrontLeftObstacleDistance := minFrontLeftObstacleDistance min: obstacleDistance
]
