"
"" Be sure that you have gmappings.launch file in the same folder than the image, and then execute the following two lines. ( Change kompai2 to kompai1 if is the case ) ""

		experiment := PureROSGmappings kompai2.
		experiment beginExperiment.
		
	"" Now, move the robot around with the joystick. When the map is done, execute the following line.  ""
	
		experiment endExperiment.

	"" In this experiment we have in the teardown process the map saving. You will find a map.yaml file in the same folder as the image. (It not check the override of the files, take care of that) ""
	

"
Class {
	#name : #PureROSGmappings,
	#superclass : #PureROSSLAMBase,
	#category : #'PureROS-Experiments-SLAM'
}

{ #category : #configuration }
PureROSGmappings >> setup [
"	self launch: 'gmappings.launch'."
	
	self launch: [ : spec |
		spec gmapping.
		spec rviz.
		spec staticZeroTFFrom: '/base_link'  to: '/laser'.  
		spec staticZeroTFFrom: '/map'  to: '/odom_combined'.
		spec staticZeroTFFrom: '/base_footprint'  to: '/MT0'.
	].
	
	
	self robulab slam.

	
	
]
