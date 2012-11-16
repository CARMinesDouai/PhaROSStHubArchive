Class {
	#name : #GHSimpleForwarderProxyHandler,
	#superclass : #GHProxyHandler,
	#category : #'GhostProxies-SimpleForwarderExample'
}

{ #category : #'handle - methods' }
GHSimpleForwarderProxyHandler >> handleFlushCache: anInterception [
	^ anInterception proxy proxyTarget selector flushCache	 
		
]

{ #category : #'handle - class proxy' }
GHSimpleForwarderProxyHandler >> handleInterceptionToInstance: anInterception [
	| targetClass message |
	targetClass := anInterception proxy proxyTarget.
	message := anInterception message.
	self log: 'message ',  message selector, ' to instance intercepted and will be forwarded'.
	^ CompiledMethod receiver: anInterception receiver withArguments: message arguments executeMethod:  (targetClass lookupSelector: message selector) 
	
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
	| result |
	self log: 'The method ', interception message selector, ' will beforwarded'.
	result := interception message sendTo: interception proxy proxyTarget.
	^ (result == interception proxy proxyTarget)
		ifTrue: [ interception proxy ]
		ifFalse: [ result ] 
]
