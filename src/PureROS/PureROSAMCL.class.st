"
"" Be sure that you have amcl.launch file in the same folder than the image, and then execute the following two lines. ( Change kompai2 to kompai1 if is the case ) ""

		experiment := PureROSAMCL kompai2.
		experiment beginExperiment.

	"" Now, move the robot around with the joystick. and you can watch the comparing plot  ""
	
		experiment endExperiment.

	
"
Class {
	#name : #PureROSAMCL,
	#superclass : #PureROSPlottingExperiment,
	#category : #'PureROS-Experiments-Localization'
}

{ #category : #configuration }
PureROSAMCL >> plot [
	self plot: [
		: spec |
		spec addPoseStamped pose orientation fields: { #w . #z }.
		(spec addTFBetween: '/map' and: '/base_link') pose orientation fields: { #w . #z }.
		
		spec addPoseStamped pose position fields: { #x . #y }.
		(spec addTFBetween: '/map' and: '/base_link') pose position fields: { #x . #y }.
	].
]

{ #category : #configuration }
PureROSAMCL >> setup [
	self launch: 'amcl.launch'.


	self configureLaser.			"It will send laser scans to /scan topic"
	self configureInitialPose.		"It will read /initialpose topic and change the robot pose"
	self configureTFIn: '/base_link' withParent: '/odom'. "It will inform the position in terms of the robot in TF topic"
	
	self configurePoseStamped.    "It will inform the pose in /kompai{Code}/pose topic"
	
	
	
	self plot. "It will plot the robot orientation information with the AMCL orientation".
	
	
	"Since we have a differential drive robot, we just want to compare the changing variables"
	
	
	
	

]
