Class {
	#name : #BGSRobotBodyWithFrontRangeSensor,
	#superclass : #BGSRobotBody,
	#category : #'BOSS-Example'
}

{ #category : #'initialize-release' }
BGSRobotBodyWithFrontRangeSensor >> defaultFrontSensorRange [
	^1
]

{ #category : #'initialize-release' }
BGSRobotBodyWithFrontRangeSensor >> initParts [ 
	super initParts.
	BGSDirectionalRangeSensor botBody: self name: #frontRangeSensor range: self defaultFrontSensorRange
]
