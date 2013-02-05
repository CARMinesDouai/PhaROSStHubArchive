Class {
	#name : #PNGNotification,
	#superclass : #PNGEncodedMessage,
	#instVars : [
		'timestamp'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'as yet unclassified' }
PNGNotification class >> newWithDecoder: aDecoder [ 

	^ self new 
		initializeWithDecoder: aDecoder;
		yourself

]

{ #category : #'as yet unclassified' }
PNGNotification >> initializeWithDecoder: aDecoder [
	self decoder: aDecoder; 
		target: aDecoder nextEncodedUInt16 ;
		timestamp: aDecoder nextEncodedUInt64.
]

{ #category : #'as yet unclassified' }
PNGNotification >> isNotification [
	^true
]

{ #category : #'as yet unclassified' }
PNGNotification >> timestamp [
	^timestamp 
]

{ #category : #'as yet unclassified' }
PNGNotification >> timestamp: aNumberOfCycles [
	timestamp := aNumberOfCycles
]
