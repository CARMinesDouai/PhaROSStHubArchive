Class {
	#name : #PureROSAMCLWithIMUOrientation,
	#superclass : #PureROSAMCL,
	#category : #'PureROS-Experiments-Localization-IMU'
}

{ #category : #'as yet unclassified' }
PureROSAMCLWithIMUOrientation >> setup [ 
	super setup.
	self useIMUAsOrientation. "Takes IMU orientation and override robot orientation with it"
]
