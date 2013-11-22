Class {
	#name : #PhaROSTopicFluxMock,
	#superclass : #PhaROSTopicMock,
	#instVars : [
		'callback'
	],
	#category : #'PhaROSNodeletsMerger-Test'
}

{ #category : #'as yet unclassified' }
PhaROSTopicFluxMock >> for: aCallback [
	callback := aCallback
]

{ #category : #'as yet unclassified' }
PhaROSTopicFluxMock >> mockMessage [ 
	^ callback cull: self newMessage cull: self cull: DateAndTime now.
]
