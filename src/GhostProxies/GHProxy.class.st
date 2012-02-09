Class {
	#name : #GHProxy,
	#superclass : #GHAbstractProxy,
	#instVars : [
		'handler',
		'target'
	],
	#category : #GhostProxies
}

{ #category : #'instance creation' }
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

{ #category : #'instance creation' }
GHProxy class >> createProxyFor: anObject handler: aHandler [
	| aProxy |
	"It is important to use basicNew because otherwise we are forced to implement #initialize"
    	aProxy:= self basicNew
		initializeWith: anObject
		handler: aHandler. 
       GHProxyTrap initialize.
       ^ aProxy.

]

{ #category : #initialization }
GHProxy >> initializeWith: aTarget handler: aHandler [
	target := aTarget.
	handler := aHandler
]

{ #category : #accessing }
GHProxy >> isProxy [
	^ true
]

{ #category : #accessing }
GHProxy >> proxyHandler [
	^ handler
]

{ #category : #accessing }
GHProxy >> proxyTarget [
	^ target
]

{ #category : #accessing }
GHProxy >> proxyTarget: aTarget [
	target := aTarget
]
