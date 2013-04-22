Class {
	#name : #PurePhaROSTFOdometryBroadcaster,
	#superclass : #PurePhaROSNode,
	#instVars : [
		'previousNotification',
		'previousTime',
		'odometrySents'
	],
	#category : #PureROS
}

{ #category : #'as yet unclassified' }
PurePhaROSTFOdometryBroadcaster >> broadcast: aNotification [ 
	[
		self sendPose: aNotification.
		self sendTransformations: aNotification.
		self sendOdometry: aNotification.
	]
	on: Error do: [
		:e |
		self stop. 
		self halt.
	].

]

{ #category : #'as yet unclassified' }
PurePhaROSTFOdometryBroadcaster >> initialize [ 
	super initialize.
	odometrySents := 0.
		

]

{ #category : #'as yet unclassified' }
PurePhaROSTFOdometryBroadcaster >> initializeMessage: aMessage [
	| dValue |
	36 timesRepeat: [ 
		aMessage pose covariance add: 0.0. 
		aMessage twist covariance add: 0.0.
	].
	self flag: #lookAtComment.
" This value is really arbitrar.. is based on turtlebot specs, it should be based on robulab, or even better, parametrized "
	dValue := (0.017 * 0.017) roundUpTo: 0.0000001. 
	
	aMessage pose covariance at:1 put: dValue.
	aMessage pose covariance at:8 put: dValue.
	aMessage pose covariance at:15 put: dValue.
	aMessage pose covariance at:22 put: dValue.
	aMessage pose covariance at:29 put: dValue.	
	aMessage pose covariance at:36 put: dValue.
		
	aMessage twist covariance at:1 put: dValue.
	aMessage twist covariance at:8 put: dValue.
	aMessage twist covariance at:15 put: dValue.
	aMessage twist covariance at:22 put: dValue.
	aMessage twist covariance at:29 put: dValue.	
	aMessage twist covariance at:36 put: dValue.
	
]

{ #category : #'as yet unclassified' }
PurePhaROSTFOdometryBroadcaster >> odometrySents [ 
	^ odometrySents.
]

{ #category : #'as yet unclassified' }
PurePhaROSTFOdometryBroadcaster >> period [
	^ 0.
]

{ #category : #'as yet unclassified' }
PurePhaROSTFOdometryBroadcaster >> receive: aMessage from: aChannel [

	| pose position orientation |

	
				
	aChannel topic name=  '/initialpose' ifTrue: [
		pose := aMessage value pose pose .
		position := pose position. 
		orientation := PhaROSGeometryTransformations new eulerFromQuaternation: pose orientation x and: pose orientation y and: pose orientation z and: pose orientation w.
		orientation := orientation at:3. 				
		robot localizationService x: position x y: position y orientation: orientation .
	].
" Take the EFK error correction from tf channel and enhance the robot information to be able to get better movement"


      " We get AMCL error fixing here, which is the final position that ROS will use. We cannot give feedback to the robot with this position because is too unstable "
	aChannel topic name = '/tfaas/map/base_link' ifTrue: [		
		pose := aMessage value pose .
		pureRos currentRosPosition: pose position. 				
				
	].

     " We get the EFK IMU error fixing to have a better position, we use finally this error fixing to feed the robot and to have a better localization to base the odometry. "
	aChannel topic name = '/tfaas/map/base_footprint' ifTrue: [		
"	aChannel topic name = '/tfaas/map/base_link' ifTrue: [		"
		pose := aMessage value pose .
		position := pose position. 
		orientation := PhaROSGeometryTransformations new eulerFromQuaternation: pose orientation x and: pose orientation y and: pose orientation z and: pose orientation w.
		orientation := orientation at:3. 				
		
		
		"Update"
		[ robot localizationService suggestX: position x y: position y orientation: orientation . ] on: Error  do: [].
		"Force"
"		[ robot localizationService x: position x y: position y orientation: orientation . Transcript show: ':)'; cr.] on: Error  do: [Transcript show: ':('; cr.]."
		"Do nothing"
	].
	
	
	

]

{ #category : #'as yet unclassified' }
PurePhaROSTFOdometryBroadcaster >> rotationAsQuaternation: anOrientation into: aQuaternationObject [
	| array |
	" anOrientation is the value of the only one kind of rotation that robulab have, in terms of z axis. "

	array := PhaROSGeometryTransformations new quaternationFromEulerFor: 0.0 and: 0.0 and: anOrientation.
	aQuaternationObject x: (array at:1).
	aQuaternationObject y: (array at:2).
	aQuaternationObject z: (array at:3).
	aQuaternationObject w: (array at:4).
]

{ #category : #'as yet unclassified' }
PurePhaROSTFOdometryBroadcaster >> rotationAsQuaternationInX: anOrientation into: aQuaternationObject [
	| array |
	" anOrientation is the value of the only one kind of rotation that robulab have, in terms of z axis. "

	array := PhaROSGeometryTransformations new quaternationFromEulerFor: 0.0 and: anOrientation and: 0.0.
	aQuaternationObject x: (array at:1).
	aQuaternationObject y: (array at:2).
	aQuaternationObject z: (array at:3).
	aQuaternationObject w: (array at:4).
]

{ #category : #'as yet unclassified' }
PurePhaROSTFOdometryBroadcaster >> sendOdometry: aNotification [
	| deltaTime a b time | 
	
	self sendTo: '/odom' typedAs: 'nav_msgs/Odometry' a: [ :msg |
		self initializeMessage: msg.
		
		msg header frame_id: 'odom'.
		msg child_frame_id: ''.
		msg pose pose position x: aNotification position x.		
		msg pose pose position y: aNotification position y.
		msg pose pose position z: 0.0.
		
		self rotationAsQuaternation:aNotification position orientation  into: msg pose pose orientation.

		time := DateAndTime now.
						
		previousNotification ifNotNil: [
			
			a := time asSeconds.
			b := previousTime asSeconds.
			deltaTime :=  (b - a) abs.

			deltaTime = 0 ifFalse:[
				odometrySents := odometrySents + 1.
				" Linear velocity "
				msg twist twist linear x: ( aNotification position x - previousNotification position x ) / deltaTime .
				msg twist twist linear y: ( aNotification position y - previousNotification position y ) / deltaTime .
				
				" Angular velocity "
				msg twist twist angular z:  ((aNotification position orientation  - previousNotification position orientation) / deltaTime) / ( 2 * Float pi ) .
				
			]
		].
		previousNotification := aNotification.
		previousTime := time.
		
	].
]

{ #category : #'as yet unclassified' }
PurePhaROSTFOdometryBroadcaster >> sendPose: aNotification [
	| transformStamped |
	
		self sendTo: '/kompai2/pose'  typedAs: 'geometry_msgs/PoseStamped' a: [: msg |		
		
			" BaseLink "
			transformStamped := Geometry_msgsTransformStamped new.
			transformStamped header frame_id: '/base_footprint'.
			transformStamped child_frame_id: '/base_link'.
			
			
			msg pose position x: aNotification position x.
			msg pose position y: aNotification position y.
			msg pose position z: 0.0.
			
			self rotationAsQuaternation: (aNotification position orientation ) into:(msg pose orientation). 
			
	
			
		].

]

{ #category : #'as yet unclassified' }
PurePhaROSTFOdometryBroadcaster >> sendTransformations: aNotification [
	| transformStamped |
	
		self sendTo: '/tf' a: [: msg |		
		
			" BaseLink "
			transformStamped := Geometry_msgsTransformStamped new.
			
			transformStamped child_frame_id: '/base_link'.
			
			
			" EFK - IMU "
			"
			transformStamped header frame_id: '/base_footprint'.
			transformStamped transform translation x: 0.0.
			transformStamped transform translation y: 0.0.
			transformStamped transform translation z: 0.0.
			self rotationAsQuaternation: ( 0.0 ) into:(transformStamped transform rotation).
			"
			
			
			" AMCL "
			transformStamped header frame_id: '/odom'.
			transformStamped transform translation x: aNotification position x.
			transformStamped transform translation y: aNotification position y.
			transformStamped transform translation z: 0.0.
			self rotationAsQuaternation: (aNotification position orientation ) into:(transformStamped transform rotation).
			
			
			msg addTransform: transformStamped.
			
			
			
			
			transformStamped := Geometry_msgsTransformStamped new.
			
			transformStamped child_frame_id: '/robot'.
			transformStamped header frame_id: '/map'.
			transformStamped transform translation x: aNotification position x.
			transformStamped transform translation y: aNotification position y.
			transformStamped transform translation z: 0.0.
			self rotationAsQuaternation: (aNotification position orientation ) into:(transformStamped transform rotation).
			
			
			msg addTransform: transformStamped.
			
			
			
		].

]

{ #category : #'as yet unclassified' }
PurePhaROSTFOdometryBroadcaster >> setUp [
	"robot localizationService resetPose. "
	robot localizationService onNotificationDo: [ : notification | self broadcast: notification ].
	[robot localizationService enableNotificationsEvery: 10.] on: PNGMessageError do: [ ].
	self interestedIn: '/initialpose' typedAs: 'geometry_msgs/PoseWithCovarianceStamped'.
	self interestedIn: '/tfaas/map/base_link' typedAs: 'geometry_msgs/PoseStamped'.
	self interestedIn: '/tfaas/map/base_footprint' typedAs: 'geometry_msgs/PoseStamped'.
]

{ #category : #'as yet unclassified' }
PurePhaROSTFOdometryBroadcaster >> stop [

	
	robot localizationService onNotificationDo: [].
	super stop. 
	self halt.
	
]
