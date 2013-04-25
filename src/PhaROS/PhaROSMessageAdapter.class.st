Class {
	#name : #PhaROSMessageAdapter,
	#superclass : #Object,
	#instVars : [
		'chainOfAdaption'
	],
	#category : #'PhaROS-MessageAdapter'
}

{ #category : #'as yet unclassified' }
PhaROSMessageAdapter >> \> anAdaption [
	 chainOfAdaption add: anAdaption adapToAdapter.
	^ self.
]

{ #category : #'as yet unclassified' }
PhaROSMessageAdapter >> adapt: aMessage [
	^chainOfAdaption  inject: aMessage into: [ : rslt : adaptor | adaptor adapt: rslt ].
]

{ #category : #'as yet unclassified' }
PhaROSMessageAdapter >> initialize [ 
	chainOfAdaption := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
PhaROSMessageAdapter >> printOn: aStream [
	chainOfAdaption do: [ : adaption | adaption printOn: aStream. aStream nextPutAll: '\>' ].
]
