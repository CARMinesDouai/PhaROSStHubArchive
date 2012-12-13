Class {
	#name : #LocalizationNotification,
	#superclass : #ServiceNotification,
	#instVars : [
		'xPos',
		'yPos',
		'orientation',
		'status'
	],
	#category : #'Pure-Notifications'
}

{ #category : #loading }
LocalizationNotification >> load: aPureNotification [ 
	| decoder |
	decoder := aPureNotification decoder.
	
	self loadTime: decoder.
	
	self xPos: decoder nextEncodedFloat64. 
	self yPos: decoder nextEncodedFloat64. 
	self orientation: decoder nextEncodedFloat64. 
	
	self status: decoder nextEncodedByte. 
	


]

{ #category : #accessing }
LocalizationNotification >> orientation [ 
	^  (orientation  roundUpTo: 0.0001 )roundDownTo: -0.0001
]

{ #category : #accessing }
LocalizationNotification >> orientation: aFloat [ 
	orientation := aFloat.
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
	^ (xPos roundUpTo: 0.0001 )roundDownTo: -0.0001
]

{ #category : #accessing }
LocalizationNotification >> xPos: aFloat [ 
	xPos := aFloat.
]

{ #category : #accessing }
LocalizationNotification >> yPos [
	^  (yPos roundUpTo: 0.0001 )roundDownTo: -0.0001
]

{ #category : #accessing }
LocalizationNotification >> yPos: aFloat [ 
	yPos := aFloat.
]
