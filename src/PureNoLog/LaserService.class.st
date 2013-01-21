Class {
	#name : #LaserService,
	#superclass : #RobulabService,
	#instVars : [
		'pose',
		'echoNumber'
	],
	#category : #'PureNoLog-Services'
}

{ #category : #accessing }
LaserService >> echoNumber [
	^ echoNumber
]

{ #category : #accessing }
LaserService >> echoNumber: anInteger [
	echoNumber:= anInteger.
]

{ #category : #'as yet unclassified' }
LaserService >> initialize [ 
	pose := Pose new.
]

{ #category : #'as yet unclassified' }
LaserService >> load: aConnector [
	| decoder |

	decoder := (self getWith:aConnector) decoder.


	
	self pose x: decoder nextEncodedFloat32. 
	self pose y: decoder nextEncodedFloat32. 
	self pose orientation: decoder nextEncodedFloat32. 
	
	self echoNumber: decoder nextEncodedInt32. 

	

	
]

{ #category : #accessing }
LaserService >> maxAcceptableRange [
	 ^10.0
]

{ #category : #printing }
LaserService >> pose [
	^ pose.
]

{ #category : #printing }
LaserService >> pose: aPose [
	pose := aPose.
]

{ #category : #printing }
LaserService >> relatedNotificationClass [
	^ LaserNotification
]
