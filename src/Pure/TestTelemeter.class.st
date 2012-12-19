Class {
	#name : #TestTelemeter,
	#superclass : #TestService,
	#category : #'Pure-Test-HardwareInTheLoop'
}

{ #category : #'as yet unclassified' }
TestTelemeter >> testGetValuesAsynchronously [
	
	| aNotification |
		
	aNotification := self notificationForService: TelemeterService forNotification: TelemeterNotification.
	self flag: #TODO.
	self assert: aNotification notNil.
	aNotification inspect.

]
