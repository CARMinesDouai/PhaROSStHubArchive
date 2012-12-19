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
	self assert: aNotification pose x isFloat.
	self assert: aNotification pose y isFloat.
	self assert: aNotification pose orientation isFloat.

]
