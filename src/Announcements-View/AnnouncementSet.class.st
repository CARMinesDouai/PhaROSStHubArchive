Class {
	#name : #AnnouncementSet,
	#superclass : #Set,
	#category : #'Announcements-Core'
}

{ #category : #adding }
AnnouncementSet >> , anAnnouncementClass [
	self add: anAnnouncementClass
]

{ #category : #testing }
AnnouncementSet >> handles: anAnnouncementClass [
	^ self anySatisfy: [ :each | each handles: anAnnouncementClass ]
]
