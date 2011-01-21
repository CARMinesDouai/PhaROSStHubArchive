Class {
	#name : #OCNSocketPluginLibrary,
	#superclass : #Object,
	#classInstVars : [
		'default'
	],
	#category : #'Ocean-Libraries'
}

{ #category : #'as yet unclassified' }
OCNSocketPluginLibrary class >> new [
	self error: 'use proxy instead'
]

{ #category : #'as yet unclassified' }
OCNSocketPluginLibrary class >> proxy [
	^default ifNil: [ default := super new ]
]

{ #category : #accessing }
OCNSocketPluginLibrary >> defaultDataBufferSize [
	^2000
]
