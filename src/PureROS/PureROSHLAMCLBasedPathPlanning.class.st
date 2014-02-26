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
	
		spec relayTopic: '/state' to: '/odom'. 
		
		spec hectorLocalization.
		spec amcl.
		spec moveBase.
		spec velocitySmoother.
		
		spec rviz. 
	].
 
	self robulab amclNoOdometry.
	self robulab hectorLocalization.
	
	
	
	
	"Since we have a differential drive robot, we just want to compare the changing variables"
	
	
	
	

]
