Class {
	#name : #GHGhostLogger,
	#superclass : #Object,
	#classVars : [
		'ProxiesLoggerHolder'
	],
	#category : #GhostProxies
}

{ #category : #logging }
GHGhostLogger class >> log: aString [
	Transcript show: aString; cr.
	"use a real logger in the future (like the pulpe)"
	self flag: #fixMe
]

{ #category : #seeClassSide }
GHGhostLogger >> seeClassSide [ 
]
