"
This service exposes an array of drives. It allows to get their states (status, position, speed, torque) through outbound notifications. The drives can be controlled (position, velocity or torque mode) through inbound notifications.
"
Class {
	#name : #PNGDriveService,
	#superclass : #PNGService,
	#category : #'PureNG-Kernel'
}

{ #category : #constants }
PNGDriveService class >> serviceType [ 
	^ 16r4009
]
