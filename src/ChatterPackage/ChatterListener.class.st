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
	channel for: [ : msg :chn | self listen: msg from: chn owner ].
]

{ #category : #'as yet unclassified' }
ChatterListener >> listen: aMsg from: aNode [
	output ifNotNil: [ 
		output nextPutAll: aNode name, ' said:'.
		output nextPutAll: aMsg data.
		output nextPutAll: String lf.
	]
]

{ #category : #'as yet unclassified' }
ChatterListener >> output: aWriteStream [
	output := aWriteStream 
]
