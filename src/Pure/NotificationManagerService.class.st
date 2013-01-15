Class {
	#name : #NotificationManagerService,
	#superclass : #RobulabService,
	#instVars : [
		'notificationService',
		'services'
	],
	#category : #'Pure-Services'
}

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
	
	((notificationService isNil or: [ notificationService keepRunning not]) and:[ services isEmpty not]) ifTrue: [
		notificationService := NotificationConsumerProcess connector: robulab connector talkingWith: self.
	].

	(services isEmpty and: [notificationService isNil not ]) ifTrue: [
		self stopNotificationService.
	].




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
				self warn: [aService name, '  was already bound to notifications. '].
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
