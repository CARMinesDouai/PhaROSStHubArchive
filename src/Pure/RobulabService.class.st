Class {
	#name : #RobulabService,
	#superclass : #Object,
	#instVars : [
		'robulab',
		'type',
		'listening'
	],
	#category : #'Pure-Services'
}

{ #category : #'as yet unclassified' }
RobulabService class >> createFromRobulab: rob Type: type [
	| service |
	
	service := (ConstantesRobulab serviceClassPerType at: type ) new.
	
	service robulab: rob.
	service type: type.
	^service.
]

{ #category : #accessing }
RobulabService >> announcer [
	^ robulab announcerFor: self.
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
RobulabService >> get [ 
	^self robulab sendMessageAndWaitResponse: (PureRequest getFrom: self).
]

{ #category : #request }
RobulabService >> getData [ 
	"imlpementar"
		self flag: #implemeeent
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

{ #category : #'initialize-release' }
RobulabService >> initialize [ 
	self listening: false.
]

{ #category : #request }
RobulabService >> insert: data [
	^self robulab sendMessageAndWaitResponse: (PureRequest insert: data into: self).
]

{ #category : #request }
RobulabService >> interestedAnnouncements [
	^ {  self relatedNotificationClass } 
]

{ #category : #accessing }
RobulabService >> listening [
	^ listening
]

{ #category : #accessing }
RobulabService >> listening: anObject [
	listening := anObject
]

{ #category : #request }
RobulabService >> query: data [
	^self robulab sendMessageAndWaitResponse: (PureRequest query: data to: self).
]

{ #category : #request }
RobulabService >> receiveNotificationFromRobulab: aMessage [
	self subclassResponsibility 
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
