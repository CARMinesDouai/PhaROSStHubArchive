Class {
	#name : #PureROSLaserScanMatcherWithIMUOrientation,
	#superclass : #PureROSLaserScanMatcher,
	#category : #'PureROS-Experiments-Localization-IMU'
}

{ #category : #'as yet unclassified' }
PureROSLaserScanMatcherWithIMUOrientation >> setup [ 
	super setup.
	self useIMUAsOrientation. "Takes IMU orientation and override robot orientation with it"
]
