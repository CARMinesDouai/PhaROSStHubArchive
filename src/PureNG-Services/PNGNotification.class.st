Class {
	#name : #PNGNotification,
	#superclass : #PNGPureEncodedMessage,
	#category : #'PureNG-Kernel'
}

{ #category : #'as yet unclassified' }
PNGNotification class >> newWithRawData: rawData forRobot: aRobulab [
	^self flag: #todo
]

{ #category : #'as yet unclassified' }
PNGNotification >> isNotification [
	^true
]
