"
Test notification dispatching and that we are using the proper PNG messages
"
Class {
	#name : #PurePhaROSNotificationControllerTest,
	#superclass : #TestCase,
	#category : #'PureROS-Controllers-Tests'
}

{ #category : #'as yet unclassified' }
PurePhaROSNotificationControllerTest >> testActivateLaserNotificationSendMessages [
	| messageTracker controller messages |
	messageTracker := PureROSMessageRegisterForTests new.
	controller := PurePhaROSNotificationController for: messageTracker.
	 
	controller activateLaserNotifications.
	messages := messageTracker messages collect:#selector.
	
	self deny: (messages includes: #localizationService).
	self assert: (messages includes: #laserService).
	self assert: (messages includes: #enableNotificationsEvery:).
	self assert:( messages includes: #onNotificationDo:).
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationControllerTest >> testActivateMovementNotificationSendMessages [
	| messageTracker controller messages |
	messageTracker := PureROSMessageRegisterForTests new.
	controller := PurePhaROSNotificationController for: messageTracker.
	 
	controller activateMovementNotifications.
	messages := messageTracker messages collect:#selector.
	
	self assert: (messages includes: #localizationService).
	self deny: (messages includes: #laserService).
	self assert: (messages includes: #enableNotificationsEvery:).
	self assert:( messages includes: #onNotificationDo:).
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationControllerTest >> testAllCallbacksReceiveLaserNotification [
	|  assertDict  controller c1 c2 c3 notification |
	
	assertDict:= Dictionary new. 
	
	c1 := [ :n | assertDict at: c1 put: n ].
	c2 := [ :n | assertDict at: c2 put: n ].
	c3 := [ :n | assertDict at: c3 put: n ].
	
 
	controller := PurePhaROSNotificationController new.
	
	controller notificateLaserTo: c1; notificateLaserTo: c2; notificateLaserTo: c3.
	
	notification := 'JustAString'.
	

	controller onLaserNotification: notification.
	
	self assert: (assertDict at: c1) = notification.
	self assert: (assertDict at: c2) = notification.
	self assert: (assertDict at: c3) = notification.
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationControllerTest >> testAllCallbacksReceiveMovementNotification [
	|  assertDict  controller c1 c2 c3 notification |
	
	assertDict:= Dictionary new. 
	
	c1 := [ :n | assertDict at: c1 put: n ].
	c2 := [ :n | assertDict at: c2 put: n ].
	c3 := [ :n | assertDict at: c3 put: n ].
	
 
	controller := PurePhaROSNotificationController new.
	
	controller notificateMovementTo: c1; notificateMovementTo: c2; notificateMovementTo: c3.
	
	notification := 'JustAString'.
	

	controller onMovementNotification: notification.
	
	self assert: (assertDict at: c1) = notification.
	self assert: (assertDict at: c2) = notification.
	self assert: (assertDict at: c3) = notification.
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationControllerTest >> testDeactivateLaserNotificationSendMessages [
	| messageTracker controller messages |
	messageTracker := PureROSMessageRegisterForTests new.
	controller := PurePhaROSNotificationController for: messageTracker.
	 
	controller desactivateLaserNotifications.
	messages := messageTracker messages collect:#selector.
	
	self deny: (messages includes: #localizationService).
	self assert: (messages includes: #laserService).
	self assert: (messages includes: #disableNotifications).

]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationControllerTest >> testDeactivateMovementNotificationSendMessages [
	| messageTracker controller messages |
	messageTracker := PureROSMessageRegisterForTests new.
	controller := PurePhaROSNotificationController for: messageTracker.
	 
	controller desactivateMovementNotifications.
	messages := messageTracker messages collect:#selector.
	
	self assert: (messages includes: #localizationService).
	self deny: (messages includes: #laserService).
	self assert: (messages includes: #disableNotifications).

]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationControllerTest >> testLaserCallbacksNotReceiveMovementNotification [
	|  assertDict  controller c1 c2 c3 notification |
	
	assertDict:= Dictionary new. 
	
	c1 := [ :n | assertDict at: c1 put: n ].
	c2 := [ :n | assertDict at: c2 put: n ].
	c3 := [ :n | assertDict at: c3 put: n ].
	
 
	controller := PurePhaROSNotificationController new.
	
	controller notificateLaserTo: c1; notificateLaserTo: c2; notificateLaserTo: c3.
	
	notification := 'JustAString'.
	

	controller onMovementNotification: notification.
	

	self assert: assertDict size = 0
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationControllerTest >> testMovementCallbacksNotReceiveLaserNotification [
	|  assertDict  controller c1 c2 c3 notification |
	
	assertDict:= Dictionary new. 
	
	c1 := [ :n | assertDict at: c1 put: n ].
	c2 := [ :n | assertDict at: c2 put: n ].
	c3 := [ :n | assertDict at: c3 put: n ].
	
 
	controller := PurePhaROSNotificationController new.
	
	controller notificateMovementTo: c1; notificateMovementTo: c2; notificateMovementTo: c3.
	
	notification := 'JustAString'.
	

	controller onLaserNotification:  notification.
	
	
	self assert: assertDict size = 0.
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationControllerTest >> testRegisterLaserCallback [
	| callback |
	
	callback := [].
	self assert: (((PurePhaROSNotificationController new) notificateLaserTo: callback) laserCallbacks includes: callback). 	
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationControllerTest >> testRegisterMovementCallback [
	| callback |
	
	callback := [].
	self assert: (((PurePhaROSNotificationController new) notificateMovementTo: callback) movementCallbacks includes: callback). 	
]
