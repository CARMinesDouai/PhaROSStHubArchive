Class {
	#name : #PNGUnknownNotification,
	#superclass : #PNGNotification,
	#instVars : [
		'decoder'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #accessing }
PNGUnknownNotification >> decoder [
	^ decoder
]

{ #category : #accessing }
PNGUnknownNotification >> decoder: anObject [
	decoder := anObject
]

{ #category : #'initialize-release' }
PNGUnknownNotification >> initWithDecoder: aDecoder [
	self decoder: aDecoder 
]
