Class {
	#name : #TestLaser,
	#superclass : #TestRobulab,
	#category : #'Pure-Test-HardwareInTheLoop'
}

{ #category : #'as yet unclassified' }
TestLaser >> testGetValuesAsynchronously [
	
	| aNotification lockAssert |
	
	lockAssert := Semaphore new.
		
	robulab enableNotificationsForService: LaserService.
	
	robulab subscribe: LaserNotification  do: [ :notif | 
		aNotification  := notif.
		lockAssert signal.
	].
	
	self deny: (lockAssert waitTimeoutSeconds: 1). 

	robulab disableNotificationsForService: LaserService.

	self assert: aNotification notNil.
	self assert: aNotification echoes notEmpty.


]
