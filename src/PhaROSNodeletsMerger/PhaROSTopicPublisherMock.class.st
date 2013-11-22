Class {
	#name : #PhaROSTopicPublisherMock,
	#superclass : #PhaROSTopicMock,
	#instVars : [
		'sendReceived'
	],
	#category : #'PhaROSNodeletsMerger-Test'
}

{ #category : #'as yet unclassified' }
PhaROSTopicPublisherMock >> receivedSend [
	^	sendReceived
]

{ #category : #'as yet unclassified' }
PhaROSTopicPublisherMock >> send: aMessageConfiguration [
	sendReceived := true. 
	aMessageConfiguration cull: self newMessage.
]
