Class {
	#name : #RobulabService,
	#superclass : #Object,
	#traits : 'TLogger',
	#classTraits : 'TLogger classTrait',
	#instVars : [
		'robulab',
		'type'
	],
	#category : #'Pure-Services'
}

{ #category : #'as yet unclassified' }
RobulabService class >> createFromRobulab: rob Type: type [
	| service |
	
	service := (PureConstants serviceClassPerType at: type ) new.
	
	service robulab: rob.
	service type: type.
	^service.
]

{ #category : #accessing }
RobulabService >> announcer [
	robulab ifNotNil: [
		^ robulab announcerFor: self
	].
	^ nil.
]

{ #category : #logging }
RobulabService >> debug: aLog [ 
	self class processor process: (LogEntity for:aLog in: thisContext sender with:#debug).
]

{ #category : #request }
RobulabService >> delete: data [

	
		
	^self robulab sendMessageAndWaitResponse: (PureRequest delete: data from: self).
	
	
	
]

{ #category : #service }
RobulabService >> destroy [
	robulab := nil. 
]

{ #category : #request }
RobulabService >> disableNotifications [

	^robulab with: NotificationManagerService do: [
		: notificationManager |
		notificationManager stopNotificating: self 
	].
]

{ #category : #request }
RobulabService >> enableNotifications [
	self enableOneNotificationEvery: 0.

	
]

{ #category : #request }
RobulabService >> enableOneNotificationEvery: anAmmountOfControlCycles [

	robulab with: NotificationManagerService do: [
		: notificationManager |
		
		notificationManager beginNotificating: self each: anAmmountOfControlCycles.
	].
]

{ #category : #request }
RobulabService >> get [ 
	^self robulab sendMessageAndWaitResponse: (PureRequest getFrom: self).
]

{ #category : #accessing }
RobulabService >> getInstanceNumber [
	| result  |
	self robulab directoryService services keysAndValuesDo: [
		:instance :service | 
		(self =service) ifTrue: [
				result :=instance
			].
		].
	
	^result.
]

{ #category : #request }
RobulabService >> getWith: aConnector [
	^ (aConnector sendMessage: (PureRequest getFrom: self)) result .

]

{ #category : #request }
RobulabService >> insert: data [
	^self robulab sendMessageAndWaitResponse: (PureRequest insert: data into: self).
]

{ #category : #request }
RobulabService >> interestedAnnouncements [
	^ {  self relatedNotificationClass } 
]

{ #category : #request }
RobulabService >> load [ 
	self load: robulab connector.
]

{ #category : #request }
RobulabService >> load: aConnector [
	self subclassResponsibility.

]

{ #category : #request }
RobulabService >> query: data [
	^self robulab sendMessageAndWaitResponse: (PureRequest query: data to: self).
]

{ #category : #request }
RobulabService >> receiveNotificationFromRobulab: aMessage [

]

{ #category : #accessing }
RobulabService >> relatedNotificationClass [
	self subclassResponsibility.
]

{ #category : #request }
RobulabService >> replace: data [

	^self robulab sendMessageAndWaitResponse: (PureRequest replace: data into: self).

]

{ #category : #accessing }
RobulabService >> robulab [
	^ robulab
]

{ #category : #accessing }
RobulabService >> robulab: anObject [
	robulab := anObject.
	self subscribeToAnnouncements
]

{ #category : #request }
RobulabService >> sendNotification: notifDataString [
	self robulab sendNotification: ('0',self getInstanceNumber asString, '00' ,notifDataString).

]

{ #category : #request }
RobulabService >> submit: data [
	^self robulab sendMessageAndWaitResponse: (PureRequest submit: data to: self).
]

{ #category : #accessing }
RobulabService >> subscribeToAnnouncements [

	self interestedAnnouncements do: [
		:ann | 	
		robulab subscribe: ann  do: [
			:notification | 
			self receiveNotificationFromRobulab: notification.	
		]
	]
	


]

{ #category : #accessing }
RobulabService >> type [
	^ type
]

{ #category : #accessing }
RobulabService >> type: anObject [
	type := anObject
]

{ #category : #request }
RobulabService >> upDate: data [
	^self robulab sendMessageAndWaitResponse: (PureRequest update: data into: self).
]

{ #category : #request }
RobulabService >> whenANotificationArrivesDo: aBlock [
	^ robulab subscribe: self relatedNotificationClass do: aBlock.

	
]
