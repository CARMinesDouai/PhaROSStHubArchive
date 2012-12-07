Class {
	#name : #PurePhaROSLaserBroadcaster,
	#superclass : #PurePhaROSNode,
	#category : #PureROS
}

{ #category : #'as yet unclassified' }
PurePhaROSLaserBroadcaster >> broadcast: aLaserNotification from: aLaserServiceInstance [ 


[
	
	self sendTo: '/scan' a: [ :msg |
		
		
		msg header frame_id: '/laser'.
		
		msg angle_min: aLaserNotification minAngle.
		msg angle_max: aLaserNotification maxAngle.
		msg angle_increment: (0.5 degreesToRadians).
		
		
		msg scan_time: 0.0.
		msg time_increment: 0.0.
		
		msg range_min: aLaserNotification minRange.
		msg range_max: aLaserNotification maxRange.
		msg ranges addAll: aLaserNotification distances.	

	].	
	
	]on: Error do: [
		:e| 
	
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

	robot with: NotificationManagerService do: [
		: notification |
		robot with: LaserService  do: [
			:laser |
			laser announcer subscribe: LaserNotification do: [ :notif |
				 self broadcast: notif from: laser. 
			].
			notification addNotificationRecordToInstance: laser withPeriod:  self period.
		].
	].
	
]

{ #category : #'as yet unclassified' }
PurePhaROSLaserBroadcaster >> stop [ 
	super stop. 
	
	robot with: NotificationManagerService do: [
		: notification |
		robot with: LaserService  do: [
			:laser  |
			laser announcer unsubscribe:  LaserNotification.
			notification deleteNotificationRecordFromService:  laser.
		].
	].
	
	self halt.
]
