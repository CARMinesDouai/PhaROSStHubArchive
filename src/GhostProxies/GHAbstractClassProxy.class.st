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
	superclass := GHMethodLookupInterceptionDelegator.
	methodDict := nil.
	format := GHAbstractClassProxy format.
]
