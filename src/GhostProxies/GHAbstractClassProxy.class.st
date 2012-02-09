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

{ #category : #'as yet unclassified' }
GHAbstractClassProxy >> initializeClassProxy [
	superclass := GHInstanceOfProxifiedClassInterceptionDelegator.
	methodDict := nil.
	format := GHAbstractClassProxy format.
]
