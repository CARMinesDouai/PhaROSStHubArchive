Class {
	#name : #DifferentialDriveService,
	#superclass : #RobulabService,
	#instVars : [
		'maximumSpeed',
		'minimumSpeed',
		'maximumAcceleration',
		'minimumAcceleration',
		'width'
	],
	#category : #'Pure-Services'
}

{ #category : #'initialize-release' }
DifferentialDriveService >> initialize [ 

	maximumSpeed  := Movement new. 
	minimumSpeed := Movement new. 
	maximumAcceleration  := Movement new. 
	minimumAcceleration  := Movement new. 
]

{ #category : #'initialize-release' }
DifferentialDriveService >> load: aConnector [ 
	|decoder | 
	
	decoder := (self getWith: aConnector) decoder.
	
	self maximumSpeed linear:  decoder nextEncodedFloat32. 	
	self minimumSpeed linear:  decoder nextEncodedFloat32.  


	self maximumSpeed angular: decoder nextEncodedFloat32. 
	self minimumSpeed  angular: decoder nextEncodedFloat32. 


	self maximumAcceleration linear: decoder nextEncodedFloat32. 	
	self minimumAcceleration linear: decoder nextEncodedFloat32. 
	
	self maximumAcceleration angular: decoder nextEncodedFloat32. 	
	self minimumAcceleration angular: decoder nextEncodedFloat32. 
	
	self width: decoder nextEncodedFloat32. 
	
	
]

{ #category : #accessing }
DifferentialDriveService >> maximumAcceleration [
	^ maximumAcceleration
]

{ #category : #accessing }
DifferentialDriveService >> maximumAcceleration: anObject [
	maximumAcceleration := anObject
]

{ #category : #accessing }
DifferentialDriveService >> maximumSpeed [
	^ maximumSpeed
]

{ #category : #accessing }
DifferentialDriveService >> maximumSpeed: anObject [
	maximumSpeed  := anObject
]

{ #category : #accessing }
DifferentialDriveService >> minimumAcceleration [ 
	^ minimumAcceleration 
]

{ #category : #accessing }
DifferentialDriveService >> minimumAcceleration: anObject [
	minimumAcceleration := anObject
]

{ #category : #accessing }
DifferentialDriveService >> minimumSpeed [ 
	^ minimumSpeed 
]

{ #category : #accessing }
DifferentialDriveService >> minimumSpeed: anObject [
	minimumSpeed := anObject
]

{ #category : #accessing }
DifferentialDriveService >> relatedNotificationClass [
	^ DifferentialDriveNotification 
]

{ #category : #request }
DifferentialDriveService >> setTargetLinearSpeed: linspeed andTargetAngularSpeed: angspeed [
	|  encoder |
	
	
	encoder := PureEncoder forArray: (String new: 16).
		
	encoder encodefloat32: linspeed.
	encoder encodefloat32: angspeed.

	self sendNotification:'01', encoder contents.
]

{ #category : #accessing }
DifferentialDriveService >> width [
	^ width
]

{ #category : #accessing }
DifferentialDriveService >> width: anObject [
	width := anObject
]
