Class {
	#name : #PureROSHectorMapping,
	#superclass : #PureROSSLAMBase,
	#instVars : [
		'launchFile'
	],
	#classInstVars : [
		'launchFile'
	],
	#category : #'PureROS-Experiments-SLAM'
}

{ #category : #commands }
PureROSHectorMapping >> command: aCommand [
	pureros node sendTo: '/syscommand' typedAs: 'std_msgs/String' a: [ : msg | msg data: aCommand ].
]

{ #category : #'initialize-release' }
PureROSHectorMapping >> initialize [ 
	super initialize.
	launchFile := 'hector-mapping.launch'.
]

{ #category : #accessing }
PureROSHectorMapping >> launchFile: aStringPath [ 
	launchFile := aStringPath 
]

{ #category : #commands }
PureROSHectorMapping >> reset [
	self command: 'reset'.
]

{ #category : #configuration }
PureROSHectorMapping >> setup [
	self launch: launchFile.
	
	" Output "
	self configureLaser.
]

{ #category : #configuration }
PureROSHectorMapping >> withImu [
	self launchFile: 'hector-mapping-imu.launch'.
	^ self.
]
