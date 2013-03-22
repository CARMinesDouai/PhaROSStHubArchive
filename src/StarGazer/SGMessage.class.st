Class {
	#name : #SGMessage,
	#superclass : #Object,
	#instVars : [
		'content'
	],
	#classInstVars : [
		'NoMessage'
	],
	#category : #'StarGazer-Types'
}

{ #category : #'as yet unclassified' }
SGMessage class >> NoMessage [
	^ NoMessage
]

{ #category : #'as yet unclassified' }
SGMessage class >> for: aContentString [
	^ aContentString isEmpty ifTrue: [
		self NoMessage.	
	] ifFalse: [
		self new content: aContentString; yourself.
	].
	
]

{ #category : #'as yet unclassified' }
SGMessage class >> initialize [ 
	NoMessage := SGMessage for: nil.
]

{ #category : #'as yet unclassified' }
SGMessage >> content: aContentString [ 
	content := aContentString.
]

{ #category : #'as yet unclassified' }
SGMessage >> type [
	^ content at: 1.
]
