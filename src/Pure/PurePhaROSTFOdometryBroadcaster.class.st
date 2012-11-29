Class {
	#name : #PurePhaROSTFOdometryBroadcaster,
	#superclass : #PurePhaROSNode,
	#instVars : [
		'lastNotification'
	],
	#category : #Pure
}

{ #category : #'as yet unclassified' }
PurePhaROSTFOdometryBroadcaster >> broadcast: aNotification from: aLocalizationService [
	| transformStamped  |
	
	
	(	
		lastNotification isNil not and:[
			(lastNotification xPos closeTo: aLocalizationService xPos) and: [
				(lastNotification yPos closeTo: aLocalizationService yPos) and: [
					(lastNotification orientation closeTo: aLocalizationService orientation ).
				]
			]
		]
	) ifTrue: [
		^ self. 
	].

	Transcript show: 'bl'.
	lastNotification := aNotification.
	
	[
		self sendTo: '/tf' a: [: msg |
		
			" Odometry "
			transformStamped := Geometry_msgsTransformStamped new.
			transformStamped header frame_id: '/map'.
			transformStamped child_frame_id: '/odom'.
			transformStamped transform translation x: aLocalizationService xPos.		
			transformStamped transform translation y: aLocalizationService yPos.
			transformStamped transform translation z: 0.0.
			self rotationAsQuaternation: aLocalizationService orientation into:(transformStamped transform rotation).
			
			msg addTransform: transformStamped.
			
			
			" BaseLink "
			transformStamped := Geometry_msgsTransformStamped new.
			transformStamped header frame_id: '/odom'.
			transformStamped child_frame_id: '/base_link'.
			transformStamped transform translation z: 0.1.
			transformStamped transform rotation w: 1.0.
			
			msg addTransform: transformStamped.
			
			
					
			" Laser "
			transformStamped := Geometry_msgsTransformStamped new.
			transformStamped header frame_id: '/base_link'.
			transformStamped child_frame_id: '/laser'.
			transformStamped transform translation z: 10.0.
			transformStamped transform rotation w: 1.0.
			msg addTransform: transformStamped.
			
	].

]on: Error do: [
	:e |
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
PurePhaROSTFOdometryBroadcaster >> setUp [

	robot with: NotificationManagerService do: [
		: notification |
		robot with: LocalizationService  do: [
			: localization  |
			localization announcer subscribe: LocalizationNotification do: [ :notif |
				 self broadcast: notif from: localization. 
			].
			notification addNotificationRecordToInstance: localization withPeriod:  self period.
		].
	].
	
]

{ #category : #'as yet unclassified' }
PurePhaROSTFOdometryBroadcaster >> stop [

	lastNotification := nil. 
	super stop. 
	
	robot with: NotificationManagerService do: [
		: notification |
		robot with: LocalizationService  do: [
			: localization  |
			localization announcer unsubscribe:  LaserNotification.
			notification deleteNotificationRecordFromService:  localization.
		].
	].
	self halt.
	
]
