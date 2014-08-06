"
I am a robot that moves to a random free neighboring cell 
"
Class {
	#name : #BGSRandomWalkRobot,
	#superclass : #BGSRobot,
	#category : #'BOSS-Example'
}

{ #category : #'initialize-release' }
BGSRandomWalkRobot >> bodyClass [ 
	^BGSRobotBodyWithFrontRangeSensor
]

{ #category : #accessing }
BGSRandomWalkRobot >> frontRangeSensor [
	^self body part: #frontRangeSensor
]

{ #category : #sensing }
BGSRandomWalkRobot >> hasObstacleInFront [
	^self frontRangeSensor distanceToObstacle = 0
]

{ #category : #stepping }
BGSRandomWalkRobot >> step [
	self turnBy: (-2 to: 2) atRandom.  "Change direction by -90, -45, 0, 45, or 90 degrees (negative is to the left and positive to the right)"
	self goForward
]
