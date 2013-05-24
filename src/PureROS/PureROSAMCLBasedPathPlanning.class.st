Class {
	#name : #PureROSAMCLBasedPathPlanning,
	#superclass : #PureROSBasicExperiment,
	#category : #'PureROS-Experiments-Planning'
}

{ #category : #configuration }
PureROSAMCLBasedPathPlanning >> setup [
"	self launch: 'amcl_path_planning.launch'."

	self launch: [ : spec |
		spec rviz. 
		spec mapServer: '/home/santiago/map4/map.yaml'.
		spec staticZeroTFFrom: '/base_link'  to: '/laser'.  
		spec xsens param: 'imu_topic_name' value: '/imu_data'.
		spec amcl.
		spec moveBase.
	].

	self configureLaser.			"It will send laser scans to /scan topic"
	self configureInitialPose.		"It will read /initialpose topic and change the robot pose"
	self configureTFIn: '/base_link' withParent: '/odom'. "It will inform the position in terms of the robot in TF topic"
	
	self configureOdometry.
	
	
	"Since we have a differential drive robot, we just want to compare the changing variables"
	
	
	
	

]
