Class {
	#name : #GHProxyHandler,
	#superclass : #Object,
	#instVars : [
		'methodsNotToIntercept'
	],
	#category : #GhostProxies
}

{ #category : #'as yet unclassified' }
GHProxyHandler >> classProxyMessagesToHandle [
	| dict |
	dict := Dictionary new.
	dict at: #handleInterceptionToInstance:andReceiver:  put: #handleInterceptionToInstanceFor:.
	^ dict

]

{ #category : #'as yet unclassified' }
GHProxyHandler >> defaultMethodsNotToIntercept [
	| dict |
	dict := Dictionary new.
	dict addAll: self methodsMessagesToHandle.
	"dict addAll: self debuggingMessagesToHandle."
	dict addAll: self testSupportMessagesToHandle.
	dict addAll: self classProxyMessagesToHandle.
	^ dict
	
	
]

{ #category : #'as yet unclassified' }
GHProxyHandler >> handleInterception: anInterception [
	self log:  'message ', anInterception message selector, ' intercepted'.
	
	(self isMessageNotToIntercept: anInterception message)
		ifTrue: [ ^ self manageMessageInternally: anInterception  ]
	 	ifFalse: [ ^ self manageMessage: anInterception  ]
	
]

{ #category : #'as yet unclassified' }
GHProxyHandler >> isMessageNotToIntercept: aMessage [
	^ self methodsNotToIntercept includesKey: aMessage selector  
]

{ #category : #'as yet unclassified' }
GHProxyHandler >> manageMessageInternally: anInterception [ 
	self log: 'The method ', anInterception message selector, ' will NOT be forwarded by instead answer by the handler'.
	^ self perform: (self methodsNotToIntercept at: anInterception message selector) with: anInterception 
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

{ #category : #'as yet unclassified' }
GHProxyHandler >> testSupportMessagesToHandle [
	| dict |
	dict := Dictionary new.
	dict at: #uninstall put: #handleUninstall:.
	^ dict 
	
]
