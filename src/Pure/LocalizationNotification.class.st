Class {
	#name : #LocalizationNotification,
	#superclass : #ServiceNotification,
	#instVars : [
		'pose',
		'status'
	],
	#category : #'Pure-Notifications'
}

{ #category : #accessing }
LocalizationNotification >> closeTo: anOtherNotification [ 
	| compare |
	
	compare := (anOtherNotification isKindOf: self class) .
	
	^ compare and: [
		pose closeTo: anOtherNotification pose.
	 ].
	
]

{ #category : #loading }
LocalizationNotification >> initialize [ 
	pose := Pose new.
]

{ #category : #loading }
LocalizationNotification >> load: notificationSource [ 
	| decoder |

	decoder := notificationSource decoder.
	self loadTime: decoder.
	
	self pose x: (((decoder nextEncodedFloat64) roundUpTo: 0.0001 )roundDownTo: -0.0001). 
	self pose y: (((decoder nextEncodedFloat64) roundUpTo: 0.0001 )roundDownTo: -0.0001). 
	self pose orientation: (((decoder nextEncodedFloat64) roundUpTo: 0.0001 )roundDownTo: -0.0001). 
	
	self status: decoder nextEncodedByte. 
	


]

{ #category : #accessing }
LocalizationNotification >> orientation [ 
	self deprecated: ' use  localization pose orientation instead of orientation'. 
	^  self pose orientation.
]

{ #category : #loading }
LocalizationNotification >> pose [
	^ pose.
]

{ #category : #accessing }
LocalizationNotification >> status [
	^ status.
]

{ #category : #accessing }
LocalizationNotification >> status: aSmallInteger [ 
	status := aSmallInteger
]

{ #category : #accessing }
LocalizationNotification >> xPos [
	self deprecated: ' use  notification pose x instead of xPos'. 
	^ self pose x
]

{ #category : #accessing }
LocalizationNotification >> yPos [
	self deprecated: ' use  localization pose y instead of yPos'. 
	^ self pose y.
]
