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

{ #category : #'handle - class proxy' }
TKTProxyHandler >> handleInterceptionToInstance: anInterception [
	^ (self spawn: ([  super handleInterceptionToInstance: anInterception  ] )) asResult.
]

{ #category : #'handle - methods' }
TKTProxyHandler >> handleMethodExecution: anInterception [
	^ (self spawn: ([  super handleMethodExecution: anInterception  ] )) asResult.
]

{ #category : #'handle - debugging' }
TKTProxyHandler >> handlePrintStringLimitedTo: anInterception [
	| proxy |
	proxy := anInterception proxy. 
	^ 'This is the print of a proxy of class: ',  proxy tktClass name asString.
]

{ #category : #handle }
TKTProxyHandler >> manageMessage: anInterception [
	(self shouldFork: anInterception ) ifTrue: [ 
		^ (self spawn: [ super manageMessage: anInterception ]) asResult.	
	 ].
	^super manageMessage: anInterception
]

{ #category : #testing }
TKTProxyHandler >> shouldFork: anInterception [
	^ ((Object includesSelector: anInterception message selector ) or:[ (Class includesSelector: anInterception message selector )or:[ ClassDescription includesSelector: anInterception message selector ]]) not.
]

{ #category : #running }
TKTProxyHandler >> spawn: aBlock [
	self subclassResponsibility.
]
