Class {
	#name : #PNGLocalizationNotification,
	#superclass : #PNGNotification,
	#instVars : [
		'position'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'initialize-release' }
PNGLocalizationNotification >> initWithDecoder: aDecoder [
	^self service decodePositionFromDecoder: aDecoder 
]
