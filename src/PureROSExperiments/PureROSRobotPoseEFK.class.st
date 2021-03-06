"
"" 
   Be sure that you have efk.launch file in the same folder than the image, and then execute the following two lines. ( Change kompai2 to kompai1 if is the case ) 
  Be sure that:
	- xsens bus is on
	- the port has the appropiate privileges ( sudo chmod 666 /dev/ttyUSB0 )
	
""

		experiment := PureROSRobotPoseEFK kompai2.
		experiment beginExperiment.
		
	"" Now, move the robot around with the joystick. and you can watch the comparing plot  ""
	
		experiment endExperiment. 
		
	
""
	With this experiment we can see that the EFK node does not improve too much the orientation of the robot, just a few degrees


""
"
Class {
	#name : #PureROSRobotPoseEFK,
	#superclass : #PureROSPlottingExperiment,
	#category : #'PureROSExperiments-Localization'
}

{ #category : #configuration }
PureROSRobotPoseEFK >> plot [
	self plot: [
		: spec |
		spec addPoseStamped pose orientation fields: { #z . #w }.
		spec addEFKPose pose pose orientation fields: { #z . #w }.
		
		spec addPoseStamped pose position fields: { #x . #y }.
		spec addEFKPose pose pose position fields: { #x . #y }.
	].
]

{ #category : #configuration }
PureROSRobotPoseEFK >> setup [
"	self launch: 'efk.launch'."
	
		self launch: [ : spec | 

		spec mapServer: '/home/santiago/map4/map.yaml'.

		spec rviz.
		
		spec xsens param: 'imu_topic_name' value: '/imu_data'.
		
		spec staticZeroTFFrom: 'base_footprint' to: 'base_link'.
		spec staticZeroTFFrom: 'base_link' to: 'MT0'.
		spec staticZeroTFFrom: 'map' to: 'odom'.

		spec hectorLocalization.
		spec robotEFKPose.
		
	].

	self robulab efk.
	
	
	self plot.
]
