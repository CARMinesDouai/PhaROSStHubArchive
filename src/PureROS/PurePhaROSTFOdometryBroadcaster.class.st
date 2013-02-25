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

		36 timesRepeat: [ 
			aMessage pose covariance add: 0.0. 
			aMessage twist covariance add: 0.0.
		].
		
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
				msg twist twist linear x: (aNotification position x - previousNotification position x) / deltaTime .
				msg twist twist linear y: (aNotification position x - previousNotification position x) / deltaTime .
				
				" Angular velocity "
				msg twist twist angular z:  (aNotification position orientation  - previousNotification position orientation) / deltaTime .
			]
		].
		previousNotification := aNotification.
		previousTime := time.
		
	].
]

{ #category : #'as yet unclassified' }
PurePhaROSTFOdometryBroadcaster >> sendTransformations: aNotification [
	| transformStamped |
	
		self sendTo: '/tf' a: [: msg |		
		
			" BaseLink "
			transformStamped := Geometry_msgsTransformStamped new.
			transformStamped header frame_id: '/odom'.
			transformStamped child_frame_id: '/base_link'.
			transformStamped transform translation x: aNotification position x.
			transformStamped transform translation y: aNotification position y.
			transformStamped transform translation z: 0.0.
			self rotationAsQuaternation: (aNotification position orientation ) into:(transformStamped transform rotation).
			
			
			msg addTransform: transformStamped.
			
			
			" Laser "
			transformStamped := Geometry_msgsTransformStamped new.
			transformStamped header frame_id: '/base_link'.
			transformStamped child_frame_id: '/laser'.
			transformStamped transform translation x: -0.15.
			transformStamped transform translation z: 0.25.

			self rotationAsQuaternation: 0.0 into:(transformStamped transform rotation).
			msg addTransform: transformStamped.
			
			
		].

]

{ #category : #'as yet unclassified' }
PurePhaROSTFOdometryBroadcaster >> setUp [
	robot localizationService resetPose. 
	robot localizationService onNotificationDo: [ : notification | self broadcast: notification ].
	[robot localizationService enableNotificationsEvery: 0.] on: PNGMessageError do: [ ].
]

{ #category : #'as yet unclassified' }
PurePhaROSTFOdometryBroadcaster >> stop [

	
	robot localizationService onNotificationDo: [].
	super stop. 
	self halt.
	
]
