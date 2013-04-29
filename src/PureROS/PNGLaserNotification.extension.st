Extension { #name : #PNGLaserNotification }

{ #category : #'*PureROS' }
PNGLaserNotification >> intoSensor_msgs_LaserScan: aMsg [
		aMsg angle_min: self angles min.
		aMsg angle_max: self angles max.
		aMsg angle_increment: (1.0 degreesToRadians).
		
		aMsg scan_time: 0.0.
		aMsg time_increment: 0.0.
		
		aMsg range_min: self distances min.
		aMsg range_max: self distances max.
		aMsg ranges addAll: self distances.
]
