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
		spec mapServer: '/home/kompai1/map/map.yaml'.
		spec staticZeroTFFrom: '/base_link'  to: '/laser'.  
		spec relay: '/kompai/scan' to: '/scan' named: 'scan_relay'.
		spec relay: '/kompai/tf' to: '/tf' named: 'tf_relay'.
		"spec staticZeroTFFrom: '/map'  to: '/odom'. 
		"spec amcl.
		spec moveBase.
		spec velocitySmoother.
	].

	self robulab amcl.
	
	
"
	
	self robulab moveBase.
"	
	"Since we have a differential drive robot, we just want to compare the changing variables"
	
	
	
	

]
