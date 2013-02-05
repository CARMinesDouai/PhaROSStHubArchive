Class {
	#name : #PNGLocalizationServiceTest,
	#superclass : #PNGServiceTest,
	#category : #'PureNG-Kernel-Test'
}

{ #category : #testing }
PNGLocalizationServiceTest >> testNotificationReception [
	| services notification timesRepeat notifyingService |

	"robot localizationService enableNotificationsEvery: 2."
	
	notifyingService := robot localizationService.
	
	[notifyingService enableNotificationsEvery: 2] on: PNGMessageError do: [ :error | ].
	
	self assert: (robot notificationService get includesKey: notifyingService).
	
	notification  := nil.
	timesRepeat := 10.
	[notification isNil and: timesRepeat > 0] whileTrue: [ 
		notification := robot dispatcher notificationQueue nextOrNil.
		(Delay forMilliseconds: 50) wait.
		timesRepeat := timesRepeat - 1 ].
	
	self assert: notification notNil.
	self assert: notification target = notifyingService id
]
