Class {
	#name : #PureROSBasicExperiment,
	#superclass : #Object,
	#instVars : [
		'pureros'
	],
	#category : #'PureROS-Experiments'
}

{ #category : #'as yet unclassified' }
PureROSBasicExperiment class >> kompai1 [
	^ self new pureros: PureROSController kompai1; yourself .
]

{ #category : #'as yet unclassified' }
PureROSBasicExperiment class >> kompai2 [
	^ self new pureros: PureROSController kompai2; yourself .
]

{ #category : #'as yet unclassified' }
PureROSBasicExperiment >> configure [
	pureros laserBroadcasterAt: '/scan' typedAs: 'sensor_msgs/LaserScan' transformedBy: [ :notification : msg | 
		msg header frame_id: '/laser'.
		notification intoSensor_msgs_LaserScan: msg.
	].
	pureros movementBroadcasterAt: '/odom' typedAs: 'nav_msgs/Odometry'  transformedBy: PureROSOdometryDelegate new callback.
	
]

{ #category : #'as yet unclassified' }
PureROSBasicExperiment >> pureros: aPureROSController [
	pureros := aPureROSController.
]
