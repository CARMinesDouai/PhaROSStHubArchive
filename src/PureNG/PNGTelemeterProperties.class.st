Class {
	#name : #PNGTelemeterProperties,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'orientation',
		'fieldOfView',
		'minimumDistance',
		'maximumDistance'
	],
	#category : #'PureNG-ServiceData'
}

{ #category : #accessing }
PNGTelemeterProperties >> fieldOfView [
	^ fieldOfView
]

{ #category : #accessing }
PNGTelemeterProperties >> fieldOfView: anObject [
	fieldOfView := anObject
]

{ #category : #accessing }
PNGTelemeterProperties >> maximumDistance [
	^ maximumDistance
]

{ #category : #accessing }
PNGTelemeterProperties >> maximumDistance: anObject [
	maximumDistance := anObject
]

{ #category : #accessing }
PNGTelemeterProperties >> minimumDistance [
	^ minimumDistance
]

{ #category : #accessing }
PNGTelemeterProperties >> minimumDistance: anObject [
	minimumDistance := anObject
]

{ #category : #accessing }
PNGTelemeterProperties >> orientation [
	^ orientation
]

{ #category : #accessing }
PNGTelemeterProperties >> orientation: anObject [
	orientation := anObject
]

{ #category : #accessing }
PNGTelemeterProperties >> x [
	^ x
]

{ #category : #accessing }
PNGTelemeterProperties >> x: anObject [
	x := anObject
]

{ #category : #accessing }
PNGTelemeterProperties >> y [
	^ y
]

{ #category : #accessing }
PNGTelemeterProperties >> y: anObject [
	y := anObject
]
