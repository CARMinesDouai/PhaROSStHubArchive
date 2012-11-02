"
A TAnnouncer is 
Just a delagate to get the tipical behavior that should show an object which let you know announcements . (Instead of getting it behavior from an inheritance)

"
Trait {
	#name : #TAnnouncer,
	#category : #'Announcements-Support'
}

{ #category : #announcement }
TAnnouncer >> announce: anAnnouncement [ 
	self resolveAnnouncer announce:anAnnouncement.
]

{ #category : #announcement }
TAnnouncer >> announcer [
	self required.
]

{ #category : #announcement }
TAnnouncer >> announcer: anAnnouncer [
	self required.
]

{ #category : #announcement }
TAnnouncer >> removeSubscription: subscription [
	^self resolveAnnouncer removeSubscription: subscription.
]

{ #category : #announcement }
TAnnouncer >> resolveAnnouncer [
	| announcer | 
	self announcer ifNil: [
		self announcer: Announcer new.	
	].
	^ self announcer.
]

{ #category : #announcement }
TAnnouncer >> subscribe: aAnnouncement do: aBlock [
	^self resolveAnnouncer subscribe: aAnnouncement do: aBlock
]

{ #category : #announcement }
TAnnouncer >> subscribe: anAnnouncementClass send: aSelector to: anObject [
	^self resolveAnnouncer subscribe: anAnnouncementClass send: aSelector to: anObject.
]

{ #category : #announcement }
TAnnouncer >> unsubscribe: anObject [
	^self resolveAnnouncer unsubscribe: anObject.
]
