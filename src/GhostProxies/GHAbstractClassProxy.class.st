Class {
	#name : #GHAbstractClassProxy,
	#superclass : #GHAbstractProxy,
	#instVars : [
		'superclass',
		'methodDict',
		'format'
	],
	#category : #GhostProxies
}

{ #category : #initialization }
GHAbstractClassProxy >> initializeClassProxy [
	superclass := GHInstanceOfProxifiedClassInterceptionDelegator.
	methodDict := nil.
	format := GHAbstractClassProxy format.
]
