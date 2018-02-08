"
I represent a world model of obstacles in front and on the sides of a robot. I provide only distances to nearest obstacles in 6 areas defined by the 6 instances variables.

    Instance Variables
	sideLeftFront:		<Number>
	sideLeftRear:		<Number>
	sideRightFront:		<Number>
	sideRightRear:		<Number>

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
-sideLeftFront
Minimum distance at the nearest obstacle at the left side of the robot , closer to the front
-sideLeftRear
Minimum distance at the nearest obstacle at the left side of the robot , closer to the rear
-sideRightFront
Minimum distance at the nearest obstacle at the right side of the robot , closer to the front
-sideRightRear
Minimum distance at the nearest obstacle at the right side of the robot , closer to the rear



 
"
Class {
	#name : #Bc6ZonesObstacleDistances,
	#superclass : #Bc2ZonesObstacleDistances,
	#traits : 'BcTFrontSideZoneObstacleDistances',
	#classTraits : 'BcTFrontSideZoneObstacleDistances classTrait',
	#instVars : [
		'sideLeftFront',
		'sideRightFront',
		'sideRightRear',
		'sideLeftRear'
	],
	#category : #'BotController-WorldModel'
}

{ #category : #'initialize-release' }
Bc6ZonesObstacleDistances >> reset [
	super reset.
	self sideLeftFront: Float infinity.
	self sideLeftRear: Float infinity.
	self sideRightFront: Float infinity.
	self sideRightRear: Float infinity
]

{ #category : #accessing }
Bc6ZonesObstacleDistances >> sideLeft [
	^self sideLeftFront min: self sideLeftRear 
]

{ #category : #accessing }
Bc6ZonesObstacleDistances >> sideLeftFront [
	^ sideLeftFront
]

{ #category : #accessing }
Bc6ZonesObstacleDistances >> sideLeftFront: anObject [
	sideLeftFront := anObject
]

{ #category : #accessing }
Bc6ZonesObstacleDistances >> sideLeftRear [
	^ sideLeftRear
]

{ #category : #accessing }
Bc6ZonesObstacleDistances >> sideLeftRear: anObject [
	^ sideLeftRear := anObject
]

{ #category : #accessing }
Bc6ZonesObstacleDistances >> sideRight [
	^self sideRightFront min: self sideRightRear 
]

{ #category : #accessing }
Bc6ZonesObstacleDistances >> sideRightFront [
	^ sideRightFront
]

{ #category : #accessing }
Bc6ZonesObstacleDistances >> sideRightFront: anObject [
	sideRightFront := anObject
]

{ #category : #accessing }
Bc6ZonesObstacleDistances >> sideRightRear [
	^ sideRightRear
]

{ #category : #accessing }
Bc6ZonesObstacleDistances >> sideRightRear: anObject [
	^ sideRightRear := anObject
]
