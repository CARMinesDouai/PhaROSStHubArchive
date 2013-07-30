Class {
	#name : #PureROSHectorMapping,
	#superclass : #PureROSSLAMBase,
	#instVars : [
		'configuration'
	],
	#classInstVars : [
		'launchFile'
	],
	#category : #'PureROS-Experiments-SLAM'
}

{ #category : #commands }
PureROSHectorMapping >> command: aCommand [
	self controller rosnode sendTo: '/syscommand' typedAs: 'std_msgs/String' a: [ : msg | msg data: aCommand ].
]

{ #category : #'initialize-release' }
PureROSHectorMapping >> defaultConfiguration [
		^ [ 	: spec |
			spec rviz.
			spec staticZeroTFFrom: '/base_link' to: '/laser'. 
			spec staticZeroTFFrom: '/odom' to: '/base_link'.
			spec hectorMapping.	
		]
]

{ #category : #'initialize-release' }
PureROSHectorMapping >> initialize [ 
	super initialize.
	configuration := self defaultConfiguration.
	"configuration := 'hector-mapping.launch'."
]

{ #category : #commands }
PureROSHectorMapping >> reset [
	self command: 'reset'.
]

{ #category : #configuration }
PureROSHectorMapping >> setup [
	self launch: configuration.
	
	" Output "
	self robulab broadcastSensors.
]

{ #category : #configuration }
PureROSHectorMapping >> withImu [

	"configuration := 'hector-mapping-imu.launch'."

	 configuration:= [
		:spec | 
		
			spec rviz.
			spec staticZeroTFFrom: '/base_link' to: '/laser'. 
			spec staticZeroTFFrom: '/base_link' to: '/MT0'.
			spec staticZeroTFFrom: '/odom' to: '/base_link'.
			spec hectorMapping.	
				
			spec xsens param: 'imu_topic_name' value:'/imu_topic' .
			
			(spec package: 'hector_imu_attitude_to_tf' type: 'imu_attitude_to_tf_node' named: 'hector_imu_attitude_to_tf')
					param: 'base_stabilized_frame' value: 'base_link';
					param: 'base_frame' value: 'base_imu_link'.
			
			
	].
	^ self.
]
