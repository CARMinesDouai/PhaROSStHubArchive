Class {
	#name : #TestOdometry,
	#superclass : #TestService,
	#category : #'Pure-Test-HardwareInTheLoop'
}

{ #category : #'as yet unclassified' }
TestOdometry >> testGetValuesAsynchronously [
	
	| aNotification |
		
	aNotification := self notificationForService: LocalizationService forNotification: LocalizationNotification.
	
	self assert: aNotification notNil.
	self assert: aNotification xPos isFloat.
	self assert: aNotification yPos isFloat.
	self assert: aNotification orientation isFloat.

]
