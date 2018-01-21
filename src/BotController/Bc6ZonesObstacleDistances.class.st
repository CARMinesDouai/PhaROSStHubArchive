Class {
	#name : #Bc6ZonesObstacleDistances,
	#superclass : #BcWorldModel,
	#instVars : [
		'sideLeftFront',
		'sideRightFront',
		'sideRightRear',
		'sideLeftRear',
		'frontLeft',
		'frontRight'
	],
	#category : #'BotController-WorldModel'
}

{ #category : #accessing }
Bc6ZonesObstacleDistances >> front [
	^self frontLeft min: self frontRight 
]

{ #category : #accessing }
Bc6ZonesObstacleDistances >> frontLeft [
	^ frontLeft
]

{ #category : #accessing }
Bc6ZonesObstacleDistances >> frontLeft: anObject [
	^ frontLeft := anObject
]

{ #category : #accessing }
Bc6ZonesObstacleDistances >> frontRight [
	^ frontRight
]

{ #category : #accessing }
Bc6ZonesObstacleDistances >> frontRight: anObject [
	^ frontRight := anObject
]

{ #category : #'initialize-release' }
Bc6ZonesObstacleDistances >> initialize [
	super initialize.
	self reset.
]

{ #category : #accessing }
Bc6ZonesObstacleDistances >> left [
	^self frontLeft min: self sideLeft
]

{ #category : #'initialize-release' }
Bc6ZonesObstacleDistances >> reset [
	self frontLeft: Float infinity.
	self frontRight: Float infinity.
	self sideLeftFront: Float infinity.
	self sideLeftRear: Float infinity.
	self sideRightFront: Float infinity.
	self sideRightRear: Float infinity
]

{ #category : #accessing }
Bc6ZonesObstacleDistances >> right [
	^self frontRight min: self sideRight
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
