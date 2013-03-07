Class {
	#name : #PNGLaserNotification,
	#superclass : #PNGNotification,
	#instVars : [
		'echoes'
	],
	#category : #'PureNG-Notifications'
}

{ #category : #accessing }
PNGLaserNotification >> angles [
	^ self echoes collect: [ :echo | echo angle asFloat ].
]

{ #category : #accessing }
PNGLaserNotification >> distances [
	^ self echoes collect: [ :echo | echo distance asFloat ].
]

{ #category : #accessing }
PNGLaserNotification >> echoes [
	^ echoes
]

{ #category : #accessing }
PNGLaserNotification >> echoes: anObject [
	echoes := anObject
]

{ #category : #'initialize-release' }
PNGLaserNotification >> initWithDecoder: aDecoder [
	self echoes: (self service decodeEchoesFromDecoder: aDecoder)
	
]
