"
A PhaROSMessageAdapter is a set of adaptions and adaption-polimorfic that applies a set of message sendings in order to get from one object a new one.
"
Class {
	#name : #PhaROSMessageAdapter,
	#superclass : #Object,
	#instVars : [
		'chainOfAdaption'
	],
	#category : #'PhaROS-TopicHandlers'
}

{ #category : #'as yet unclassified' }
PhaROSMessageAdapter >> = anAdaption [
	^ self == anAdaption or: [
	(anAdaption isKindOf: PhaROSMessageAdapter) and:[ 
		chainOfAdaption allSatisfy: [ :a | anAdaption chainOfAdaption includes: a ].	
	] ].
]

{ #category : #'as yet unclassified' }
PhaROSMessageAdapter >> \> anAdaption [
	 chainOfAdaption add: anAdaption adaptToAdapter.
	^ self.
]

{ #category : #'as yet unclassified' }
PhaROSMessageAdapter >> adapt: aMessage [
	^chainOfAdaption  inject: aMessage into: [ : rslt : adaptor | adaptor adapt: rslt ].
]

{ #category : #'as yet unclassified' }
PhaROSMessageAdapter >> adaptToAdapter [
	^ self 
]

{ #category : #'as yet unclassified' }
PhaROSMessageAdapter >> chainOfAdaption [ 
	^ chainOfAdaption 
]

{ #category : #'as yet unclassified' }
PhaROSMessageAdapter >> hash [
	^ chainOfAdaption hash.
]

{ #category : #'as yet unclassified' }
PhaROSMessageAdapter >> initialize [ 
	chainOfAdaption := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
PhaROSMessageAdapter >> printOn: aStream [
	chainOfAdaption do: [ : adaption | adaption printOn: aStream. aStream nextPutAll: '\>' ].
]
