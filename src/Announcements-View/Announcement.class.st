"
This class is the superclass for events that someone might want to announce, such as a button click or an attribute change. Typically you create subclasses for your own events you want to announce.

 

"
Class {
	#name : #Announcement,
	#superclass : #Object,
	#category : #'Announcements-Core'
}

{ #category : #public }
Announcement class >> , anAnnouncementClass [
	^ AnnouncementSet with: self with: anAnnouncementClass
]

{ #category : #converting }
Announcement class >> asAnnouncement [
	^ self new
]

{ #category : #testing }
Announcement class >> handles: anAnnouncementClass [
	^ anAnnouncementClass == self or: [ anAnnouncementClass inheritsFrom: self ]
]

{ #category : #converting }
Announcement >> asAnnouncement [
	^ self
]

{ #category : #'*Announcements-View' }
Announcement >> open [
	self inspect
]

{ #category : #'*Announcements-View' }
Announcement >> open [
	self inspect
]
