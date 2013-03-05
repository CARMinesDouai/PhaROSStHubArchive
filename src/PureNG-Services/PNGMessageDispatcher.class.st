Class {
	#name : #PNGMessageDispatcher,
	#superclass : #PNGActiveObject,
	#category : #'PureNG-Kernel'
}

{ #category : #'as yet unclassified' }
PNGMessageDispatcher class >> createProcessForDispatcherIn: weakArray [

	^ ActiveObject do: [ 
		[true] whileTrue: [
			|dispatcher|
			dispatcher := weakArray first.
			dispatcher deliverNextMessage.		
		]
	]

]

{ #category : #accessing }
PNGMessageDispatcher >> bridgeQueue [
	^ self robot bridge responseQueue.
]

{ #category : #activity }
PNGMessageDispatcher >> deliverNextMessage [
	PNGEncodedMessage deliverData: self bridgeQueue next readStream to: self robot

]

{ #category : #activity }
PNGMessageDispatcher >> start [
	super start.	
	
	self
		activeObject:
			(self class createProcessForDispatcherIn: (WeakArray with: self)).
	
	self activeObject
		priority: Processor highIOPriority;
		start
]
