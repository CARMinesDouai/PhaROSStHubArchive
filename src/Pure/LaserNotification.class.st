Class {
	#name : #LaserNotification,
	#superclass : #ServiceNotification,
	#instVars : [
		'echoes'
	],
	#category : #'Pure-Notifications'
}

{ #category : #'as yet unclassified' }
LaserNotification >> initialize [ 
	echoes := OrderedCollection new.
	
]

{ #category : #'as yet unclassified' }
LaserNotification >> load: notificationSource [
	| decoder |
	
	decoder := notificationSource decoder.
	
	1 to: service echoNumber do: [
		echoes add: ( LaserEcho createEchoWithAngle: (decoder nextEncodedFloat32)  andFloatDistance: (decoder nextEncodedFloat32) )
	] .
	
]
