Class {
	#name : #PureROSHLBasedPathPlanning,
	#superclass : #PureROSBasicExperiment,
	#category : #'PureROS-Experiments-Planning'
}

{ #category : #'as yet unclassified' }
PureROSHLBasedPathPlanning >> setup [
	self launch: 'hl_path_planning.launch'.


	self configureLaser.			"It will send laser scans to /scan topic"
	self configureInitialPose.		"It will read /initialpose topic and change the robot pose"
	self configurePoseStampedWithCovarianceAs: '/poseupdate'.
	
	
	
	
	
	"Since we have a differential drive robot, we just want to compare the changing variables"
	
	
	
	

]
