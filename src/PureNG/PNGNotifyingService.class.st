Class {
	#name : #PNGNotifyingService,
	#superclass : #PNGService,
	#instVars : [
		'notificationPeriod',
		'notificationHandlingBlock'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #constants }
PNGNotifyingService class >> notificationClass [
	^PNGUnknownNotification
]

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
PNGNotifyingService >> notificationClass [ 
	^self class notificationClass 
]

{ #category : #accessing }
PNGNotifyingService >> notificationHandlingBlock [
	^ notificationHandlingBlock
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

{ #category : #notifications }
PNGNotifyingService >> onNotificationDo: aBlock [
	notificationHandlingBlock := aBlock
]

{ #category : #notifications }
PNGNotifyingService >> receiveNotification: notification [
	self notificationHandlingBlock ifNil: [^self].
	self notificationHandlingBlock cull: notification
]
