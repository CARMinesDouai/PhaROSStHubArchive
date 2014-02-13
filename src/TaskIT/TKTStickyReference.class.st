Class {
	#name : #TKTStickyReference,
	#superclass : #TKTAbstractProxy,
	#instVars : [
		'witness'
	],
	#category : #'TaskIT-Util'
}

{ #category : #'as yet unclassified' }
TKTStickyReference class >> for: anObject [
	| handler |
	handler := TKTProxyHandler new.
"	handler methodsNotToIntercept at: #printStringLimitedTo: put:#handlePrintStringLimitedTo:."
	
	^ self createProxyFor:anObject handler: handler.
]

{ #category : #'*TaskIT' }
TKTStickyReference >> asStickyReference [ 
	^ self .
]

{ #category : #hash }
TKTStickyReference >> basicIdentityHash [
	"Answer a SmallInteger whose value is related to the receiver's identity.
	This method must not be overridden, except by SmallInteger.
	Primitive. Fails if the receiver is a SmallInteger. Essential.
	See Object documentation whatIsAPrimitive.

	Do not override. Use #identityHash unless you really know what you're doing.'"

	<primitive: 75>
	self primitiveFailed
]

{ #category : #accessing }
TKTStickyReference >> executor [
	"Return an object which can act as executor for finalization of the receiver"
	^self shallowCopy actAsExecutor
]

{ #category : #finalization }
TKTStickyReference >> finalize [

	self halt.
	self proxyTarget finalize.
	target := nil. 
]

{ #category : #hash }
TKTStickyReference >> identityHash [
	"Answer a SmallInteger whose value is related to the receiver's identity.
	This method must not be overridden, except by SmallInteger.
	
	Do not override."

	^ self basicIdentityHash bitShift: 18
]

{ #category : #initialization }
TKTStickyReference >> initializeWith: aTarget handler: aHandler [
	super initializeWith: aTarget handler: aHandler.
	witness := TKTWitness for: aTarget.
	
]

{ #category : #hash }
TKTStickyReference >> largeIdentityHash [
	<primitive: 75>
	self primitiveFailed
]
