Class {
	#name : #PNGInterval,
	#superclass : #Object,
	#instVars : [
		'max',
		'min'
	],
	#category : #'PureNG-ServiceData'
}

{ #category : #'as yet unclassified' }
PNGInterval >> max [
	^ max.
]

{ #category : #'as yet unclassified' }
PNGInterval >> max: aMax [
	max := aMax.
]

{ #category : #'as yet unclassified' }
PNGInterval >> min [ 
	^ min
]

{ #category : #'as yet unclassified' }
PNGInterval >> min: aMin [
	min := aMin.
]

{ #category : #'as yet unclassified' }
PNGInterval >> printOn: aStream [
	aStream nextPutAll: '[', self min asString, ';', self max asString, ']'.
]
