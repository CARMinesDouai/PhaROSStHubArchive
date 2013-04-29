Class {
	#name : #PureROSController,
	#superclass : #Object,
	#instVars : [
		'robot',
		'driveControler',
		'locationController',
		'notificationController',
		'masterController',
		'transformations'
	],
	#category : #'PureROS-Controllers'
}

{ #category : #'as yet unclassified' }
PureROSController class >> kompai1 [
	| masterController robot |
	
	masterController := PhaROSHandleController localhost.
	robot := PNGRobulabHandcodedFactory kompai1.
	
	^self new masterController: masterController ; robot: robot ; setUp ; yourself.
]

{ #category : #'as yet unclassified' }
PureROSController class >> kompai2 [
	| masterController robot |
	
	masterController := PhaROSHandleController localhost.
	robot := PNGRobulabHandcodedFactory kompai2.
	
	^self new masterController: masterController ; robot: robot  ; yourself.
]

{ #category : #'as yet unclassified' }
PureROSController class >> withMasterAt: anUrl andRobotAt: anIP and: aPort [
	| masterController robot |
	
	masterController := PhaROSHandleController url:  anUrl.
	robot := PNGRobulabDiscoveryFactory robulabFromIp: anIP  port: aPort.
	
	^self new masterController: masterController ; robot: robot ; setUp ; yourself.
	
]

{ #category : #sendings }
PureROSController >> broadcastTransformations [
	
	| transformationsToSend |
	
	transformations size = 0 ifTrue: [ ^ self ].
	transformationsToSend := transformations shallowCopy.
	
	masterController node sendTo: '/tf' a: [: msg |		
			transformationsToSend do: [ : tf | 
				msg addTransform: tf. 
				transformations remove: tf 
			]. 
	]
]

{ #category : #util }
PureROSController >> createNotificationCallbackFor: aTopicName typedAs: aTypeID transformedBy: aBlock [
	^ [: aNotification | 
		masterController node sendTo: aTopicName typedAs: aTypeID a: [
			: msg | 	
			aBlock cull: aNotification cull: msg.
		]	
	].



]

{ #category : #'png-controllers' }
PureROSController >> driveControler [ 
	^ driveControler ifNil: [ driveControler := PurePhaROSDriveCtl for: robot ].
]

{ #category : #'initialize-release' }
PureROSController >> initialize [ 
	super initialize.
	transformations := OrderedCollection new.
]

{ #category : #sendings }
PureROSController >> laserBroadcasterAt: aTopicName typedAs: aTypeID transformedBy: aBlock [
	" broadcast a laser incoming notification into a topic. A transformation LaserNotification >> Specified-Ros-Type is required "
	self notificationController notificateLaserTo: (self createNotificationCallbackFor: aTopicName typedAs: aTypeID transformedBy: aBlock).
]

{ #category : #'png-controllers' }
PureROSController >> locationController [ 
	^ locationController  ifNil: [ locationController := PurePhaROSLocation for: robot ].
]

{ #category : #accessing }
PureROSController >> masterController: aMasterController [
	masterController := aMasterController.
]

{ #category : #sendings }
PureROSController >> movementBroadcasterAt: aTopicName typedAs: aTypeID transformedBy: aBlock [
	" broadcast a localization incoming notification into a topic. A transformation LocalizationNotification >> Specified-Ros-Type is required "
	self notificationController notificateMovementTo: (self createNotificationCallbackFor: aTopicName typedAs: aTypeID transformedBy: aBlock).
	
]

{ #category : #sendings }
PureROSController >> notificateMovementAsTF: aFrameID withParent: aParentFrameID [
	" Brodcast the localization information in the TF topic under the specified frames "

	self notificationController notificateMovementTo: [ : aLocalizationNotification | 
		self notificateTransformationOn: aFrameID withParent: aParentFrameID at: aLocalizationNotification position. 	
	].
]

{ #category : #util }
PureROSController >> notificateTransformationOn: aFrameID withParent: aParentFrameID at: aPNGRobotPose [ 
	" Add transformations to be broadcasted in TF topic. "
	| transformStamped |
	 
	transformStamped := Geometry_msgsTransformStamped new.
	transformStamped child_frame_id: aFrameID.
	transformStamped header frame_id: aParentFrameID.
	transformStamped transform translation x: aPNGRobotPose x.
	transformStamped transform translation y: aPNGRobotPose y.
	transformStamped transform translation z: 0.0.
	PhaROSGeometryTransformations rotationAsQuaternation: (aPNGRobotPose orientation ) into:(transformStamped transform rotation).
	
	transformations add: transformStamped.
]

{ #category : #'png-controllers' }
PureROSController >> notificationController [ 
	^ notificationController   ifNil: [ 
		notificationController  := PurePhaROSNotificationController for: robot. 
		notificationController activateMovementNotifications.
		notificationController activateLaserNotifications.
		notificationController whenAllMovementCallbacksHasBeenCalled: [ self broadcastTransformations ].
		notificationController.
	].
]

{ #category : #accessing }
PureROSController >> robot: aRobot [
	robot := aRobot.
]
