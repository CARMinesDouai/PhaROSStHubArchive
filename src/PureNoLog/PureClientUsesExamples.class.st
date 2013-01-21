Class {
	#name : #PureClientUsesExamples,
	#superclass : #Object,
	#category : #'PureNoLog-Examples'
}

{ #category : #'as yet unclassified' }
PureClientUsesExamples >> workspaceBrowsingServices [
| pdr |

pdr := nil .
Smalltalk garbageCollect .
self assert: LaserService allInstances size = 0.
self assert: Robulab  allInstances size = 0.


pdr := Robulab newWith: #[192 168 1 2] and: 60000.


"NotificationManager".
pdr with: NotificationManagerService do: [
	: service |
	service load.
	
	pdr with: LocalizationService  do: [
		:laser |
		service beginNotificating: laser each: 2.
		
	].
].


"IO Service"
pdr with: IOService do: [
	: service |
	service load .
].


"Differential Drive"
pdr with: DifferentialDriveService do: [
	: service |
	service load .
	service setTargetLinearSpeed: 0.0 andTargetAngularSpeed: 0.4.	
].



"Service Laser"
pdr with: LaserService do: [
	: service |
	service load .
	service printEchos .
].



]

{ #category : #'as yet unclassified' }
PureClientUsesExamples >> workspaceKillingProcess [

	Process allInstances "allSubInstances" select: [:aProcess | aProcess priority = 30] thenDo: [:p| p terminate ]
]

{ #category : #'as yet unclassified' }
PureClientUsesExamples >> workspaceUsingNotifications [
	| robot |
	
	robot := nil.
	Smalltalk garbageCollect .
	
	
	robot := Robulab newWith: #[192 168 1 2] and: 60000.
	
	robot subscribe: LaserNotification  do: [ :not | Transcript show: 'Laser!'; cr. ].
	robot subscribe: LocalizationNotification   do: [ :not | Transcript show: 'Local!'; cr. ].
	
	
	
	robot with: NotificationManagerService  do: [
		: notifications | 
		
		robot with: LaserService do: [
			: laser | 
			notifications service beginNotificating: laser each: 1.
		].
	
		robot with: LocalizationService do: [
			: local | 
			notifications service beginNotificating: local each: 0.
		].
	
	].
	
]

{ #category : #'as yet unclassified' }
PureClientUsesExamples >> workspaceUsingNotifications2 [
	| robot |
	
	robot := nil.
	Smalltalk garbageCollect .
	
	
	robot := Robulab newWith: #[192 168 1 2] and: 60000.

	robot with: LaserService do: [
		: laser |
		laser enableNotifications.
		laser whenANotificationArrivesDo: [
			: notification |
			Transcript show: notification maxAngle asString.
			Transcript show: notification minAngle asString. 
			Transcript show: notification echoes asString .	
			laser disableNotifications.
		].
	].
		
]
