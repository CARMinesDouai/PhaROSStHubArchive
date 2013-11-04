Class {
	#name : #TKTProxyHandler,
	#superclass : #GHSimpleForwarderProxyHandler,
	#instVars : [
		'wrapped'
	],
	#category : #'TaskIT-Util'
}

{ #category : #'as yet unclassified' }
TKTProxyHandler class >> for: anObject [ 
	^ self new wrapp: anObject ; yourself.
]

{ #category : #'as yet unclassified' }
TKTProxyHandler >> handleInterceptionToInstance: anInterception [
	^ (self spawn: ([  super handleInterceptionToInstance: anInterception  ] )) asResult.
]

{ #category : #'as yet unclassified' }
TKTProxyHandler >> handleMethodExecution: anInterception [
	^ (self spawn: ([  super handleMethodExecution: anInterception  ] )) asResult.
]

{ #category : #'as yet unclassified' }
TKTProxyHandler >> manageMessage: anInterception [
	(self shouldFork: anInterception ) ifTrue: [ 
		^ (self spawn: [ super manageMessage: anInterception ]) asResult.	
	 ].
	^super manageMessage: anInterception
]

{ #category : #'as yet unclassified' }
TKTProxyHandler >> shouldFork: anInterception [
	^ ((Object includesSelector: anInterception message selector ) or:[ (Class includesSelector: anInterception message selector )or:[ ClassDescription includesSelector: anInterception message selector ]]) not.
]

{ #category : #'as yet unclassified' }
TKTProxyHandler >> spawn: aBlock [
	self subclassResponsibility.
]
