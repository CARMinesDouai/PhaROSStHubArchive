"
I represent a world model of obstacles in front and on the sides of a robot. I provide only distances to nearest obstacles in 4 areas defined by the 4 instances variables.

    Instance Variables
	sideLeft:		<Number>
	sideRight:		<Number>

Public API and Key Messages
- reset
Reset all distances to infinity
-front
Minimum distance at the nearest obstacle at the front of the robot
-frontLeft
Minimum distance to nearest obstacle at the left front
-frontRight
Minimum distance to nearest obstacle at the right front
-sideLeft
Minimum distance at the nearest obstacle at the left side of the robot
-left
Minimum distance at the nearest obstacle at the left of the robot (front and side)
-sideRight
Minimum distance at the nearest obstacle at the right side of the robot
-right
Minimum distance at the nearest obstacle at the right of the robot  (front and side)



 
"
Class {
	#name : #Bc4ZonesObstacleDistances,
	#superclass : #Bc2ZonesObstacleDistances,
	#traits : 'BcTFrontSideZoneObstacleDistances',
	#classTraits : 'BcTFrontSideZoneObstacleDistances classTrait',
	#instVars : [
		'sideLeft',
		'sideRight'
	],
	#category : #'BotController-WorldModel'
}

{ #category : #'initialize-release' }
Bc4ZonesObstacleDistances >> reset [
	super reset.
	self sideLeft: Float infinity.
	self sideRight: Float infinity.

]

{ #category : #accessing }
Bc4ZonesObstacleDistances >> sideLeft [
	^ sideLeft
]

{ #category : #accessing }
Bc4ZonesObstacleDistances >> sideLeft: anObject [
	sideLeft := anObject
]

{ #category : #accessing }
Bc4ZonesObstacleDistances >> sideLeftFront [
	^self sideLeft
]

{ #category : #accessing }
Bc4ZonesObstacleDistances >> sideLeftRear [
	^self sideLeft
]

{ #category : #accessing }
Bc4ZonesObstacleDistances >> sideRight [
	^ sideRight
]

{ #category : #accessing }
Bc4ZonesObstacleDistances >> sideRight: anObject [
	sideRight := anObject
]

{ #category : #accessing }
Bc4ZonesObstacleDistances >> sideRightFront [
	^self sideLeft
]

{ #category : #accessing }
Bc4ZonesObstacleDistances >> sideRightRear [
	^self sideLeft
]
