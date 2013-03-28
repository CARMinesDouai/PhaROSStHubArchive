Class {
	#name : #PNGTelemeterNotification,
	#superclass : #PNGNotification,
	#instVars : [
		'distances'
	],
	#category : #'PureNG-Notifications'
}

{ #category : #accessing }
PNGTelemeterNotification >> distances [
	^ distances
]

{ #category : #accessing }
PNGTelemeterNotification >> distances: anObject [
	distances := anObject
]

{ #category : #'initialize-release' }
PNGTelemeterNotification >> initWithDecoder: aDecoder [
	self distances: (self service decodeDistancesFromDecoder: aDecoder)
	
]
