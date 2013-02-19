Class {
	#name : #PNGLaserNotification,
	#superclass : #PNGNotification,
	#instVars : [
		'echoes'
	],
	#category : #'PureNG-Notifications'
}

{ #category : #accessing }
PNGLaserNotification >> echoes [
	^ echoes
]

{ #category : #accessing }
PNGLaserNotification >> echoes: anObject [
	echoes := anObject
]

{ #category : #'as yet unclassified' }
PNGLaserNotification >> initWithDecoder: aDecoder [
	self echoes: (self service decodeEchoesFromDecoder: aDecoder)
	
]
