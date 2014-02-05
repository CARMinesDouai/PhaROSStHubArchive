Class {
	#name : #ChatterListener,
	#superclass : #Object,
	#instVars : [
		'channel',
		'output'
	],
	#category : #'ChatterPackage-Nodelets'
}

{ #category : #'as yet unclassified' }
ChatterListener class >> for: aSubscription [
	^ self new channel: aSubscription; yourself.
]

{ #category : #'as yet unclassified' }
ChatterListener >> channel: aChannel [
	channel := aChannel.
	channel for: [ : msg | self listen: msg ].
]

{ #category : #'as yet unclassified' }
ChatterListener >> listen: aMsg [
	output ifNotNil: [ 
		output nextPutAll: aMsg data.
			
	]
]

{ #category : #'as yet unclassified' }
ChatterListener >> output: aWriteStream [
	output := aWriteStream 
]
