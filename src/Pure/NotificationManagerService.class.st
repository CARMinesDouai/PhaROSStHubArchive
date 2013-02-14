Class {
	#name : #NotificationManagerService,
	#superclass : #RobulabService,
	#instVars : [
		'notificationService',
		'services',
		'interestedInRawNotifications'
	],
	#category : #'Pure-Services'
}

{ #category : #request }
NotificationManagerService >> addAnInterested: anInterested [
	interestedInRawNotifications add: anInterested.
]

{ #category : #notifications }
NotificationManagerService >> alreadyReceivinNotificationsFrom: aService [ 
	^ services includes: aService.
	
]

{ #category : #notifications }
NotificationManagerService >> beginNotificating: aService each: nControlCycles [ 

	(self alreadyReceivinNotificationsFrom: aService ) ifTrue: [
		^ self.	
	].
	
	(nControlCycles between:  0 and: 255) ifFalse:[
		Error signal: ' The given period must be between 0 and 255 '.
	].

"	self debug: ['Asking for notifications to  ', aService class name, ' instance:', aService getInstanceNumber asString ,  ' every ',nControlCycles asString ,'  control cycles ']."

	services add: aService.
	
	self monitorConsumer. 
	
	self register: aService each: nControlCycles. 
	


	
	
]

{ #category : #request }
NotificationManagerService >> delete: data using: aConnector [
	^ (aConnector sendMessage: (PureRequest delete: data from: self)) result .
]

{ #category : #service }
NotificationManagerService >> destroy [
	self stopNotificatingAllServices.
	super destroy.	
		

]

{ #category : #notifications }
NotificationManagerService >> enableOneNotificationEvery: anAmmount [
	self error: 'there are no notifications of notifications '.
]

{ #category : #'initialize-release' }
NotificationManagerService >> fetchNotificationsWith: aConnector [	

	self getWith: aConnector.

	
	
	
	
]

{ #category : #request }
NotificationManagerService >> initialize [ 
	super initialize.
	services := Set new.
	interestedInRawNotifications := Set new.
]

{ #category : #request }
NotificationManagerService >> insert: data into: aConnector [
	^ (aConnector sendMessage: (PureRequest insert: data into: self)) result .
]

{ #category : #request }
NotificationManagerService >> interestedAnnouncements [
	^ {   } 
]

{ #category : #'initialize-release' }
NotificationManagerService >> load: aConnector [
	| decoder |
	

	decoder := (self getWith: aConnector) decoder.

	
	
	
	
]

{ #category : #process }
NotificationManagerService >> monitorConsumer [

	" kill or start notification process if is needed. If kill notification process also kills connector"
	
	(notificationService isNil and:[ services isEmpty not]) ifTrue: [
		notificationService := NotificationConsumer connector: robulab connector talkingWith: self.
		robulab connector notificating: true.
	].

	(services isEmpty and: [notificationService isNil not ]) ifTrue: [
		robulab connector notificating: false.
		self stopNotificationService.
	].




]

{ #category : #process }
NotificationManagerService >> notificate: aSetNotification [
	notificationService ifNotNil: [
		notificationService addNotifications: aSetNotification 	
	].

	interestedInRawNotifications do: [ :i | i value: aSetNotification ].
]

{ #category : #request }
NotificationManagerService >> register: aService each: nControlCycles [
	| response encoder |  	
		
		[
			encoder := PureEncoder forArray: (String new: (1 + 2 + 2 +  2)).
			encoder nextPutString: '0'.
			encoder nextPutString: aService getInstanceNumber asString.
			encoder nextPutString: '00'.
			encoder encodeInt8: nControlCycles.
			
			response := self  insert: encoder contents into: robulab connector.		
		] on: Error do:[
			:e | 
			e messageText = 'Already bound to this notification' ifTrue: [
				Transcript show: [aService name, '  was already bound to notifications. ']; cr.
			] ifFalse: [
				e signal.
			]
			
			
		].
	
		
]

{ #category : #request }
NotificationManagerService >> relatedNotificationClass [
	^ self error: 'This service has not notifications'
]

{ #category : #process }
NotificationManagerService >> restart [

	" stop all related process, and execute monitors. If process are needed will be spawned again "
	self stopNotificationService.
	self monitorConsumer.
]

{ #category : #notifications }
NotificationManagerService >> stopNotificating: aService [
	self  delete: '0', aService getInstanceNumber asString, '00' using: robulab connector.
	services remove: aService ifAbsent: [].
	self monitorConsumer.
]

{ #category : #service }
NotificationManagerService >> stopNotificatingAllServices [
	services do: [ : serv | self stopNotificating: serv ].
	services removeAll.
	self monitorConsumer.
]

{ #category : #process }
NotificationManagerService >> stopNotificationService [
	notificationService stop.
	notificationService := nil.

]
