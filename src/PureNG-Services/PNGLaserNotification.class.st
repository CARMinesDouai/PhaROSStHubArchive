Class {
	#name : #PNGLaserNotification,
	#superclass : #PNGNotification,
	#instVars : [
		'echoes'
	],
	#category : #'PureNG-Notifications'
}

{ #category : #'as yet unclassified' }
PNGLaserNotification >> angles [
	^ self echoes collect: [ :echo | echo angle asFloat ].
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
PNGLaserNotification >> initWithDecoder: aDecoder [
	self echoes: (self service decodeEchoesFromDecoder: aDecoder)
	
]
