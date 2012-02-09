Class {
	#name : #GHProxyHandler,
	#superclass : #Object,
	#instVars : [
		'methodsNotToIntercept'
	],
	#category : #GhostProxies
}

{ #category : #'as yet unclassified' }
GHProxyHandler >> defaultMethodsNotToIntercept [
	| dict |
	dict := Dictionary new.
	dict addAll: self methodsMessagesToHandle.
"	dict addAll: self debuggingMessagesToHandle.
	dict addAll: self testSupportMessagesToHandle.
	dict addAll: self classProxyMessagesToHandle."
	^ dict
	
	
]

{ #category : #'as yet unclassified' }
GHProxyHandler >> handleInterception: anInterception [
]

{ #category : #'as yet unclassified' }
GHProxyHandler >> methodsMessagesToHandle [
	| dict |
	dict := Dictionary new.
	dict at: #flushCache put: #handleFlushCache:.
	dict at: #run:with:in: put: #handleMethodExecution:.
	^ dict

]

{ #category : #'as yet unclassified' }
GHProxyHandler >> methodsNotToIntercept [
	methodsNotToIntercept isNil ifTrue: [ methodsNotToIntercept := self defaultMethodsNotToIntercept ].
	^ methodsNotToIntercept 
]
