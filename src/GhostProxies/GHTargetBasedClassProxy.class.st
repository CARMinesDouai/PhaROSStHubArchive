Class {
	#name : #GHTargetBasedClassProxy,
	#superclass : #GHAbstractClassProxy,
	#instVars : [
		'handler',
		'target'
	],
	#category : #'GhostProxies-SimpleForwarderExample'
}

{ #category : #'instance creation' }
GHTargetBasedClassProxy class >> createProxyAndReplace: anObjectThenProxy handler: aHandler [
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
GHTargetBasedClassProxy class >> createProxyFor: anObject handler: aHandler [
	| aProxy |
	"It is important to use basicNew because otherwise we are forced to implement #initialize"
    	aProxy:= self basicNew
		initializeWith: anObject
		handler: aHandler. 
       GHProxyTrap initialize.
       ^ aProxy.

]

{ #category : #accessing }
GHTargetBasedClassProxy >> ghostFindClassWithNilMethodDictInHierarchy [
	^ self
]

{ #category : #initialization }
GHTargetBasedClassProxy >> initializeWith: aTarget handler: aHandler [
	self initializeClassProxy.
	target := aTarget.
	handler := aHandler.
	
]

{ #category : #accessing }
GHTargetBasedClassProxy >> proxyHandler [
	^ handler
]

{ #category : #accessing }
GHTargetBasedClassProxy >> proxyTarget [
	^ target
]

{ #category : #accessing }
GHTargetBasedClassProxy >> proxyTarget: anObject [
	target := anObject
]
