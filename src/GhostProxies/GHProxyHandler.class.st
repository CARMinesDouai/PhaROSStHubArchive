Class {
	#name : #GHProxyHandler,
	#superclass : #Object,
	#instVars : [
		'methodsNotToIntercept'
	],
	#category : #GhostProxies
}

{ #category : #'handle - class proxy' }
GHProxyHandler >> classProxyMessagesToHandle [
	| dict |
	dict := Dictionary new.
	dict at: #handleInterceptionToInstance:andReceiver:  put: #handleInterceptionToInstanceFor:.
	^ dict

]

{ #category : #private }
GHProxyHandler >> defaultMethodsNotToIntercept [
	| dict |
	dict := Dictionary new.
	dict addAll: self methodsMessagesToHandle.
	dict addAll: self debuggingMessagesToHandle.
	dict addAll: self testSupportMessagesToHandle.
	dict addAll: self classProxyMessagesToHandle.
	^ dict
	
	
]

{ #category : #'handle - methods' }
GHProxyHandler >> handleFlushCache: anInterception [
	^ self subclassResponsibility 
]

{ #category : #'handle - API' }
GHProxyHandler >> handleInterception: anInterception [
	self log:  'message ', anInterception message selector, ' intercepted'.
	
	(self isMessageNotToIntercept: anInterception message)
		ifTrue: [ ^ self manageMessageInternally: anInterception  ]
	 	ifFalse: [ ^ self manageMessage: anInterception  ]
	
]

{ #category : #'handle - class proxy' }
GHProxyHandler >> handleInterceptionToInstanceFor: anInterception [
	^ self subclassResponsibility 
]

{ #category : #'handle - methods' }
GHProxyHandler >> handleMethodExecution: anInterception [
	^ self subclassResponsibility 
]

{ #category : #'handle - support' }
GHProxyHandler >> handleUninstall: anInterception [
	^ self subclassResponsibility 
]

{ #category : #private }
GHProxyHandler >> isMessageNotToIntercept: aMessage [
	^ self methodsNotToIntercept includesKey: aMessage selector  
]

{ #category : #private }
GHProxyHandler >> log: aString [
	GHGhostLogger logger log: aString.
]

{ #category : #'handle - API' }
GHProxyHandler >> manageMessage: interception [
	^ self subclassResponsibility 
]

{ #category : #private }
GHProxyHandler >> manageMessageInternally: anInterception [ 
	self log: 'The method ', anInterception message selector, ' will NOT be forwarded by instead answer by the handler'.
	^ self perform: (self methodsNotToIntercept at: anInterception message selector) with: anInterception 
]

{ #category : #'handle - methods' }
GHProxyHandler >> methodsMessagesToHandle [
	| dict |
	dict := Dictionary new.
	dict at: #flushCache put: #handleFlushCache:.
	dict at: #run:with:in: put: #handleMethodExecution:.
	^ dict

]

{ #category : #private }
GHProxyHandler >> methodsNotToIntercept [
	methodsNotToIntercept isNil ifTrue: [ methodsNotToIntercept := self defaultMethodsNotToIntercept ].
	^ methodsNotToIntercept 
]

{ #category : #'handle - support' }
GHProxyHandler >> testSupportMessagesToHandle [
	| dict |
	dict := Dictionary new.
	dict at: #uninstall put: #handleUninstall:.
	^ dict 
	
]
