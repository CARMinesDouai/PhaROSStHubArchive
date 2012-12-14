Class {
	#name : #TestService,
	#superclass : #TestCase,
	#instVars : [
		'robulab'
	],
	#category : #'Pure-Test-HardwareInTheLoop'
}

{ #category : #testing }
TestService >> notificationForService: aServiceClass forNotification: aNotificationClass [
	
	| aNotification lockAssert |
	
	lockAssert := Semaphore new.
		
	robulab enableNotificationsForService: aServiceClass.
	
	robulab subscribe: aNotificationClass  do: [ :notif | 
		aNotification  := notif.
		lockAssert signal.
	].
	
	self deny: (lockAssert waitTimeoutSeconds: 2). 

	robulab disableNotificationsForService: aServiceClass.

	^ aNotification
]

{ #category : #running }
TestService >> setUp [
	super setUp.  
	robulab := Robulab newWith: #[192 168 1 2] and: 60000.
]
