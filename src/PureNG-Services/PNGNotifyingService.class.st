Class {
	#name : #PNGNotifyingService,
	#superclass : #PNGService,
	#instVars : [
		'notificationPeriod'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #accessing }
PNGNotifyingService >> notificationPeriod [
	^ notificationPeriod
]

{ #category : #accessing }
PNGNotifyingService >> notificationPeriod: anObject [
	notificationPeriod := anObject
]
