Class {
	#name : #TKTSpawnerProxyHandler,
	#superclass : #TKTProxyHandler,
	#instVars : [
		'wrapped'
	],
	#category : #'TaskIT-Sugar'
}

{ #category : #'as yet unclassified' }
TKTSpawnerProxyHandler class >> for: anObject [ 
	^ self new wrapp: anObject ; yourself.
]

{ #category : #'handle - class proxy' }
TKTSpawnerProxyHandler >> handleInterceptionToInstance: anInterception [
	^ (self spawn: ([  super handleInterceptionToInstance: anInterception  ] )) asResult.
]

{ #category : #'handle - methods' }
TKTSpawnerProxyHandler >> handleMethodExecution: anInterception [
	^ (self spawn: ([  super handleMethodExecution: anInterception  ] )) asResult.
]

{ #category : #handle }
TKTSpawnerProxyHandler >> manageMessage: anInterception [
	(self shouldFork: anInterception ) ifTrue: [ 
		^ (self spawn: [ super manageMessage: anInterception ]) asResult.	
	 ].
	^super manageMessage: anInterception
]

{ #category : #testing }
TKTSpawnerProxyHandler >> shouldFork: anInterception [
	^ ((Object includesSelector: anInterception message selector ) or:[ (Class includesSelector: anInterception message selector )or:[ ClassDescription includesSelector: anInterception message selector ]]) not.
]

{ #category : #running }
TKTSpawnerProxyHandler >> spawn: aBlock [
	self subclassResponsibility.
]
