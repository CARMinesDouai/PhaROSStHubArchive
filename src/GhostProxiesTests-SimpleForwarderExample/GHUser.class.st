Class {
	#name : #GHUser,
	#superclass : #Object,
	#instVars : [
		'username'
	],
	#category : #'GhostProxiesTests-Mocks'
}

{ #category : #'as yet unclassified' }
GHUser class >> named: aName [
	^ self new username: aName
]

{ #category : #accessing }
GHUser >> username [ ^ username
]

{ #category : #accessing }
GHUser >> username: anObject [
	username := anObject
]
