Class {
	#name : #AnnouncementSetTest,
	#superclass : #TestCase,
	#category : #'Announcements-Tests-Core'
}

{ #category : #testing }
AnnouncementSetTest >> testIncludeOnlyOnce [
	|set|
	set := AnnouncementMockA, AnnouncementMockB, AnnouncementMockA.
	self assert: set size = 2
]

{ #category : #testing }
AnnouncementSetTest >> testInstanceCreation [
	|set|
	set := AnnouncementMockA, AnnouncementMockB.
	self assert: set size = 2 
]
