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
	
	
	
	"Ireally hate this stupid thing "
	decoder nextEncodedBytes: 8. 
	
	
	self xPos: decoder nextEncodedFloat64. 
	self yPos: decoder nextEncodedFloat64. 
	self orientation: decoder nextEncodedFloat64. 
	self status: decoder nextEncodedUInt32. 
]

{ #category : #accessing }
LocalizationNotification >> orientation [ 
	^ orientation.
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
	^ xPos.
]

{ #category : #accessing }
LocalizationNotification >> xPos: aFloat [ 
	xPos := aFloat.
]

{ #category : #accessing }
LocalizationNotification >> yPos [
	^ yPos.
]

{ #category : #accessing }
LocalizationNotification >> yPos: aFloat [ 
	yPos := aFloat.
]
