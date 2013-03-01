Class {
	#name : #BoDefectsCache,
	#superclass : #TestResource,
	#instVars : [
		'defects'
	],
	#category : #'BoTest-Kernel'
}

{ #category : #accessing }
BoDefectsCache >> add: anObject [
	self defects add: anObject 
]

{ #category : #accessing }
BoDefectsCache >> defects [
	^defects 
]

{ #category : #testing }
BoDefectsCache >> includes: anAssociation [
	^self defects includes: anAssociation
]

{ #category : #running }
BoDefectsCache >> setUp [
	super setUp.
	defects := Set new
]
