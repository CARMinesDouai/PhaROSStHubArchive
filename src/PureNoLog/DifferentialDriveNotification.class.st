Class {
	#name : #DifferentialDriveNotification,
	#superclass : #ServiceNotification,
	#instVars : [
		'status',
		'targetLinearSpeed',
		'currentLinearSpeed',
		'targetAngularSpeed',
		'currentAngularSpeed'
	],
	#category : #'PureNoLog-Notifications'
}

{ #category : #accessing }
DifferentialDriveNotification >> currentAngularSpeed [
	^ currentAngularSpeed
]

{ #category : #accessing }
DifferentialDriveNotification >> currentLinearSpeed [ 
	^currentLinearSpeed 

]

{ #category : #accessing }
DifferentialDriveNotification >> load: notificationSource [
	| decoder |
	super load: notificationSource.
	decoder := notificationSource decoder.
	status := decoder nextEncodedByte.
	targetLinearSpeed := decoder nextEncodedFloat32.
	currentLinearSpeed  := decoder nextEncodedFloat32.
	targetAngularSpeed := decoder nextEncodedFloat32.
	currentAngularSpeed  := decoder nextEncodedFloat32.
	
	
	

]

{ #category : #accessing }
DifferentialDriveNotification >> status [ 
	^ status
]

{ #category : #accessing }
DifferentialDriveNotification >> targetAngularSpeed [ 
	^targetAngularSpeed 

]

{ #category : #accessing }
DifferentialDriveNotification >> targetLinearSpeed [ 
	^targetLinearSpeed .

]
