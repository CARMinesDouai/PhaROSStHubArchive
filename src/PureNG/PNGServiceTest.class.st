Class {
	#name : #PNGServiceTest,
	#superclass : #PNGTestCase,
	#category : #'PureNG-Services-Test'
}

{ #category : #testing }
PNGServiceTest >> notificationOrNilFrom: notifyingService [
	| semaphore notification |
	semaphore := Semaphore new.
	notifyingService onNotificationDo: [ :notif | 
			notification := notif.
			semaphore signal ].
	self deny: (semaphore waitTimeoutMSecs: 500).
	^ notification
]
