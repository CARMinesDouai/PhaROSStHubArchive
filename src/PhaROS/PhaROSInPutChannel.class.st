Class {
	#name : #PhaROSInPutChannel,
	#superclass : #PhaROSChannel,
	#instVars : [
		'publisherFetcher',
		'publishers',
		'processResult'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #'as yet unclassified' }
PhaROSInPutChannel class >> for: aNode into: aTopic to: anXMLRPCUrl [

	^ self new owner: aNode; topic: aTopic; to: anXMLRPCUrl; startUp; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSInPutChannel >> fetchPublishersFrom: aBlock [
	publisherFetcher := aBlock 
]

{ #category : #service }
PhaROSInPutChannel >> finalize [

	processResult finalize. 
	processResult := nil.
	publishers ifNotNil: [
		publishers do: #finalize.
		publishers removeAll.
	].
	publisherFetcher := nil.
	owner := nil.
]

{ #category : #'as yet unclassified' }
PhaROSInPutChannel >> initialize [ 
	super initialize.
	publishers := Set new.

]

{ #category : #'as yet unclassified' }
PhaROSInPutChannel >> initialize: aBlockPublisher [
	self fetchPublishersFrom: aBlockPublisher.
	processResult := self paralellize looping spinOnce asStickyReference.
	 
]

{ #category : #'as yet unclassified' }
PhaROSInPutChannel >> isInput [ 
	^ true.
]

{ #category : #accessing }
PhaROSInPutChannel >> printOn: aStream [
	aStream nextPutAll: 'InputChannel>> ',topic name. 
]

{ #category : #'as yet unclassified' }
PhaROSInPutChannel >> publishers [ 
	^ publishers
]

{ #category : #'as yet unclassified' }
PhaROSInPutChannel >> send: aMessageBlock [ 
	self send: aMessageBlock  to: owner.
]

{ #category : #'as yet unclassified' }
PhaROSInPutChannel >> spinOnce [
[[
	
	publisherFetcher value.
	
	2 second asDelay wait.
	
] on: ConnectionTimedOut do: [ :e | 
	
].]  on: Error do: [
	: e | self log: e messageText.
	e signal.
]
]

{ #category : #'as yet unclassified' }
PhaROSInPutChannel >> subscribe: aPublisherNode [
	publishers add: aPublisherNode 
]

{ #category : #'as yet unclassified' }
PhaROSInPutChannel >> unsubscribe: aPublisher [
	publishers remove: aPublisher ifAbsent: [].
]
