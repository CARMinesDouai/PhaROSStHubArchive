Class {
	#name : #PNGNotification,
	#superclass : #PNGEncodedMessage,
	#instVars : [
		'timestamp',
		'service'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #delivery }
PNGNotification class >> deliverWithDecoder: dataDecoder to: aRobot [ 
	|notification|
	notification := self newWithDecoder: dataDecoder robot: aRobot.
	notification deliver
]

{ #category : #'instance creation' }
PNGNotification class >> newWithDecoder: aDecoder robot: aRobot [
	|serviceId service notificationClass |
	serviceId := aDecoder nextEncodedUInt16.
	service := aRobot serviceWithId: serviceId.
	notificationClass := service notificationClass.
	^notificationClass new
		service: service decoder: aDecoder;
		yourself

]

{ #category : #delivering }
PNGNotification >> deliver [
	self service receiveNotification: self
]

{ #category : #'initialize-release' }
PNGNotification >> initWithDecoder: aDecoder [
	self subclassResponsibility 
]

{ #category : #accessing }
PNGNotification >> service [
	^ service
]

{ #category : #accessing }
PNGNotification >> service: anObject [
	service := anObject
]

{ #category : #'initialize-release' }
PNGNotification >> service:  aService decoder: aDecoder [
	self service: aService.
	self initWithDecoder: aDecoder
]

{ #category : #accessing }
PNGNotification >> timestamp [
	^timestamp 
]

{ #category : #accessing }
PNGNotification >> timestamp: aNumberOfCycles [
	timestamp := aNumberOfCycles
]
