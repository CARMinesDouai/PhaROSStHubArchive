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
	self assert: trajectoryState status = PNGTrajectoryState waitingStatusValue.
	origin := 20@35.
	target := 311@281.
	trajectoryService insertSegmentFrom:  origin to: target.
	trajectoryState := trajectoryService get.
	self assert: trajectoryState status = PNGTrajectoryState pausedStatusValue.
]
