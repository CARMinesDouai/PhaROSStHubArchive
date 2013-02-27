Class {
	#name : #PurePhaROSNotificationBroadcaster,
	#superclass : #PurePhaROSNode,
	#instVars : [
		'incommingData',
		'broadcaster'
	],
	#category : #PureROS
}

{ #category : #'as yet unclassified' }
PurePhaROSNotificationBroadcaster >> send: aNotificationBinary [
	self sendTo: '/pure_stream' typedAs:'pharos/Stream'  a: [ :msg |
		msg data: aNotificationBinary
	] 
]

{ #category : #'as yet unclassified' }
PurePhaROSNotificationBroadcaster >> setUp [
	incommingData := robot bridge responseQueue for: self.
	broadcaster := ActiveObject do:
	[
		[
			| data |
			data := incommingData next.
			(PNGEncodedMessage isNotification: data ) ifTrue:[
				self send: data.
			]
		] repeat.
	].
]
