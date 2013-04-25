Class {
	#name : #PNGStepNotification,
	#superclass : #PNGNotification,
	#instVars : [
		'stepProperties'
	],
	#category : #'PureNG-Notifications'
}

{ #category : #'initialize-release' }
PNGStepNotification >> initWithDecoder: aDecoder [
	self stepProperties: (self service decodeStepPropertiesFromDecoder:  aDecoder) 
]

{ #category : #accessing }
PNGStepNotification >> stepProperties [ 
	^ stepProperties 
]

{ #category : #accessing }
PNGStepNotification >> stepProperties: aStepPropertiesObject [
	stepProperties := aStepPropertiesObject.
]
