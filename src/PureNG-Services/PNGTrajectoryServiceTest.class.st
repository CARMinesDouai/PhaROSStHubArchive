Class {
	#name : #PNGTrajectoryServiceTest,
	#superclass : #PNGServiceTest,
	#instVars : [
		'trajectoryService'
	],
	#category : #'PureNG-Services-Test'
}

{ #category : #testing }
PNGTrajectoryServiceTest >> setUp [
	super setUp.
	trajectoryService := robot trajectoryService
]

{ #category : #testing }
PNGTrajectoryServiceTest >> testEmergencyStopOnStoppedRobot [
	| trajectoryState |
	trajectoryState := trajectoryService get.
	self assert: trajectoryState status = PNGTrajectoryState waitingStatusValue.
	trajectoryService emergencyStop.
	trajectoryState := trajectoryService get.
	self assert: trajectoryState status = PNGTrajectoryState waitingStatusValue.

]

{ #category : #testing }
PNGTrajectoryServiceTest >> testFollowingStateDuringMotion [
	| trajectoryState origin target |
	origin := 1@1.
	target := 0@0.
	trajectoryService insertSegmentFrom:  origin to: target speed: 0.25.
	self halt: 'Warning: robot is supposed to move !!!!'.
	trajectoryService startMotion.
	trajectoryState := trajectoryService get.
	self assert: trajectoryState status = PNGTrajectoryState followingStatusValue.
	trajectoryService stopMotion
]

{ #category : #testing }
PNGTrajectoryServiceTest >> testGetOfStoppedRobot [
	| trajectoryState |
	trajectoryState := trajectoryService get.
	self assert: trajectoryState timestamp > 0.
	self assert: trajectoryState status = PNGTrajectoryState waitingStatusValue.
	self assert: trajectoryState distanceCovered = 0.
	self assert: trajectoryState lateralError = 0.
	self assert: trajectoryState orientationError = 0
]

{ #category : #testing }
PNGTrajectoryServiceTest >> testInsertOneSegmentChangesStatusFromStoppedToWaiting [
	| trajectoryState origin target |
	trajectoryState := trajectoryService get.
	self assert: trajectoryState status = PNGTrajectoryState waitingStatusValue.
	origin := 0@0.
	target := 1@0.
	trajectoryService insertSegmentFrom:  origin to: target speed: 0.25.
	trajectoryService stopMotion.
	trajectoryState := trajectoryService get.
	self assert: trajectoryState status = PNGTrajectoryState pausedStatusValue.
]

{ #category : #testing }
PNGTrajectoryServiceTest >> testStopAlreadyStoppedRobot [
	| trajectoryState |
	trajectoryState := trajectoryService get.
	self assert: trajectoryState status = PNGTrajectoryState waitingStatusValue.
	trajectoryService stopMotion.
	trajectoryState := trajectoryService get.
	self assert: trajectoryState status = PNGTrajectoryState pausedStatusValue.

]
