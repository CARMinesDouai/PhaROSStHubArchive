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
	
	self xPos: decoder nextEncodedFloat64. 
	self yPos: decoder nextEncodedFloat64. 
	self orientation: decoder nextEncodedFloat64. 
	self status: decoder nextEncodedUInt16 . 
]

{ #category : #accessing }
LocalizationNotification >> orientation: aFloat [ 
	orientation := aFloat.
]

{ #category : #accessing }
LocalizationNotification >> status: aSmallInteger [ 
	status := aSmallInteger
]

{ #category : #accessing }
LocalizationNotification >> xPos: aFloat [ 
	xPos := aFloat.
]

{ #category : #accessing }
LocalizationNotification >> yPos: aFloat [ 
	yPos := aFloat.
]
