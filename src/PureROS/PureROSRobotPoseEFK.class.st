"
"" Be sure that you have efk.launch file in the same folder than the image, and then execute the following two lines. ( Change kompai2 to kompai1 if is the case ) ""

		experiment := PureROSRobotPoseEFK kompai2.
		experiment beginExperiment.
		
	"" Now, move the robot around with the joystick. and you can watch the comparing plot  ""
	
		experiment endExperiment.

	
"
Class {
	#name : #PureROSRobotPoseEFK,
	#superclass : #PureROSPlottingExperiment,
	#category : #'PureROS-Experiments-Localization'
}

{ #category : #configuration }
PureROSRobotPoseEFK >> setup [
	self launch: 'efk.launch'.

	self configureOdometry.
	
	self configureTFIn: '/robot' withParent: '/map'. " Watching the raw position in the map "
	
	self configurePoseStamped. "For plotting"
	
	self plot: [
		: spec |
		spec addPoseStamped pose orientation fields: { #w . #z }.
		spec addEFKPose pose pose orientation fields: { #w . #z }.
	].
]
