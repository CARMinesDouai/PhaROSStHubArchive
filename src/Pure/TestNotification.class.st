Class {
	#name : #TestNotification,
	#superclass : #TestCase,
	#instVars : [
		'robulab',
		'robot'
	],
	#category : #'Pure-Test-RobotDependent'
}

{ #category : #'as yet unclassified' }
TestNotification >> setUp [


	
	
	
	robot := Robulab newWith: #[192 168 1 2] and: 60000.

]

{ #category : #'as yet unclassified' }
TestNotification >> tearDown [ 
	robot := nil.
	Smalltalk garbageCollect .
]

{ #category : #'as yet unclassified' }
TestNotification >> testLocalization [
	| semaphore notification localization |
	
	
	
	semaphore := Semaphore new.
	
	robot with: NotificationManagerService  do: [
		: notifications | 
		robot with: LocalizationService do: [
			: local | 
			localization := local. 		
			robot subscribe: LocalizationNotification   do: [ 
				:not |	
				notification := not.
				notifications stopNotificating:  local .
				local load.
				semaphore signal. 
			 ].
			notifications beginNotificating: local each: 1.
		].
	
		
	].
	semaphore wait. 
	
	self assert: (notification pose closeTo: notification pose).
	self assert: (notification status closeTo: notification status).
	

]
