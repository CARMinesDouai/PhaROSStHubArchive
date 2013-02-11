Class {
	#name : #PNGLocalizationNotification,
	#superclass : #PNGNotification,
	#instVars : [
		'position'
	],
	#category : #'PureNG-Notifications'
}

{ #category : #'initialize-release' }
PNGLocalizationNotification >> initWithDecoder: aDecoder [
	self position: (self service decodePositionFromDecoder: aDecoder) 
]

{ #category : #accessing }
PNGLocalizationNotification >> position [
	^ position
]

{ #category : #accessing }
PNGLocalizationNotification >> position: anObject [
	position := anObject
]
