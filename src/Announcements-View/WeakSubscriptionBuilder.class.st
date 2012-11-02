"
I am a wrapper around an Announcer, used to create weak subscriptions at subscription time.

Use me like this:

anAnnouncer weak subscribe: Announcement send: #foo to: barObject.

I raise an error for block subscriptions, as they require non-existing Ephemeron support to function correctly.
"
Class {
	#name : #WeakSubscriptionBuilder,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #'Announcements-Core'
}

{ #category : #'instance creation' }
WeakSubscriptionBuilder class >> on: announcer [
	^ self new announcer: announcer
]

{ #category : #'initialize-release' }
WeakSubscriptionBuilder >> announcer: anAnnouncer [
	announcer := anAnnouncer 
]

{ #category : #'wrapped protocol' }
WeakSubscriptionBuilder >> on: anAnnouncementClass do: aValuable [
	^ self subscribe: anAnnouncementClass do: aValuable
]

{ #category : #'wrapped protocol' }
WeakSubscriptionBuilder >> on: anAnnouncementClass send: aSelector to: anObject [
	^ self subscribe: anAnnouncementClass send: aSelector to: anObject
]

{ #category : #'wrapped protocol' }
WeakSubscriptionBuilder >> subscribe: anAnnouncementClass do: aValuable [ 
	
	^	announcer basicSubscribe: (
			WeakAnnouncementSubscription new 
				announcer: announcer;
				announcementClass: anAnnouncementClass;
				valuable: aValuable)
]

{ #category : #'wrapped protocol' }
WeakSubscriptionBuilder >> subscribe: anAnnouncementClass send: aSelector to: anObject [
	^ self subscribe: anAnnouncementClass do: (WeakMessageSend receiver: anObject selector: aSelector)
]

{ #category : #'wrapped protocol' }
WeakSubscriptionBuilder >> weak [
	"already weak"
	^ self
]

{ #category : #'wrapped protocol' }
WeakSubscriptionBuilder >> when: anAnnouncementClass do: aValuable [
	^ self subscribe: anAnnouncementClass do: aValuable
]
