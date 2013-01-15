"
This service handles configuration of outbound notifications for all services. 
An outbound notification configuration consists of two elements: 
-The service instance which should send the notification. 
-The notification mode; either periodic or event based.
"
Class {
	#name : #PNGNotificationService,
	#superclass : #PNGService,
	#category : #'PureNG-Services'
}

{ #category : #constants }
PNGNotificationService class >> serviceType [ 
	^ 16r0001
]
