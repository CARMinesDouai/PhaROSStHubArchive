Class {
	#name : #TestTelemeter,
	#superclass : #TestService,
	#category : #'Pure-Test-HardwareInTheLoop'
}

{ #category : #'as yet unclassified' }
TestTelemeter >> testGetValuesAsynchronously [
	
	| aNotification |
		
	aNotification := self notificationForService: TelemeterService forNotification: TelemeterNotification.
	self assert: aNotification notNil.
	self assert: aNotification distances notEmpty.
	aNotification distances inspect

]
