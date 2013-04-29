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
	self subclassResponsibility.
	
	
	
]

{ #category : #'as yet unclassified' }
PureROSBasicExperiment >> configureLaser [
	pureros laserBroadcasterAt: '/scan' typedAs: 'sensor_msgs/LaserScan' transformedBy: [ :notification : msg | 
		msg header frame_id: '/laser'.
		notification intoSensor_msgs_LaserScan: msg.
	].

	pureros movementBroadcasterAt: '/odom' typedAs: 'nav_msgs/Odometry'  transformedBy: PureROSOdometryDelegate new callback.
	
	
	
	
]

{ #category : #'as yet unclassified' }
PureROSBasicExperiment >> configureOdometry [
	pureros movementBroadcasterAt: '/odom' typedAs: 'nav_msgs/Odometry'  transformedBy: PureROSOdometryDelegate new callback.
	
	
	
	
]

{ #category : #'as yet unclassified' }
PureROSBasicExperiment >> configurePoseStamped [
	pureros movementBroadcasterAt: '/kompai2/pose' typedAs: 'geometry_msgs/PoseStamped'  transformedBy: [ : notification : msg | 
		notification position intoGeometry_msgs_Pose: msg pose.
	] 	
	
	
	
]

{ #category : #'as yet unclassified' }
PureROSBasicExperiment >> configureTFIn: aFrameID withParent: aParentFrameID [
	pureros notificateMovementAsTF: aFrameID withParent: aParentFrameID
	
	
	
	
]

{ #category : #'as yet unclassified' }
PureROSBasicExperiment >> pureros: aPureROSController [
	pureros := aPureROSController.
	self configure.
]
