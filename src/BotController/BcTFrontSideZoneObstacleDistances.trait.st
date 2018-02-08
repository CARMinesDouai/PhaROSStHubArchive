"
I provide the minimun of distances at right and the left of the robot
"
Trait {
	#name : #BcTFrontSideZoneObstacleDistances,
	#category : #'BotController-WorldModel'
}

{ #category : #accessing }
BcTFrontSideZoneObstacleDistances >> left [
	^self frontLeft min: self sideLeft
]

{ #category : #accessing }
BcTFrontSideZoneObstacleDistances >> right [
	^self frontRight min: self sideRight
]
