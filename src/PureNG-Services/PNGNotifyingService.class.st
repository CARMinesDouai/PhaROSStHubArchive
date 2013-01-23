Class {
	#name : #PNGNotifyingService,
	#superclass : #PNGService,
	#instVars : [
		'notificationPeriod'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #notifications }
PNGNotifyingService >> disableNotifications [
	self notificationService delete: self
]

{ #category : #notifications }
PNGNotifyingService >> enableNotificationsEvery: cycles [ 
	self notificationPeriod: cycles.
	self notificationService insert: self
]

{ #category : #accessing }
PNGNotifyingService >> notificationPeriod [
	^ notificationPeriod ifNil: [ notificationPeriod := 5]
]

{ #category : #accessing }
PNGNotifyingService >> notificationPeriod: anObject [
	notificationPeriod := anObject
]

{ #category : #notifications }
PNGNotifyingService >> notificationService [
	^self robot notificationService 
]
