"
The code is based on the announcements as described by Vassili Bykov in <http://www.cincomsmalltalk.com/userblogs/vbykov/blogView?searchCategory=Announcements%20Framework>. The implementation uses a threadsafe subscription registry, in the sense that registering, unregistering, and announcing from an announcer at the same time in different threads should never cause failures.

For security reasons, registry is kept private, and has no accessor like in other implementations
"
Class {
	#name : #Announcer,
	#superclass : #Object,
	#instVars : [
		'registry'
	],
	#category : #'Announcements-Core'
}

{ #category : #announce }
Announcer >> announce: anAnnouncement [

	| announcement |
	announcement := anAnnouncement asAnnouncement.	
	registry ifNotNil: [
		registry deliver: announcement
		].
	^ announcement
]

{ #category : #private }
Announcer >> basicSubscribe: subscription [
	^ registry add: subscription
]

{ #category : #'initialize-release' }
Announcer >> initialize [
	super initialize.
	registry := SubscriptionRegistry new.
]

{ #category : #statistics }
Announcer >> numberOfSubscriptions [
	^ registry numberOfSubscriptions

]

{ #category : #convenience }
Announcer >> on: anAnnouncementClass do: aValuable [
	"Declare that when anAnnouncementClass is raised, aValuable is executed."
	
	^ self subscribe: anAnnouncementClass do: aValuable
]

{ #category : #convenience }
Announcer >> on: anAnnouncementClass send: aSelector to: anObject [
	"Declare that when anAnnouncementClass is raised, anObject should receive the message aSelector."

	^ self subscribe: anAnnouncementClass send: aSelector to: anObject
]

{ #category : #'*announcements-view' }
Announcer >> open [
	AnnouncementSpy openOn: self
]

{ #category : #'*announcements-view' }
Announcer >> open [
	AnnouncementSpy openOn: self
]

{ #category : #subscription }
Announcer >> removeSubscription: subscription [
	"Remove the given subscription from the receiver"
	
	^ registry remove: subscription

]

{ #category : #private }
Announcer >> replace: subscription with: newOne [
	^ registry replace: subscription with: newOne

]

{ #category : #subscription }
Announcer >> subscribe: anAnnouncementClass do: aValuable [ 
	"Declare that when anAnnouncementClass is raised, aValuable is executed."
	^ registry add: (
		AnnouncementSubscription new 
			announcer: self;
			announcementClass: anAnnouncementClass;
			valuable: aValuable)
]

{ #category : #subscription }
Announcer >> subscribe: anAnnouncementClass send: aSelector to: anObject [
	"Declare that when anAnnouncementClass is raised, anObject should receive the message aSelector."
	
	^ self subscribe: anAnnouncementClass do: (MessageSend receiver: anObject selector: aSelector)
]

{ #category : #subscription }
Announcer >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"
	
	registry removeSubscriber: anObject
]

{ #category : #weak }
Announcer >> weak [
	"announcer weak subscribe: foo"
	^ WeakSubscriptionBuilder on: self
]

{ #category : #convenience }
Announcer >> when: anAnnouncementClass do: aValuable [
	"Declare that when anAnnouncementClass is raised, aValuable is executed."
	
	^ self subscribe: anAnnouncementClass do: aValuable
]
