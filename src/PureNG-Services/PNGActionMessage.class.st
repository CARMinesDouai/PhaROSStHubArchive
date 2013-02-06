Class {
	#name : #PNGActionMessage,
	#superclass : #PNGEncodedMessage,
	#instVars : [
		'target',
		'decoder',
		'action'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #accessing }
PNGActionMessage >> action [
	^ action
]

{ #category : #accessing }
PNGActionMessage >> action: anObject [
	action := anObject
]

{ #category : #accessing }
PNGActionMessage >> decoder [
	^ decoder
]

{ #category : #accessing }
PNGActionMessage >> decoder: aDecoder [
	decoder := aDecoder
]

{ #category : #testing }
PNGActionMessage >> hasData [
	^ decoder hasData 
]

{ #category : #accessing }
PNGActionMessage >> target [
	^target
]

{ #category : #accessing }
PNGActionMessage >> target: anObject [
	target := anObject
]
