Class {
	#name : #PureROSRobotPoseEFKWithIMUOrientation,
	#superclass : #PureROSRobotPoseEFK,
	#category : #'PureROS-Experiments-Localization-IMU'
}

{ #category : #'as yet unclassified' }
PureROSRobotPoseEFKWithIMUOrientation >> setup [ 
	super setup.
	self useIMUAsOrientation. "Takes IMU orientation and override robot orientation with it"
]
