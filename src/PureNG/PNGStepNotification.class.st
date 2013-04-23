Class {
	#name : #PNGStepNotification,
	#superclass : #PNGNotification,
	#instVars : [
		'stepProperties'
	],
	#category : #'PureNG-Notifications'
}

{ #category : #'as yet unclassified' }
PNGStepNotification >> initWithDecoder: aDecoder [
	self stepProperties: (self service decodeStepPropertiesFromDecoder:  aDecoder) 
]

{ #category : #'as yet unclassified' }
PNGStepNotification >> stepProperties [ 
	^ stepProperties 
]

{ #category : #'as yet unclassified' }
PNGStepNotification >> stepProperties: aStepPropertiesObject [
	stepProperties := aStepPropertiesObject.
]
