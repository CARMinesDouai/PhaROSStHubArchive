"
An AnnouncerTest is a test class used to test Announcer.

Instance Variables
	announcer:		<Announcer>  the announcer to test

announcer
	- the announcer that is tested

"
Class {
	#name : #AnnouncerTest,
	#superclass : #TestCase,
	#instVars : [
		'announcer'
	],
	#category : #'Announcements-Tests-Core'
}

{ #category : #testing }
AnnouncerTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #private }
AnnouncerTest >> newAnnouncer [
	^ Announcer new
]

{ #category : #running }
AnnouncerTest >> setUp [
	super setUp.
	announcer := self newAnnouncer
]

{ #category : #testing }
AnnouncerTest >> testAnnounceClass [
	self assert: (announcer announce: AnnouncementMockA) 
		class = AnnouncementMockA
]

{ #category : #testing }
AnnouncerTest >> testAnnounceInstance [
	| instance |
	instance := AnnouncementMockA new.
	self assert: (announcer announce: instance) = instance
]

{ #category : #testing }
AnnouncerTest >> testAnnouncingReentrant [
	" Test that it is safe to announce when handling announcement,
	so announcer are reentrant "

	" self run: #testAnnouncingReentrant "

	| bool ok |

	ok := bool := false.
	announcer on: Announcement do: [
		bool ifFalse: [
			bool := true.
		announcer announce:  Announcement new. ]
		ifTrue: [ ok := true ] 
	].

	self should: [ announcer announce: Announcement new. ] notTakeMoreThan: 1 second.
	self assert: ok


]

{ #category : #testing }
AnnouncerTest >> testNoArgBlock [
	"we are supposed to accept zero-argument blocks as actions "
	| announcement counter |
	counter := nil.

	self shouldnt: [	
		announcer
			subscribe: AnnouncementMockA 
			do: [ counter:= 1 ] ] raise: Exception.

	self shouldnt: [announcer announce: AnnouncementMockA new] raise: Exception.
	self assert:  counter =1
]

{ #category : #testing }
AnnouncerTest >> testSubscribeBlock [
	| announcement instance |
	announcer
		subscribe: AnnouncementMockA
		do: [ :ann | announcement := ann ].
		
	announcement := nil.
	instance := announcer announce: AnnouncementMockA.
	self assert: announcement = instance.
	
	announcement := nil.
	instance := announcer announce: AnnouncementMockB.
	self assert: announcement isNil
]

{ #category : #testing }
AnnouncerTest >> testSubscribeSend [
	| announcement instance |
	announcer
		subscribe: AnnouncementMockA
		send: #value:
		to: [ :ann | announcement := ann ].
		
	announcement := nil.
	instance := announcer announce: AnnouncementMockA.
	self assert: announcement = instance.
	
	announcement := nil.
	instance := announcer announce: AnnouncementMockB new.
	self assert: announcement isNil
]

{ #category : #testing }
AnnouncerTest >> testSubscribeSet [
	| announcement instance |
	announcer
		subscribe: AnnouncementMockA , AnnouncementMockC
		do: [ :ann | announcement := ann ].
		
	announcement := nil.
	instance := announcer announce: AnnouncementMockA.
	self assert: announcement = instance.
	
	announcement := nil.
	instance := announcer announce: AnnouncementMockB.
	self assert: announcement isNil.
	
	announcement := nil.
	instance := announcer announce: AnnouncementMockC.
	self assert: announcement = instance
]

{ #category : #testing }
AnnouncerTest >> testSubscribeSubclass [
	| announcement instance |
	announcer
		subscribe: AnnouncementMockB
		do: [ :ann | announcement := ann ].
		
	announcement := nil.
	instance := announcer announce: AnnouncementMockA.
	self assert: announcement isNil.

	announcement := nil.
	instance := announcer announce: AnnouncementMockB.
	self assert: announcement = instance.
	
	announcement := nil.
	instance := announcer announce: AnnouncementMockC.
	self assert: announcement = instance.
]

{ #category : #testing }
AnnouncerTest >> testTwoArgBlock [
	"we are supposed to accept two-argument blocks as actions "
	| announcement flag |
	
	
	self shouldnt: [
		announcer
			subscribe: AnnouncementMockA 
			do: [:ann :announcer2 | flag := announcer2 == announcer ]
		] raise: Exception.

	self shouldnt: [announcer announce: AnnouncementMockA new] raise: Exception.
	self assert:  flag
]

{ #category : #testing }
AnnouncerTest >> testUnsubscribeBlock [
	| announcement |
	announcer
		subscribe: AnnouncementMockA
		do: [ :ann | announcement := ann ].
	announcer
		unsubscribe: self.

	announcement := nil.
	announcer announce: AnnouncementMockA new.
	self assert: announcement isNil
]

{ #category : #testing }
AnnouncerTest >> testUnsubscribeSend [
	| announcement receiver |
	announcer
		subscribe: AnnouncementMockA
		send: #value:
		to: (receiver := [ :ann | announcement := ann ]).
	announcer
		unsubscribe: receiver.

	announcement := nil.
	announcer announce: AnnouncementMockA new.
	self assert: announcement isNil
]

{ #category : #testing }
AnnouncerTest >> testUnsubscribeSet [
	| announcement |
	announcer
		subscribe: AnnouncementMockA , AnnouncementMockB
		do: [ :ann | announcement := ann ].
	announcer
		unsubscribe: self.

	announcement := nil.
	announcer announce: AnnouncementMockA new.
	self assert: announcement isNil.
	
	announcement := nil.
	announcer announce: AnnouncementMockB new.
	self assert: announcement isNil.
]
