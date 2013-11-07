Class {
	#name : #ROBSession,
	#superclass : #WASession,
	#instVars : [
		'robotProxy'
	],
	#category : #RoboShop
}

{ #category : #accessing }
ROBSession >> robotProxy [
	^ robotProxy
]

{ #category : #accessing }
ROBSession >> robotProxy: anObject [
	robotProxy := anObject
]

{ #category : #'parent/child' }
ROBSession >> unregister [
	robotProxy := nil.
	super unregister 
]
