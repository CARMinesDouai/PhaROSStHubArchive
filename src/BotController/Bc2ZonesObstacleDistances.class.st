"
I represent a world model of nearest obstacles at the front of a robot. I provide minimum distances to obstacles.

    Instance Variables
	frontLeft:		<Number>
	frontRight:		<Number>

Public API and Key Messages
-front
minimum distance at the nearest obstacle at the front of the robot
-frontLeft
Minimum distance to nearest obstacle at the left front
-frontRight
Minimum distance to nearest obstacle at the right front
- reset
Reset all distances to infinity

"
Class {
	#name : #Bc2ZonesObstacleDistances,
	#superclass : #BcWorldModel,
	#instVars : [
		'frontLeft',
		'frontRight'
	],
	#category : #'BotController-WorldModel'
}

{ #category : #accessing }
Bc2ZonesObstacleDistances >> front [
	^self frontLeft min: self frontRight 
]

{ #category : #accessing }
Bc2ZonesObstacleDistances >> frontLeft [
	^ frontLeft
]

{ #category : #accessing }
Bc2ZonesObstacleDistances >> frontLeft: anObject [
	^ frontLeft := anObject
]

{ #category : #accessing }
Bc2ZonesObstacleDistances >> frontRight [
	^ frontRight
]

{ #category : #accessing }
Bc2ZonesObstacleDistances >> frontRight: anObject [
	^ frontRight := anObject
]

{ #category : #'initialize-release' }
Bc2ZonesObstacleDistances >> reset [
	self frontLeft: Float infinity.
	self frontRight: Float infinity.

]
