"
This is a custom help book providing the API documentation for the announcements framework.

"
Class {
	#name : #AnnouncementsAPIDocumentation,
	#superclass : #AnnouncementsHelp,
	#category : #'Announcements-Help'
}

{ #category : #accessing }
AnnouncementsAPIDocumentation class >> bookName [
	^'API Documentation'
]

{ #category : #defaults }
AnnouncementsAPIDocumentation class >> builder [
	^PackageAPIHelpBuilder
]

{ #category : #accessing }
AnnouncementsAPIDocumentation class >> packages [
	^#('Announcements-Core' 'Announcements-View' 'Announcements-Tests-Core')
]
