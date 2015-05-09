Class {
	#name : #GHProxyHandler,
	#superclass : #Object,
	#instVars : [
		'methodsNotToIntercept'
	],
	#category : #GhostProxies
}

{ #category : #'handle - debugging' }
GHProxyHandler >> debuggingMessagesToHandle [
	| dict |
	dict := Dictionary new.
	dict at: #basicInspect put:#handleBasicInspect:.
	dict at: #inspect put:#handleInspect:.
	dict at: #inspectorClass put:#handleInspectorClass:.
	dict at: #defaultLabelForInspector put:#handleDefaultLabelForInspector:.
	dict at: #printStringLimitedTo: put: #handlePrintStringLimitedTo:.
	dict at: #printString put: #handlePrintString:.
	dict at: #longPrintOn:limitedTo:indent: put: #handleLongPrintOnLimitedToIndent:.
	^ dict	
]

{ #category : #private }
GHProxyHandler >> defaultMethodsNotToIntercept [
	| dict |
	dict := Dictionary new.
	dict addAll: self methodsMessagesToHandle.
	dict addAll: self debuggingMessagesToHandle.
	dict addAll: self testSupportMessagesToHandle.
	^ dict
	
	
]

{ #category : #'handle - debugging' }
GHProxyHandler >> handleBasicInspect: anInterception [
	"Create and schedule an Inspector in which the user can examine the 
	receiver's variables. This method should not be overriden."
	^Smalltalk tools basicInspect: anInterception proxy
]

{ #category : #'handle - debugging' }
GHProxyHandler >> handleDefaultLabelForInspector: anInterception [
	^ 'Proxy'
]

{ #category : #'handle - methods' }
GHProxyHandler >> handleFlushCache: anInterception [
	^ self subclassResponsibility 
]

{ #category : #'handle - debugging' }
GHProxyHandler >> handleInspect: anInterception [
	"Create and schedule an Inspector in which the user can examine the receiver's variables."
	Smalltalk tools inspect: anInterception proxy
]

{ #category : #'handle - debugging' }
GHProxyHandler >> handleInspectorClass: anInterception [
	"Answer the class of the inspector to be used on the receiver.  Called by inspect; 
	use basicInspect to get a normal (less useful) type of inspector."

	^ Smalltalk tools inspector 
]

{ #category : #'handle - API' }
GHProxyHandler >> handleInterception: anInterception [
	self log:  'message ', anInterception message selector, ' intercepted'.
	
	(self isMessageNotToIntercept: anInterception message)
		ifTrue: [ ^ self manageMessageInternally: anInterception  ]
	 	ifFalse: [ ^ self manageMessage: anInterception  ]
	
]

{ #category : #'handle - class proxy' }
GHProxyHandler >> handleInterceptionToInstance: anInterception [
	^ self subclassResponsibility 
]

{ #category : #'handle - debugging' }
GHProxyHandler >> handleLongPrintOnLimitedToIndent: anInterception [
	
]

{ #category : #'handle - debugging' }
GHProxyHandler >> handleLongPrintStringLimitedTo: anInterception [
	^ 'This is a proxy'
]

{ #category : #'handle - methods' }
GHProxyHandler >> handleMethodExecution: anInterception [
	^ self subclassResponsibility 
]

{ #category : #'handle - debugging' }
GHProxyHandler >> handlePrintOn: anInterception [
	anInterception message arguments first nextPutAll: 'aProxy'  
]

{ #category : #'handle - debugging' }
GHProxyHandler >> handlePrintString: anInterception [
	^ anInterception proxy printStringLimitedTo: 50000
]

{ #category : #'handle - debugging' }
GHProxyHandler >> handlePrintStringLimitedTo: anInterception [
	^ 'This is the print of a proxy'
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
	GHGhostLogger log: aString.
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
