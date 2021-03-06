Class {
	#name : #PNGTrajectoryServiceBasedController,
	#superclass : #PNGController,
	#category : #'PureNG-Controllers'
}

{ #category : #controlling }
PNGTrajectoryServiceBasedController >> clearTrajectory [ 
	self trajectoryService clearTrajectory 
]

{ #category : #sensing }
PNGTrajectoryServiceBasedController >> currentPosition [
	^ self localizationService currentPosition
]

{ #category : #controlling }
PNGTrajectoryServiceBasedController >> emergencyStop [ 
	self trajectoryService 
		emergencyStop;
		clearTrajectory "Makes the trajectory service exit the error mode and ready for new motion"
]

{ #category : #controlling }
PNGTrajectoryServiceBasedController >> goTo: aPoint [
	| currentPosition |
	currentPosition := self localizationService currentPosition.
	self trajectoryService 
		insertSegmentFrom:  currentPosition to: aPoint asPoint  speed: 0.25;
		startMotion.

]

{ #category : #controlling }
PNGTrajectoryServiceBasedController >> goToAll: wayPoints [
	| origin |
	origin := self currentPosition.
	wayPoints
		do: [ :target | 
			self trajectoryService insertSegmentFrom: origin to: target speed: 0.25.
			origin := target ].
	self trajectoryService startMotion
]

{ #category : #controlling }
PNGTrajectoryServiceBasedController >> goToAllDelta: deltaPoints [ 
	| pathOrigin segmentOrigin segmentTarget |
	pathOrigin := self currentPosition.
	segmentOrigin := pathOrigin.
	deltaPoints do: [:delta|
		segmentTarget := pathOrigin + delta.
		self trajectoryService 
			insertSegmentFrom:  segmentOrigin 
			to: segmentTarget
			speed: 0.25.
		segmentOrigin := segmentTarget
	].
	self trajectoryService startMotion.

]

{ #category : #controlling }
PNGTrajectoryServiceBasedController >> goToDelta: deltaPoint [
	| origin target |
	
	origin := self currentPosition.
	target := origin + deltaPoint asPoint.
	self trajectoryService 
		insertSegmentFrom:  origin to: target  speed: 0.25;
		startMotion.

]

{ #category : #'sample trajectories' }
PNGTrajectoryServiceBasedController >> goToOrigin [
	self goTo: 0@0
]

{ #category : #'sample trajectories' }
PNGTrajectoryServiceBasedController >> hexagone [
	self hexagone: 4
]

{ #category : #'sample trajectories' }
PNGTrajectoryServiceBasedController >> hexagone: enclosingSquareLength [ 
	| waypoints |
	self localizationService resetPose.
	waypoints := {0.75 @ 0. 1.25 @ 0. 2 @ 0.75. 2 @ 1.25. 1.25 @ 2. 0.75 @ 2. 0 @ 1.25. 0 @ 0.75. 0.75 @ 0}
				collect: [:point | point * enclosingSquareLength / 2].
	self goToAll: waypoints 
]

{ #category : #'sample trajectories' }
PNGTrajectoryServiceBasedController >> square [
	self trajectoryService clearTrajectory.
	self localizationService resetPose.
	(Delay forMilliseconds: 500) wait.
	self goToAll: {
	2@0.
	2@2.
	0@2.
	0@0
	}
]

{ #category : #controlling }
PNGTrajectoryServiceBasedController >> startMotion [
	self trajectoryService startMotion
]

{ #category : #'sample trajectories' }
PNGTrajectoryServiceBasedController >> status [
	^ (self trajectoryService get)ifNotNil: [ : status | status status ]  .
]

{ #category : #controlling }
PNGTrajectoryServiceBasedController >> stopMotion [
	self trajectoryService stopMotion
]
