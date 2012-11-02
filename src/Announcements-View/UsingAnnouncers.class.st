Class {
	#name : #UsingAnnouncers,
	#superclass : #Object,
	#instVars : [
		'kindOfAnnouncer'
	],
	#category : #'Announcements-Support-Test'
}

{ #category : #uses }
UsingAnnouncers >> useCommonAnnouncer [
	kindOfAnnouncer := Announcer new.
	
	" Ok this version is clear, easy, but naive. Now we have a variable that points to the announcer, but an announcer is an object that may be accesible for any interested object, so i need an accessor of kindOfAnnouncer, and then now UsingAnnouncer is like ComposedLikeAnnouncer. "
	kindOfAnnouncer subscribe: Announcement do: [ "something"].
]

{ #category : #uses }
UsingAnnouncers >> useComposeLikeAnnouncer [
	kindOfAnnouncer := ComposedLikeAnnouncer new. 
	
	" 
		In order to give to clients the posibility to subscribe, you need to access first the real announcer in this kind of solution.
		
	"
	
	kindOfAnnouncer announcer subscribe: Announcement do: [ "something" ].
	
]

{ #category : #uses }
UsingAnnouncers >> useInheritedAnnouncer [
	kindOfAnnouncer := InheritedAnnouncer new.
	
	"
		this solution is clear in terms of use, but in terms of design, you need to sublass Announcer just to get this behavior. 
	"
	
	kindOfAnnouncer subscribe: Announcement do: [ "something" ].
]

{ #category : #uses }
UsingAnnouncers >> useTraitedAnnouncer [

	kindOfAnnouncer := Announcer new.
	
	" Ok this version is clear, easy, but naive. Now we have a variable that points to the announcer, but an announcer is an object that may be accesible for any interested object, so i need an accessor of kindOfAnnouncer, and then now UsingAnnouncer is like ComposedLikeAnnouncer. "
	kindOfAnnouncer subscribe: Announcement do: [ "something"].
]
