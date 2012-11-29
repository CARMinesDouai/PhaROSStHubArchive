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
				notifications deleteNotificationRecordFromService:  local .
				local getData.
				semaphore signal. 
			 ].
			notifications addNotificationRecordToInstance: local withPeriod: 1.
		].
	
		
	].
	semaphore wait. 
	
	self assert: (notification xPos closeTo: notification xPos).
	self assert: (notification yPos closeTo: notification yPos).
	self assert: (notification orientation closeTo: notification orientation).
	self assert: (notification status closeTo: notification status).
]
