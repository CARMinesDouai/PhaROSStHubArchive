Class {
	#name : #PureROSHLBasedPathPlanning,
	#superclass : #PureROSBasicExperiment,
	#category : #'PureROSExperiments-Planning'
}

{ #category : #'as yet unclassified' }
PureROSHLBasedPathPlanning >> setup [
"	self launch: 'hl_path_planning.launch'."

	self launch: [ : spec |
		spec mapServer: '/home/santiago/map4/map.yaml'.
		
		spec staticZeroTFFrom: 'base_footprint' to: 'laser'.
		spec staticZeroTFFrom: 'map' to: 'MT0'.
		spec staticZeroTFFrom: 'map' to: 'odom'.
		
		spec relayTopic: '/state' to: '/odom'. 
		
		spec hectorLocalization.
		spec moveBase.
		
		spec velocitySmoother.
		
		spec rviz. 
	].

	
	self robulab amclNoOdometry.
	self robulab hectorLocalization.
	
	
	
	
	
	"Since we have a differential drive robot, we just want to compare the changing variables"
	
	
	
	

]
