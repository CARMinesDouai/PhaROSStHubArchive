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
PureROSAMCL >> setup [
	self launch: 'amcl.launch'.


	self configureLaser.
	self configurePoseStamped. 
	
	"Since we have a differential drive robot, we just want to compare the changing variables"
	
	
	self plot: [
		: spec |
		spec addPoseStamped pose orientation fields: { #w . #z }.
		(spec addTFBetween: '/map' and: '/base_link') pose orientation fields: { #w . #z }.
	].
	

]
