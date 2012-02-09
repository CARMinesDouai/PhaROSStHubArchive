Class {
	#name : #GHSimpleForwarderProxyHandler,
	#superclass : #GHProxyHandler,
	#category : #GhostProxies
}

{ #category : #'as yet unclassified' }
GHSimpleForwarderProxyHandler >> handleFlushCache: anInterception [
	^ anInterception proxy proxyTarget selector flushCache	 
		
]

{ #category : #'as yet unclassified' }
GHSimpleForwarderProxyHandler >> handleInterception: anInterception [
	self log:  'message ', anInterception message selector, ' intercepted'.
	^ self manageMessage: anInterception.
	
]

{ #category : #'as yet unclassified' }
GHSimpleForwarderProxyHandler >> handleMethodExecution: anInterception [
	self log: 'message ', anInterception message selector, ' execution intercepted and will be forwarded'.
	^ anInterception proxy proxyTarget valueWithReceiver: anInterception message arguments third arguments: anInterception message arguments second
	

]

{ #category : #'as yet unclassified' }
GHSimpleForwarderProxyHandler >> log: aString [
	GHGhostLogger logger log: aString.
]

{ #category : #'as yet unclassified' }
GHSimpleForwarderProxyHandler >> manageMessage: interception [
	self log: 'The method ', interception message selector, ' will beforwarded'.
	^ interception message sendTo: interception proxy proxyTarget
]
