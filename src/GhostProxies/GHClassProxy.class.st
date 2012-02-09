Class {
	#name : #GHClassProxy,
	#superclass : #GHAbstractClassProxy,
	#instVars : [
		'handler',
		'target'
	],
	#category : #GhostProxies
}

{ #category : #'instance creation' }
GHClassProxy class >> createProxyAndReplace: anObjectThenProxy handler: aHandler [
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

{ #category : #'instance creation' }
GHClassProxy class >> createProxyFor: anObject handler: aHandler [
	| aProxy |
	"It is important to use basicNew because otherwise we are forced to implement #initialize"
    	aProxy:= self basicNew
		initializeWith: anObject
		handler: aHandler. 
       GHProxyTrap initialize.
       ^ aProxy.

]

{ #category : #initialization }
GHClassProxy >> initializeWith: aTarget handler: aHandler [
	self initializeClassProxy.
	target := aTarget.
	handler := aHandler.
	
]

{ #category : #accessing }
GHClassProxy >> proxyHandler [
	^ handler
]

{ #category : #accessing }
GHClassProxy >> proxyTarget [
	^ target
]

{ #category : #accessing }
GHClassProxy >> proxyTarget: anObject [
	target := anObject
]
