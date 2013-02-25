Class {
	#name : #PurePhaROSLaserBroadcaster,
	#superclass : #PurePhaROSNode,
	#category : #PureROS
}

{ #category : #'as yet unclassified' }
PurePhaROSLaserBroadcaster >> broadcast: aLaserNotification [
[
	self sendTo: '/scan' a: [ :msg |
		
		
		msg header frame_id: '/laser'.
		
		msg angle_min: aLaserNotification angles min.
		msg angle_max: aLaserNotification angles max.
		msg angle_increment: (1.0 degreesToRadians).
		
		msg scan_time: 0.0.
		msg time_increment: 0.0.
		
		msg range_min: aLaserNotification distances min.
		msg range_max: (aLaserNotification distances max max: robot laserService maxAcceptableRange).
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
	
	robot laserService onNotificationDo: [ : notification |  self broadcast: notification. 	].
	[robot laserService enableNotificationsEvery: 0.] on: PNGMessageError do: [ ].

]

{ #category : #'as yet unclassified' }
PurePhaROSLaserBroadcaster >> stop [ 
	super stop. 
	robot laserService onNotificationDo: [].
	self halt.
	 
]
