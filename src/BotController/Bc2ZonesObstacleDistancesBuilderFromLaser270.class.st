"
I am the builder for a 2 zones obstacle distances world model, from echoes generated by a 270 laser range sensor.

During an update, I build a new world model. I make avaible when I finished iterating over all echoes.

I require the robot body understand the latestLaserScan message

    Instance Variables
	newDistances:		<Bc2ZonesObstacleDistances>


    Implementation Points
"
Class {
	#name : #Bc2ZonesObstacleDistancesBuilderFromLaser270,
	#superclass : #BcWorldModelBuilder,
	#instVars : [
		'newDistances'
	],
	#category : #'BotController-WorldModel'
}

{ #category : #testing }
Bc2ZonesObstacleDistancesBuilderFromLaser270 >> isFrontEcho: anEcho [
	^anEcho angle abs < 1.05 "Pi/3"
]

{ #category : #testing }
Bc2ZonesObstacleDistancesBuilderFromLaser270 >> isLeftEcho: anEcho [
	^anEcho angle > 0 
]

{ #category : #accessing }
Bc2ZonesObstacleDistancesBuilderFromLaser270 >> latestLaserScan [
	^self body latestLaserScan
]

{ #category : #building }
Bc2ZonesObstacleDistancesBuilderFromLaser270 >> min: distance frontEcho: anEcho [
	^distance min: (anEcho distance * anEcho angle cos)

]

{ #category : #building }
Bc2ZonesObstacleDistancesBuilderFromLaser270 >> min: distance sideEcho: anEcho [
	| echoDistance |
	echoDistance := (anEcho distance * anEcho angle abs sin) - self body laserToSideDistance.
	^distance min: echoDistance

]

{ #category : #building }
Bc2ZonesObstacleDistancesBuilderFromLaser270 >> newWorldModel [
	newDistances := self worldModelClass new.
	self latestLaserScan do: [ :each | self updateFromEcho: each ].
	^ newDistances
]

{ #category : #building }
Bc2ZonesObstacleDistancesBuilderFromLaser270 >> updateFromEcho: anEcho [
	(self isLeftEcho: anEcho) ifTrue: [ ^self updateFromLeftEcho: anEcho].
	self updateFromRightEcho: anEcho
]

{ #category : #building }
Bc2ZonesObstacleDistancesBuilderFromLaser270 >> updateFromLeftEcho: anEcho [
	(self isFrontEcho: anEcho) ifFalse: [^self].
	newDistances frontLeft: (self min: newDistances frontLeft frontEcho: anEcho).

]

{ #category : #building }
Bc2ZonesObstacleDistancesBuilderFromLaser270 >> updateFromRightEcho: anEcho [
	(self isFrontEcho: anEcho) ifFalse: [^self].
	newDistances frontRight: (self min: newDistances frontRight frontEcho: anEcho).

]

{ #category : #building }
Bc2ZonesObstacleDistancesBuilderFromLaser270 >> worldModelClass [
	^Bc2ZonesObstacleDistances
]
