"
The subscription registry is a threadsafe storage for the subscriptions to an Announcer.

In Pharo, subscriptionsFor: protocol is not implemented.
This is because Announcer does not provide public access to its registery for encapsulation reasons.
(We do not want access to the announcer from action blocks to break encapsulation to other subscribers)
"
Class {
	#name : #SubscriptionRegistry,
	#superclass : #Object,
	#instVars : [
		'subscriptions',
		'monitor'
	],
	#category : #'Announcements-Core'
}

{ #category : #'add/remove' }
SubscriptionRegistry >> add: subscription [
	^ self protected: [
		subscriptions add: subscription  ]

]

{ #category : #announcing }
SubscriptionRegistry >> deliver: anAnnouncement [
	|  interestedSubscriptions |
	
	"using a copy, so subscribers can unsubscribe from announcer "
	
	subscriptions isEmpty ifTrue: [ ^ self ].
	self protected: [ 
		interestedSubscriptions := self subscriptionsHandling: anAnnouncement ].
	self deliver: anAnnouncement to: interestedSubscriptions
]

{ #category : #private }
SubscriptionRegistry >> deliver: anAnnouncement to: subs [
	^ self deliver: anAnnouncement to: subs startingAt: 1
]

{ #category : #private }
SubscriptionRegistry >> deliver: anAnnouncement to: subs startingAt: startIndex [
	
	startIndex to: subs size do: [ :index| | subscription |
		subscription := subs at: index.
		[ subscription deliver: anAnnouncement ] 
			"Ensure delivery to remaining announcements"
			ifCurtailed: [
				self deliver: anAnnouncement to: subs startingAt: index + 1 ]]
]

{ #category : #'initialize-release' }
SubscriptionRegistry >> initialize [
	monitor := Semaphore forMutualExclusion.
	self reset

]

{ #category : #accessing }
SubscriptionRegistry >> numberOfSubscriptions [
	^ subscriptions size
]

{ #category : #private }
SubscriptionRegistry >> protected: aBlock [
	^ monitor critical: [ aBlock value ]
]

{ #category : #'add/remove' }
SubscriptionRegistry >> remove: subscription [
	^ self protected: [
		subscriptions remove: subscription ifAbsent: nil ]


]

{ #category : #'add/remove' }
SubscriptionRegistry >> removeSubscriber: subscriber [
	
	^ self protected: [
		subscriptions removeAllSuchThat: [:subscription | subscription subscriber == subscriber ]]


]

{ #category : #'add/remove' }
SubscriptionRegistry >> replace: subscription with: newOne [

	" Note that it will signal an error if subscription is not there "
	self protected: [
		subscriptions remove: subscription.
		subscriptions add: newOne 
	].
	^ newOne
]

{ #category : #'initialize-release' }
SubscriptionRegistry >> reset [
	"subscriber -> subscriptions"
	
	subscriptions := IdentitySet new
	



]

{ #category : #accessing }
SubscriptionRegistry >> subscriptionsHandling: anAnnouncement [
	^ Array streamContents: [ :s|
			subscriptions do: [:each| 
				(each handles: anAnnouncement class)
					ifTrue: [ s nextPut: each ]]]
]

{ #category : #iterating }
SubscriptionRegistry >> subscriptionsOf: aSubscriber do: aBlock [
	| copy |
	
	self protected: [ copy := subscriptions copy ].
	
	copy do: 
		[:subscription | 
			subscription subscriber == aSubscriber 
				ifTrue: [ aBlock value: subscription ]	]

]
