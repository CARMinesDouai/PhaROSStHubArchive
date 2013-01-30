Class {
	#name : #PNGLocalizationServiceTest,
	#superclass : #PNGServiceTest,
	#category : #'PureNG-Kernel-Test'
}

{ #category : #testing }
PNGLocalizationServiceTest >> testNotificationReception [
	self signalFailure: 'Todo'.
	robot localizationService enableNotificationsEvery: 5.

]
