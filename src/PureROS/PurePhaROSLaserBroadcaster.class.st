Class {
	#name : #PurePhaROSLaserBroadcaster,
	#superclass : #PurePhaROSNode,
	#category : #'PureROS-Deprecated'
}

{ #category : #'as yet unclassified' }
PurePhaROSLaserBroadcaster >> broadcast: aLaserNotification [
[
	self sendTo: '/scan' typedAs:'sensor_msgs/LaserScan' a: [ :msg |
		
		
		msg header frame_id: '/laser'.
		
		aLaserNotification intoSensor_msgs_LaserScan: msg.
		
		msg range_max: (aLaserNotification distances max max: robot laserService maxAcceptableRange).
		
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
