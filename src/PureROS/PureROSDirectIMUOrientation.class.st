Class {
	#name : #PureROSDirectIMUOrientation,
	#superclass : #PureROSPlottingExperiment,
	#category : #'PureROS-Experiments-Localization'
}

{ #category : #'as yet unclassified' }
PureROSDirectIMUOrientation >> setup [ 
	self launch: 'direct-imu-orientation.launch'.
	self configureTFIn: '/base_link' withParent: '/map'. "It will inform the position in terms of the robot in TF topic"
	self useIMUAsOrientation. "Takes IMU orientation and override robot orientation with it"
]
