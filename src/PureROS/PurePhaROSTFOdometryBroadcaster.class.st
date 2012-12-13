Class {
	#name : #PurePhaROSTFOdometryBroadcaster,
	#superclass : #PurePhaROSNode,
	#instVars : [
		'lastNotification',
		'xDelta',
		'yDelta',
		'oDelta'
	],
	#category : #PureROS
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
		"^ self. "
	].


	lastNotification := aNotification.
	
	[



	
		self sendTo: '/tf' a: [: msg |
		
			
		
			" BaseLink "
			transformStamped := Geometry_msgsTransformStamped new.
			transformStamped header frame_id: '/odom'.
			transformStamped child_frame_id: '/base_link'.
			transformStamped transform translation x: (aNotification xPos + xDelta ).		
			transformStamped transform translation y: (aNotification yPos + yDelta ).
			transformStamped transform translation z: 0.0.
			self rotationAsQuaternation: (aNotification orientation + oDelta) into:(transformStamped transform rotation).
			
			
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
	
	robot with: NotificationManagerService do: [
		: notification |
		robot with: LocalizationService  do: [
			: localization  |
			localization resetLocalization.
			localization getData.
			self zeroDifferentialX: localization xPos y: localization yPos orientation: localization orientation.
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
			localization resetLocalization.
			localization announcer unsubscribe:  LaserNotification.
			notification deleteNotificationRecordFromService:  localization.
		].
	].
	self halt.
	
]

{ #category : #'as yet unclassified' }
PurePhaROSTFOdometryBroadcaster >> zeroDifferentialX: xPos y: yPos orientation: orientation [
"
	xDelta := 0.0 - xPos. 
	yDelta := 0.0 - yPos.
	oDelta := 0.0 - orientation."
	
	xDelta := 0.0 . 
	yDelta := 0.0 .
	oDelta := 0.0 .
]
