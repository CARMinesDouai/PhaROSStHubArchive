"
A PhaROSValueHolder is an object that holds a value and a timestamp of the settings. So you can ask for expiration with an ammount of milliseconds or if is valid.
"
Class {
	#name : #PhaROSValueHolder,
	#superclass : #Object,
	#instVars : [
		'value',
		'stamp'
	],
	#category : #'PhaROS-Util-Sensor'
}

{ #category : #'as yet unclassified' }
PhaROSValueHolder >> isExpiredFor: aToleranceInMilliseconds [ 
	^ (DateAndTime now - stamp ) asMilliSeconds > aToleranceInMilliseconds
]

{ #category : #'as yet unclassified' }
PhaROSValueHolder >> isValidFor: aToleranceInMilliseconds [ 
	^ stamp notNil and: [ (self isExpiredFor: aToleranceInMilliseconds ) not ]
]

{ #category : #'as yet unclassified' }
PhaROSValueHolder >> releaseValue [
	value := nil.
	stamp := nil.
]

{ #category : #'as yet unclassified' }
PhaROSValueHolder >> set: aValue with: aStamp [ 
	value := aValue.
	stamp := aStamp.
]

{ #category : #'as yet unclassified' }
PhaROSValueHolder >> value [
	^ value
]
