Class {
	#name : #ComposedLikeAnnouncer,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #'Announcements-Support-Test'
}

{ #category : #accessing }
ComposedLikeAnnouncer >> announcer [
	^ announcer 
]

{ #category : #accessing }
ComposedLikeAnnouncer >> announcer: anAnnouncer [
	announcer := anAnnouncer. 
]

{ #category : #'initialize-release' }
ComposedLikeAnnouncer >> initialize [
	super initialize.
	announcer := Announcer new.
]
