Class {
	#name : #PureROSBasicExperiment,
	#superclass : #Object,
	#instVars : [
		'pureros',
		'launch'
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

{ #category : #experiment }
PureROSBasicExperiment >> beginExperiment [
	self setup.

]

{ #category : #configure }
PureROSBasicExperiment >> configureLaser [
	pureros laserBroadcasterAt: '/scan' typedAs: 'sensor_msgs/LaserScan' transformedBy: [ :notification : msg | 
		msg header frame_id: '/laser'.
		notification intoSensor_msgs_LaserScan: msg.
	].

	pureros movementBroadcasterAt: '/odom' typedAs: 'nav_msgs/Odometry'  transformedBy: PureROSOdometryDelegate new callback.
	
	
	
	
]

{ #category : #configure }
PureROSBasicExperiment >> configureOdometry [
	pureros movementBroadcasterAt: '/odom' typedAs: 'nav_msgs/Odometry'  transformedBy: PureROSOdometryDelegate new callback.
	
	
	
	
]

{ #category : #configure }
PureROSBasicExperiment >> configurePoseStamped [
	pureros movementBroadcasterAt: '/kompai2/pose' typedAs: 'geometry_msgs/PoseStamped'  transformedBy: [ : notification : msg | 
		notification position intoGeometry_msgs_Pose: msg pose.
	]. 	
	
	
	
]

{ #category : #configure }
PureROSBasicExperiment >> configureTFIn: aFrameID withParent: aParentFrameID [
	pureros notificateMovementAsTF: aFrameID withParent: aParentFrameID
	
	
	
	
]

{ #category : #experiment }
PureROSBasicExperiment >> endExperiment [
	self teardown. 
	pureros finalize.
	
	launch := nil. 
	
	
	Smalltalk garbageCollect.

]

{ #category : #'initialize-release' }
PureROSBasicExperiment >> finalize [
	self endExperiment.
	super finalize.
]

{ #category : #'initialize-release' }
PureROSBasicExperiment >> initialize [ 
	super initialize.
	self finalizationRegistry add: self.
]

{ #category : #configure }
PureROSBasicExperiment >> launch: aConfigurationFile [
	launch := (PhaROSSystemLauncher instance roslaunch: aConfigurationFile) asStickyReference.
]

{ #category : #accessing }
PureROSBasicExperiment >> pureros: aPureROSController [
	pureros := aPureROSController.
	
]

{ #category : #configure }
PureROSBasicExperiment >> run: anArrayOfArguments [ 
	^ (PhaROSSystemLauncher instance rosrun: anArrayOfArguments).
]

{ #category : #'initialize-release' }
PureROSBasicExperiment >> setup [
	self subclassResponsibility.
	
	
	
]

{ #category : #'initialize-release' }
PureROSBasicExperiment >> teardown [

	
	
	
]
