Class {
	#name : #ServiceNotification,
	#superclass : #Announcement,
	#instVars : [
		'service',
		'time',
		'pureNotification'
	],
	#category : #'Pure-Notifications'
}

{ #category : #'as yet unclassified' }
ServiceNotification class >> for: aTarget with: aPureNotification [

	^ aTarget relatedNotificationClass new 
										service: aTarget ; 
										notification: aPureNotification; 
										load: aPureNotification ; 
										yourself.
]

{ #category : #'as yet unclassified' }
ServiceNotification >> closeTo: anOtherNotification [
	^ self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
ServiceNotification >> loadTime: aDecoder [
	self flag: #ThisShouldBeTakedFromTheStream.
	 aDecoder nextEncodedUint64.
	time := DateAndTime now. 
"	time := (DateAndTime fromDosTime: aDecoder nextEncodedUint64)."
]

{ #category : #'as yet unclassified' }
ServiceNotification >> notification [ 
	^pureNotification 
]

{ #category : #'as yet unclassified' }
ServiceNotification >> notification: aNotification [
	pureNotification  := aNotification.
]

{ #category : #'as yet unclassified' }
ServiceNotification >> service: aService [
	service := aService.
]

{ #category : #'as yet unclassified' }
ServiceNotification >> time [
	^ time.
]
