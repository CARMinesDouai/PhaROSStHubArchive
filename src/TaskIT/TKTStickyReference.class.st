Class {
	#name : #TKTStickyReference,
	#superclass : #GHTargetBasedProxy,
	#category : #'TaskIT-Util'
}

{ #category : #'as yet unclassified' }
TKTStickyReference class >> for: anObject [
	^ self createProxyFor:anObject handler: GHSimpleForwarderProxyHandler new.
]

{ #category : #'as yet unclassified' }
TKTStickyReference >> asStickyReference [ 
	^ self .
]

{ #category : #'as yet unclassified' }
TKTStickyReference >> finalize [ 
	self halt.
	self proxyTarget finalize.
	target := nil. 
]

{ #category : #'as yet unclassified' }
TKTStickyReference >> proxyTarget: aTarget [

	aTarget finalizationRegistry add: self.
	self toFinalizeSend:#finalize to:aTarget  with: aTarget.
	^ super proxyTarget: aTarget.
	
]
