Class {
	#name : #PurePhaROSLaserBroadcaster,
	#superclass : #PurePhaROSNode,
	#category : #'Pure-PhaROS'
}

{ #category : #'as yet unclassified' }
PurePhaROSLaserBroadcaster >> broadcast: aLaserNotification from: aLaserServiceInstance [ 


	[
	self sendTo: '/scan' a: [ :msg |
		msg header frame_id: 'laser'.
		
		msg angle_min: aLaserNotification minAngle.
		msg angle_max: aLaserNotification maxAngle.
		msg angle_increment: aLaserNotification angleDifferential.
		
		msg scan_time: 0.1.
		msg time_increment: 0.01.
		
		msg range_min: aLaserNotification minRange.
		msg range_max: aLaserNotification maxRange.
		msg ranges addAll: aLaserNotification distances.		
	].	

]on: Error do: [
	self stop. 
]

]

{ #category : #'as yet unclassified' }
PurePhaROSLaserBroadcaster >> period [
	^ 10.
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
	
	
]
