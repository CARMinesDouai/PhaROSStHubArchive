Class {
	#name : #SGMessage,
	#superclass : #Object,
	#instVars : [
		'content'
	],
	#category : #'StarGazer-Types'
}

{ #category : #'as yet unclassified' }
SGMessage class >> for: aContentString [
	^ self new content: aContentString; yourself.
]

{ #category : #'as yet unclassified' }
SGMessage >> content: aContentString [ 
	content := aContentString.
]
