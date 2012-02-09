Class {
	#name : #GHProxy,
	#superclass : #GHAbstractProxy,
	#instVars : [
		'handler',
		'target'
	],
	#category : #GhostProxies
}

{ #category : #'as yet unclassified' }
GHProxy class >> createProxyAndReplace: anObjectThenProxy handler: aHandler [
   | aProxyThenObject |
	"It is important to use basicNew because otherwise we are forced to implement #initialize"
       aProxyThenObject := self basicNew
		initializeWith: anObjectThenProxy
		handler: aHandler. 
		"I cannot send #become because it will be intercepted by the proxy"	
	(Array with: aProxyThenObject)
		elementsExchangeIdentityWith:
			(Array with: anObjectThenProxy).
        "After the become is done, aProxyThenObject now points
	 to the original object, and  anObjectThenProxy points to 
	the proxy"
       anObjectThenProxy proxyTarget: aProxyThenObject.
	GHProxyTrap initialize.
       ^ anObjectThenProxy.

]

{ #category : #'as yet unclassified' }
GHProxy class >> createProxyFor: anObject handler: aHandler [
	| aProxy |
	"It is important to use basicNew because otherwise we are forced to implement #initialize"
    	aProxy:= self basicNew
		initializeWith: anObject
		handler: aHandler. 
       GHProxyTrap initialize.
       ^ aProxy.

]

{ #category : #'as yet unclassified' }
GHProxy >> initializeWith: aTarget handler: aHandler [
	target := aTarget.
	handler := aHandler
]

{ #category : #'as yet unclassified' }
GHProxy >> proxyHandler [
	^ handler
]

{ #category : #'as yet unclassified' }
GHProxy >> proxyTarget [
	^ target
]

{ #category : #'as yet unclassified' }
GHProxy >> proxyTarget: aTarget [
	target := aTarget
]
