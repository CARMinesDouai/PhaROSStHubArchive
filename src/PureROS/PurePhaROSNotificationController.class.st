"
This controller makes a dispatching of notifications for several callbacks. It also signal when al the callbacks are executed for a notification. 
"
Class {
	#name : #PurePhaROSNotificationController,
	#superclass : #PNGController,
	#instVars : [
		'movementCallbacks',
		'laserCallbacks',
		'allMovementCallbacksCalled',
		'allLaserCallbacksCalled',
		'lastMovementNotification'
	],
	#category : #'PureROS-Controllers'
}

{ #category : #'as yet unclassified' }
PurePhaROSNotificationController >> activateLaserNotifications [
	robot laserService onNotificationDo: [ : notification |  self onLaserNotification: notification. 	].
	[robot laserService enableNotificationsEvery: 0.] on: PNGMessageError do: [ ].
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationController >> activateMovementNotifications [
	robot localizationService onNotificationDo: [ : notification |  self onMovementNotification: notification. 	].
	[robot localizationService enableNotificationsEvery: 0.] on: PNGMessageError do: [ ].
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationController >> desactivateLaserNotifications [
	robot laserService disableNotifications.
	
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationController >> desactivateMovementNotifications [
	robot localizationService disableNotifications.
	
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationController >> initialize [ 
	movementCallbacks := Set new.
	laserCallbacks := Set new.
			
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationController >> laserCallbacks [ 
	^ laserCallbacks
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationController >> lastMovementNotification [ 
	^ lastMovementNotification.
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationController >> movementCallbacks [  
	^ movementCallbacks
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationController >> notificateLaserTo: aCallback [
	self laserCallbacks add: aCallback.
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationController >> notificateMovementTo: aCallback [
	self movementCallbacks add: aCallback.
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationController >> onLaserNotification: aLaserNotification [
	self laserCallbacks do: [ : cb | cb value: aLaserNotification ].
	allLaserCallbacksCalled ifNotNil: [ allLaserCallbacksCalled cull: aLaserNotification].
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationController >> onMovementNotification: aMovementNotification [
	self movementCallbacks  do: [ : cb | cb value: aMovementNotification ].
	allMovementCallbacksCalled ifNotNil:[ allMovementCallbacksCalled cull: aMovementNotification.].
	lastMovementNotification := aMovementNotification.
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationController >> whenAllLaserCallbacksHasBeenCalled: aBlock [
	allLaserCallbacksCalled := aBlock.
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationController >> whenAllMovementCallbacksHasBeenCalled: aBlock [
	allMovementCallbacksCalled := aBlock.
]
