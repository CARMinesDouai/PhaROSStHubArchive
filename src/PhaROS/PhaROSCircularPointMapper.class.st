Class {
	#name : #PhaROSCircularPointMapper,
	#superclass : #Object,
	#instVars : [
		'center',
		'radius'
	],
	#category : #'PhaROS-MapMatcher'
}

{ #category : #'as yet unclassified' }
PhaROSCircularPointMapper class >> withCenterIn: aPoint andRadius: aRadius [

	^ self new center: aPoint; radius: aRadius ; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSCircularPointMapper >> center: aCenter [
	center := aCenter.
]

{ #category : #'as yet unclassified' }
PhaROSCircularPointMapper >> pointAt: anAngleInRadians [ 
	^ center x + (radius * anAngleInRadians cos) asInteger  @ center y + (radius * anAngleInRadians cos) asInteger.
]

{ #category : #'as yet unclassified' }
PhaROSCircularPointMapper >> radius: aRadius [ 
	radius := aRadius.
]
