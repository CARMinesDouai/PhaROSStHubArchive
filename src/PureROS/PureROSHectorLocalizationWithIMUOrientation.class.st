Class {
	#name : #PureROSHectorLocalizationWithIMUOrientation,
	#superclass : #PureROSHectorLocalization,
	#category : #'PureROS-Experiments-Localization-IMU'
}

{ #category : #'as yet unclassified' }
PureROSHectorLocalizationWithIMUOrientation >> setup [ 
	super setup.
	self useIMUAsOrientation. "Takes IMU orientation and override robot orientation with it"
]
