Class {
	#name : #TraitedAnnouncer,
	#superclass : #Object,
	#traits : 'TAnnouncer',
	#classTraits : 'TAnnouncer classTrait',
	#instVars : [
		'delegate'
	],
	#category : #'Announcements-Support-Test'
}

{ #category : #announcement }
TraitedAnnouncer >> announcer [
	^ delegate
]

{ #category : #announcement }
TraitedAnnouncer >> announcer: anAnnouncer [
	delegate := anAnnouncer.
]
