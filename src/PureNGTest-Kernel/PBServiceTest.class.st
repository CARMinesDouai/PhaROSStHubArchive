Class {
	#name : #PBServiceTest,
	#superclass : #PBTestCase,
	#category : #'PureNGTest-Services'
}

{ #category : #testing }
PBServiceTest >> notificationOrNilFrom: notifyingService [
	| semaphore notification |
	semaphore := Semaphore new.
	notifyingService onNotificationDo: [ :notif | 
			notification := notif.
			semaphore signal ].
	self deny: (semaphore waitTimeoutMSecs: 500).
	^ notification
]

{ #category : #testing }
PBServiceTest >> waitUntilRobotProcessesPendingRequests. [
	(Delay forMilliseconds: 300) wait
]
