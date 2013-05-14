Class {
	#name : #PureROSAMCLBasedPathPlanning,
	#superclass : #PureROSBasicExperiment,
	#category : #'PureROS-Experiments-Planning'
}

{ #category : #configuration }
PureROSAMCLBasedPathPlanning >> setup [
	self launch: 'path_planning.launch'.
	
	" Output "
	self configureLaser.
	
	self configureOdometry.
	
	self configureTFIn: '/base_link' withParent: '/odom'.
	
	
	
]
