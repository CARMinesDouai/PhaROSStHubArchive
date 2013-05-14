Class {
	#name : #PureROSBasicExperiment,
	#superclass : #Object,
	#instVars : [
		'pureros',
		'launch',
		'tracker'
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

{ #category : #util }
PureROSBasicExperiment >> buildValueTrackerFor: aTopicID [ 
	| connector |
	
	connector := pureros buildConnectionFor: aTopicID.	
	connector for: [ : aValue | tracker track: aValue from: aTopicID ] .
	^ connector.
]

{ #category : #'configure-subscribing' }
PureROSBasicExperiment >> configureCommandVelocity [
	| connector |
	
	connector := pureros buildConnectionFor: '/command_velocity'.
	
	connector 
			typedAs: 'geometry_msgs/Twist';
			adapted: PNGDifferentiaVelocity;
			when: [ :msg | 

					self assert: msg value linear y = 0.0 description: ' Ensure that  holonomic_robot: false in the planner configuration (commonly named base_local_planner_params.yaml)'.
					self assert: msg value linear z = 0.0 description: ' Ensure that  holonomic_robot: false in the planner configuration (commonly named base_local_planner_params.yaml)'.
					self assert: msg value angular y = 0.0 description: ' Ensure that  holonomic_robot: false in the planner configuration (commonly named base_local_planner_params.yaml)'.
					self assert: msg value angular x = 0.0 description: ' Ensure that  holonomic_robot: false in the planner configuration (commonly named base_local_planner_params.yaml)'.
			];
			for: [ : aPNGRobotPose | pureros locationController setPose: aPNGRobotPose ] .

	connector connect.
]

{ #category : #'configure-subscribing' }
PureROSBasicExperiment >> configureInitialPose [
	| connector |
	
	connector := pureros buildConnectionFor: '/initialpose'.
	
	connector 
			typedAs: 'geometry_msgs/PoseWithCovarianceStamped';
			adapted: #pose \> #pose \> PNGRobotPose;
			for: [ : aPNGRobotPose | pureros locationController setPose: aPNGRobotPose ] .

	connector connect.
]

{ #category : #'configure-publishing' }
PureROSBasicExperiment >> configureLaser [
	pureros laserBroadcasterAt: '/scan' typedAs: 'sensor_msgs/LaserScan' transformedBy: [ :notification : msg | 
		msg header frame_id: '/laser'.
		notification intoSensor_msgs_LaserScan: msg.
	].

	pureros movementBroadcasterAt: '/odom' typedAs: 'nav_msgs/Odometry'  transformedBy: PureROSOdometryDelegate new callback.
	
	
	
	
]

{ #category : #'configure-publishing' }
PureROSBasicExperiment >> configureOdometry [
	pureros movementBroadcasterAt: '/odom' typedAs: 'nav_msgs/Odometry'  transformedBy: PureROSOdometryDelegate new callback.
	
	
	
	
]

{ #category : #'configure-publishing' }
PureROSBasicExperiment >> configurePoseStamped [
	pureros movementBroadcasterAt: '/kompai2/pose' typedAs: 'geometry_msgs/PoseStamped'  transformedBy: [ : notification : msg | 
		notification position intoGeometry_msgs_Pose: msg pose.
	]. 	
	
	
	
]

{ #category : #'configure-subscribing' }
PureROSBasicExperiment >> configureTFAASTrackerFrom: aFrame to: anOtherFrame [
	| connector topicName |
	
	topicName := self tfaasTopicNameFor: aFrame and: anOtherFrame.
	
	connector := self buildValueTrackerFor: topicName.
	connector typedAs: 'geometry_msgs/PoseStamped'.
	connector connect.
	
	^ self valueTracker: topicName.
]

{ #category : #'configure-publishing' }
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
	tracker := PureROSValueTracker new. 
]

{ #category : #'configure-system' }
PureROSBasicExperiment >> launch: aConfigurationFile [
	launch := (PhaROSSystemLauncher instance roslaunch: aConfigurationFile) asStickyReference.
]

{ #category : #accessing }
PureROSBasicExperiment >> pureros: aPureROSController [
	pureros := aPureROSController.
	
]

{ #category : #'configure-system' }
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

{ #category : #util }
PureROSBasicExperiment >> tfaasTopicNameFor: aFrame and: anOtherFrame [
	| from to |
	
	from := aFrame normalizeFrame.
	to := anOtherFrame normalizeFrame.
	
	
	^ '/tfaas/', from, '/', to.
]

{ #category : #util }
PureROSBasicExperiment >> valueTracker: aTopicID [ 
	^ tracker tracker: aTopicID.
	
]
