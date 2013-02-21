Class {
	#name : #PurePhaROSNotificationBroadcaster,
	#superclass : #PurePhaROSNode,
	#category : #PureROS
}

{ #category : #'as yet unclassified' }
PurePhaROSNotificationBroadcaster >> setUp [
	robot with:NotificationManagerService do: [: n | n addAnInterested: self ].
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationBroadcaster >> value: aSetOfNotifications [
	self sendTo: '/pure_stream' typedAs:'pharos/Stream'  a: [ :msg |
		msg data: (
			aSetOfNotifications inject: OrderedCollection new into: [ : acc : each | acc , each asBinary ] 
		).
	] 
]
