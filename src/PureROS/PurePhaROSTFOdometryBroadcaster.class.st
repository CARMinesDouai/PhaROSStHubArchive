Class {
	#name : #PurePhaROSTFOdometryBroadcaster,
	#superclass : #PurePhaROSNode,
	#instVars : [
		'lastNotification'
	],
	#category : #PureROS
}

{ #category : #'as yet unclassified' }
PurePhaROSTFOdometryBroadcaster >> broadcast: aNotification from: aLocalizationService [
	| transformStamped  |
	
	
	(	
		lastNotification isNil not and:[
			(lastNotification pose closeTo: aLocalizationService pose) 
		]
	) ifTrue: [
		"^ self. "
	].


	lastNotification := aNotification.
	
	[



		self debug: [ 'broadcasting ODOMETRY information to ROS System'].
		self sendTo: '/tf' a: [: msg |
		
			
		
			" BaseLink "
			transformStamped := Geometry_msgsTransformStamped new.
			transformStamped header frame_id: '/odom'.
			transformStamped child_frame_id: '/base_link'.
			transformStamped transform translation x: aNotification pose x.		
			transformStamped transform translation y: aNotification pose y.
			transformStamped transform translation z: 0.0.
			self rotationAsQuaternation: (aNotification pose orientation ) into:(transformStamped transform rotation).
			
			
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


]on: Error do: [
	:e |
	self logError: [ 'Error broadcasting ODOMETRY information to ROS System '].
	self stop. 
	self halt.
]

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
PurePhaROSTFOdometryBroadcaster >> setUp [
	self info: [ 'Starting ODOMETRY broadcaster node'].
	robot with: LocalizationService  do: [
		: localization  |
		localization resetLocalization.
		localization load.
		
		localization whenANotificationArrivesDo:  [ :notif |
			 self broadcast: notif from: localization. 
		].
		localization enableNotifications.
	].

]

{ #category : #'as yet unclassified' }
PurePhaROSTFOdometryBroadcaster >> stop [

	lastNotification := nil. 
	self info: [ 'Shutting down ODOMETRY broadcaster node'].
	
	robot with: NotificationManagerService do: [
		: notification |
		robot with: LocalizationService  do: [
			: localization  |
			localization announcer unsubscribe:  LaserNotification.
			notification stopNotificating: localization.
		].
	].
	super stop. 
	self halt.
	
]
