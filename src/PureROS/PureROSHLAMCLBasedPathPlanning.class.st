"
Failed experiment :(

"
Class {
	#name : #PureROSHLAMCLBasedPathPlanning,
	#superclass : #PureROSBasicExperiment,
	#category : #'PureROS-Experiments-Planning'
}

{ #category : #'as yet unclassified' }
PureROSHLAMCLBasedPathPlanning >> setup [
"	self launch: 'hl_amcl_path_planning.launch'."

	self launch: [ : spec |
		spec mapServer: '/home/santiago/map4/map.yaml'.
		
		spec staticZeroTFFrom: 'base_footprint' to: 'laser'.
		spec staticZeroTFFrom: 'map' to: 'MT0'.
		spec staticZeroTFFrom: 'map' to: 'odom'.
		
		spec xsens param: 'imu_topic_name' value: '/raw_imu'.
		spec relayTopic: '/state' to: '/odom'. 
		
		spec hectorLocalization.
		spec amcl.
		spec moveBase.
		spec rviz. 
	].

	self configureLaser.			"It will send laser scans to /scan topic"
	self configureInitialPose.		"It will read /initialpose topic and change the robot pose"
	self configurePoseStampedWithCovarianceAs: '/poseupdate'.
	
	
	
	
	
	"Since we have a differential drive robot, we just want to compare the changing variables"
	
	
	
	

]
