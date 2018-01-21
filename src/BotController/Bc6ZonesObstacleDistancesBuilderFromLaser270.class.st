Class {
	#name : #Bc6ZonesObstacleDistancesBuilderFromLaser270,
	#superclass : #BcWorldModelBuilder,
	#instVars : [
		'newDistances'
	],
	#category : #'BotController-WorldModel'
}

{ #category : #testing }
Bc6ZonesObstacleDistancesBuilderFromLaser270 >> isFrontEcho: anEcho [
	^anEcho angle abs < 1.05 "Pi/3"
]

{ #category : #testing }
Bc6ZonesObstacleDistancesBuilderFromLaser270 >> isLeftEcho: anEcho [
	^anEcho angle > 0 
]

{ #category : #testing }
Bc6ZonesObstacleDistancesBuilderFromLaser270 >> isRearEcho: anEcho [
	^anEcho angle abs > 1.57 "Half Pi"
]

{ #category : #accessing }
Bc6ZonesObstacleDistancesBuilderFromLaser270 >> latestLaserScan [
	^self body latestLaserScan
]

{ #category : #building }
Bc6ZonesObstacleDistancesBuilderFromLaser270 >> min: distance frontEcho: anEcho [
	^distance min: (anEcho distance * anEcho angle cos)

]

{ #category : #building }
Bc6ZonesObstacleDistancesBuilderFromLaser270 >> min: distance sideEcho: anEcho [
	^distance min: (anEcho distance * anEcho angle abs sin)

]

{ #category : #building }
Bc6ZonesObstacleDistancesBuilderFromLaser270 >> newWorldModel [
	newDistances := Bc6ZonesObstacleDistances new.
	self latestLaserScan do: [ :each | self updateFromEcho: each ].
	^newDistances
]

{ #category : #building }
Bc6ZonesObstacleDistancesBuilderFromLaser270 >> updateFromEcho: anEcho [
	(self isLeftEcho: anEcho) ifTrue: [ ^self updateFromLeftEcho: anEcho].
	self updateFromRightEcho: anEcho
]

{ #category : #building }
Bc6ZonesObstacleDistancesBuilderFromLaser270 >> updateFromLeftEcho: anEcho [
	(self isFrontEcho: anEcho) ifTrue: [^newDistances frontLeft: (self min: newDistances frontLeft frontEcho: anEcho)].
	(self isRearEcho: anEcho) ifTrue: [^newDistances sideLeftRear: (self min: newDistances sideLeftRear sideEcho: anEcho)].
	newDistances sideLeftFront: (self min: newDistances sideLeftFront sideEcho: anEcho)
]

{ #category : #building }
Bc6ZonesObstacleDistancesBuilderFromLaser270 >> updateFromRightEcho: anEcho [
	(self isFrontEcho: anEcho) ifTrue: [^newDistances frontRight: (self min: newDistances frontRight frontEcho: anEcho)].
	(self isRearEcho: anEcho) ifTrue: [^newDistances sideRightRear: (self min: newDistances sideRightRear sideEcho: anEcho)].
	newDistances sideRightFront: (self min: newDistances sideRightFront sideEcho: anEcho).
]
