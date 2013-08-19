"
"" 
   Be sure that you have efk.launch file in the same folder than the image, and then execute the following two lines. ( Change kompai2 to kompai1 if is the case ) 
  Be sure that:
	- xsens bus is on
	- the port has the appropiate privileges ( sudo chmod 666 /dev/ttyUSB0 )
	
""

		experiment := PureROSHectorLocalization kompai2.
		experiment beginExperiment.
		
	"" Now, move the robot around with the joystick. and you can watch the comparing plot  ""
	
		experiment endExperiment. 
		
	
""
	With this experiment we can see that the EFK node does not improve too much the orientation of the robot, just a few degrees


""
"
Class {
	#name : #PureROSHectorLocalization,
	#superclass : #PureROSPlottingExperiment,
	#category : #'PureROS-Experiments-Localization'
}

{ #category : #'as yet unclassified' }
PureROSHectorLocalization >> plot [
	self plot: [
		: spec |
		spec addPoseStamped pose orientation fields: { #z . #w }.
		spec addHectorPose pose orientation fields: { #z . #w }.
		
		spec addPoseStamped pose position fields: { #x . #y }.
		spec addHectorPose pose position fields: { #x . #y }.
	].
]

{ #category : #'as yet unclassified' }
PureROSHectorLocalization >> setup [ 
"	self launch: 'hector-localization.launch'."
	
	self launch: [ : spec | 
		spec mapServer: '/home/santiago/map4/map.yaml'.
		spec rviz.
		spec xsens param: 'imu_topic_name' value: '/raw_imu'.
		
		spec staticZeroTFFrom: 'base_footprint' to: 'laser'.
		spec staticZeroTFFrom: 'map' to: 'MT0'.
		spec staticZeroTFFrom: 'map' to: 'odom'.
		spec hectorLocalization.
		
	].
	self robulab hectorLocalization.
	
	
	
	self plot.
]
