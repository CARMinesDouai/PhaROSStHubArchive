Class {
	#name : #ATActor,
	#superclass : #Object,
	#instVars : [
		'actor',
		'actorWorker'
	],
	#category : #'ActIT-Kernel'
}

{ #category : #'instance creation' }
ATActor class >> for: anActorClass [
	
	^ self new
		innerActor: anActorClass new;
		spawn;
		yourself.
]

{ #category : #'message sending' }
ATActor >> doesNotUnderstand: aMessage [

	(actor respondsTo: aMessage selector) ifFalse: [ super doesNotUnderstand: aMessage ].
	
	self sendMessage: aMessage
]

{ #category : #accessing }
ATActor >> innerActor: anActor [
	
	actor := anActor
]

{ #category : #accessing }
ATActor >> messages [
	
	^ actorWorker pendingTasks asOrderedCollection
]

{ #category : #running }
ATActor >> resume [
	
	actorWorker resume
]

{ #category : #'message sending' }
ATActor >> send: aSelector with: anArgument [

	self send: aSelector withArguments: { anArgument }
]

{ #category : #'message sending' }
ATActor >> send: aSelector withArguments: arguments [

	self sendMessage: (Message selector: aSelector arguments: arguments)
]

{ #category : #'message sending' }
ATActor >> sendMessage: aMessage [

	actorWorker run: (ATMessage new message: aMessage; receiver: actor; yourself)
]

{ #category : #running }
ATActor >> spawn [

	actorWorker := TKTWorker spawn.
	actorWorker process setProcessSpecificVariableValue: ATCurrentActor with: self.

]

{ #category : #running }
ATActor >> stop [

	actorWorker stop
]

{ #category : #running }
ATActor >> suspend [
	
	actorWorker suspend
]
