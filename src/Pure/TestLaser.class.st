Class {
	#name : #TestLaser,
	#superclass : #TestService,
	#category : #'Pure-Test-HardwareInTheLoop'
}

{ #category : #tests }
TestLaser >> testGetValuesAsynchronously [
	
	| aNotification |
		
	aNotification := self notificationForService: LaserService forNotification: LaserNotification.
	
	self assert: aNotification notNil.
	self assert: aNotification echoes notEmpty.


]
