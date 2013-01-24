Class {
	#name : #NotificationConsumer,
	#superclass : #Object,
	#instVars : [
		'process'
	],
	#category : #'Pure-Services'
}

{ #category : #'as yet unclassified' }
NotificationConsumer class >> connector: aConnector  talkingWith: aNotificationService [
	 ^ self new.
]

{ #category : #'as yet unclassified' }
NotificationConsumer >> addNotifications: aSetNotifications [
	
	process addWork: [
		| toProcess | 	
		toProcess := OrderedCollection new. 
		toProcess add: aSetNotifications first.
		
		aSetNotifications do: [ : n | 
			(toProcess last closeTo: n ) ifFalse: [
				toProcess add: n.
			]
		].
		toProcess do: #notificate.
	].
]

{ #category : #'as yet unclassified' }
NotificationConsumer >> initialize [ 
	super initialize.
	process := PureWorker pickOne.
	
]

{ #category : #service }
NotificationConsumer >> stop [
	process stop.
]
