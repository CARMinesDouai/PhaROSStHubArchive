Class {
	#name : #PNGNotification,
	#superclass : #PNGEncodedMessage,
	#category : #'PureNG-Kernel'
}

{ #category : #'as yet unclassified' }
PNGNotification class >> newWithDecoder: rawData forRobot: aRobulab [
	^self flag: #todo
]

{ #category : #'as yet unclassified' }
PNGNotification >> isNotification [
	^true
]
