Class {
	#name : #PurePhaROSLaserBroadcaster,
	#superclass : #PurePhaROSNode,
	#category : #PureROS
}

{ #category : #'as yet unclassified' }
PurePhaROSLaserBroadcaster >> broadcast: aLaserNotification from: aLaserServiceInstance [ 

[
	self debug: [ 'broadcasting LASER information to ROS System'].
	self sendTo: '/scan' a: [ :msg |
		
		
		msg header frame_id: '/laser'.
		
		msg angle_min: aLaserNotification minAngle.
		msg angle_max: aLaserNotification maxAngle.
		msg angle_increment: (1.0 degreesToRadians).
		
		Transcript show: 'Measures expected', ((aLaserNotification minAngle abs + aLaserNotification maxAngle abs)/(1.0 degreesToRadians)) asString ;cr.
		Transcript show: 'Measures: ', aLaserNotification distances size asString;cr.
		
		msg scan_time: 0.0.
		msg time_increment: 0.0.
		
		msg range_min: aLaserNotification minRange.
		msg range_max: (aLaserNotification maxRange max: aLaserServiceInstance maxAcceptableRange).
		msg ranges addAll: (aLaserNotification distances select: [ :float | float <= aLaserServiceInstance maxAcceptableRange ]).	

	].	
	
	]on: Error do: [
		:e| 
		self logError: [ 'Error broadcasting LASER information '].
		self stop. 
		self halt.
]




]

{ #category : #'as yet unclassified' }
PurePhaROSLaserBroadcaster >> period [
	^ 1.
]

{ #category : #'as yet unclassified' }
PurePhaROSLaserBroadcaster >> setUp [
	self info: [ 'Starting LASER broadcaster node'].
	robot with: LaserService  do: [
		:laser |
		laser whenANotificationArrivesDo: [ :notif |
			 self broadcast: notif from: laser. 
		].
		laser enableNotifications.
	].
	
]

{ #category : #'as yet unclassified' }
PurePhaROSLaserBroadcaster >> stop [ 
	self info: [ 'Shutting down LASER broadcaster node'].
	super stop. 
	
	robot with: NotificationManagerService do: [
		: notification |
		robot with: LaserService  do: [
			:laser  |
			laser announcer unsubscribe:  LaserNotification.
			notification stopNotificating:  laser.
		].
	].
	
	self halt.
]
