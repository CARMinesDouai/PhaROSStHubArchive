Class {
	#name : #AnnouncementSpy,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'announcements',
		'index'
	],
	#category : #'Announcements-View'
}

{ #category : #'instance-creation' }
AnnouncementSpy class >> on: anAnnouncer [
	^ self new
		announcer: anAnnouncer;
		yourself
]

{ #category : #'instance-creation' }
AnnouncementSpy class >> openOn: anAnnouncer [
	"Schedule a new window and open a new AnnouncementSpy on the announcer passed as argument"
	(self on: anAnnouncer) build openInWorld
	
]

{ #category : #private }
AnnouncementSpy >> announce: anAnnouncement [
	self announcements add: anAnnouncement.
	self index: self announcements size.
	self changed: #announcements
]

{ #category : #accessing }
AnnouncementSpy >> announcements [
	^ announcements
]

{ #category : #accessing }
AnnouncementSpy >> announcements: aCollection [
	announcements := aCollection.
	self changed: #announcements
]

{ #category : #accessing }
AnnouncementSpy >> announcer [
	^ announcer
]

{ #category : #accessing }
AnnouncementSpy >> announcer: anAnnouncer [
	announcer ifNotNil: [ announcer unsubscribe: self ].
	announcer := anAnnouncer.
	announcer ifNotNil: [ announcer subscribe: Announcement send: #announce: to: self ]
]

{ #category : #building }
AnnouncementSpy >> build [
	"self new build openInWorld"
	|window list|
	window := (SystemWindow labelled: self label) model: self.
	window addMorph: self buildList frame: (0 @ 0 corner: 1 @ 1).
	^ window
	
]

{ #category : #building }
AnnouncementSpy >> buildList [ 

	^ (PluggableListMorph new)
				on: self 
				list: #announcements
				selected: #index
				changeSelected: #index:
				menu: #buildMenu: 
				keystroke: nil.
	
]

{ #category : #building }
AnnouncementSpy >> buildMenu: aMenuMorph [
	^ aMenuMorph
		defaultTarget: self;
		add: 'open' action: #open;
		add: 'clear' action: #clear;
		yourself
]

{ #category : #private }
AnnouncementSpy >> changed: aSymbol [
	WorldState addDeferredUIMessage: [ super changed: aSymbol ]
]

{ #category : #actions }
AnnouncementSpy >> clear [
	self announcements: OrderedCollection new
]

{ #category : #actions }
AnnouncementSpy >> close [
	self announcer: nil
]

{ #category : #'accessing-dynamic' }
AnnouncementSpy >> extent [
	^ 250 @ 400
]

{ #category : #accessing }
AnnouncementSpy >> index [
	^ index 
]

{ #category : #accessing }
AnnouncementSpy >> index: anInteger [
	index := anInteger.
	self changed: #index
]

{ #category : #'accessing-dynamic' }
AnnouncementSpy >> initialExtent [
	^ 300 @ 400
]

{ #category : #initialization }
AnnouncementSpy >> initialize [
	super initialize.
	self announcements: OrderedCollection new.
	self index: 0
]

{ #category : #'accessing-dynamic' }
AnnouncementSpy >> label [
	^ 'Spy: ', (self announcer ifNil: ['no announcer'] ifNotNil: [ self announcer printString ])
	
]

{ #category : #actions }
AnnouncementSpy >> open [
	(self announcements at: self index ifAbsent: [ ^ self ]) 
		open
]
