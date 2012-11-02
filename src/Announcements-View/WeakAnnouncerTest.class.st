Class {
	#name : #WeakAnnouncerTest,
	#superclass : #AnnouncerTest,
	#category : #'Announcements-Tests-Core'
}

{ #category : #benchmarks }
WeakAnnouncerTest >> benchManyWeakGuys [

	| object ann time |
	
	object := Object new.
	ann := Announcer new.
	
	50000 timesRepeat: [ (ann weak on: Announcement send: #value to: object) ].
	
	self assert: (ann numberOfSubscriptions =  50000).
	
	Smalltalk garbageCollect.
	
	time := [object := nil.
		Smalltalk garbageCollect. 
		 ]timeToRun.
	
	self assert: (ann numberOfSubscriptions = 0).
	^ time
]

{ #category : #benchmarks }
WeakAnnouncerTest >> benchWeakSubscriptionDynamic [

	" run me to see how expensive becomeForward: is (compared to #benchWeakSubscriptionStatic ) "
	| object ann |
	
	object := Object new.
	ann := Announcer new.
	
	^ [
		1000 timesRepeat: [ (ann on: Announcement send: #value to: object) makeWeak ].
	] timeToRun
]

{ #category : #benchmarks }
WeakAnnouncerTest >> benchWeakSubscriptionStatic [

	" run me to see how cheap object creation is (compared to #benchWeakSubscriptionDynamic ) "
	| object ann |
	
	object := Object new.
	ann := Announcer new.
	
	^ [
		1000 timesRepeat: [ (ann weak on: Announcement send: #value to: object)  ].
	] timeToRun
]

{ #category : #private }
WeakAnnouncerTest >> newAnnouncer [
	^ Announcer new
]

{ #category : #testing }
WeakAnnouncerTest >> testNoWeakBlock [
	"There is no such thing as a weak block, these things never go away."

	<expectedFailure>

	| counter |
	counter := 0.

	(announcer subscribe: AnnouncementMockA do: [ :ann | counter := counter + 1 ]) makeWeak.
	
	Smalltalk garbageCollect.
	announcer announce: AnnouncementMockA.
	self assert: counter = 1.
	
	Smalltalk garbageCollect.
	announcer announce: AnnouncementMockA.
	self assert: counter = 2
]

{ #category : #testing }
WeakAnnouncerTest >> testWeakObject [
	| counter collector forwarder |
	counter := 0.
	collector := [ counter := counter + 1 ].
	forwarder := MessageSend receiver: collector selector: #value.
	(announcer subscribe: AnnouncementMockA send: #value to: forwarder) makeWeak.
	
	" shouldn't go away, we are still holding a reference to 'forwarder': "
	Smalltalk garbageCollect.
	announcer announce: AnnouncementMockA.
	self assert: counter = 1.
	
	" should go away as we let the only reference to 'forwarder' go: "
	forwarder := nil.
	Smalltalk garbageCollect.
	announcer announce: AnnouncementMockA.
	self assert: counter = 1
]

{ #category : #testing }
WeakAnnouncerTest >> testWeakSubscription [
	| obj  subscription |
	
	obj := Object new.
	
	subscription := 
		(announcer on: AnnouncementMockA send: #value to: obj) makeWeak.
		
	self assert: (obj == subscription subscriber).
]
