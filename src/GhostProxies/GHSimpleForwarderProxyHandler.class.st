Class {
	#name : #GHSimpleForwarderProxyHandler,
	#superclass : #GHProxyHandler,
	#category : #GhostProxies
}

{ #category : #'handle - methods' }
GHSimpleForwarderProxyHandler >> handleFlushCache: anInterception [
	^ anInterception proxy proxyTarget selector flushCache	 
		
]

{ #category : #'handle - class proxy' }
GHSimpleForwarderProxyHandler >> handleInterceptionToInstanceFor: anInterception [
	| message targetClass receiver |
	message := anInterception message arguments first.
	targetClass := anInterception proxy proxyTarget.
	receiver := anInterception message arguments second.
	self log: 'message ', message selector, ' to instance intercepted and will be forwarded'.
	^ CompiledMethod receiver: receiver withArgs: message arguments  executeMethod:  (targetClass lookupSelector: message selector) 
	
]

{ #category : #'handle - methods' }
GHSimpleForwarderProxyHandler >> handleMethodExecution: anInterception [
	self log: 'message ', anInterception message selector, ' execution intercepted and will be forwarded'.
	^ anInterception proxy proxyTarget valueWithReceiver: anInterception message arguments third arguments: anInterception message arguments second
	

]

{ #category : #'handle - support' }
GHSimpleForwarderProxyHandler >> handleUninstall: anInterception [

	self log: 'message ', anInterception message selector, ' received and the proxy will be uninstalled'.
	^ anInterception proxy proxyTarget become: anInterception proxy.
	
]

{ #category : #handle }
GHSimpleForwarderProxyHandler >> manageMessage: interception [
	self log: 'The method ', interception message selector, ' will beforwarded'.
	^ interception message sendTo: interception proxy proxyTarget
]