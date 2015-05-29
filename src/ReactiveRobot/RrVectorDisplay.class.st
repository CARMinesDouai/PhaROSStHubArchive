Class {
	#name : #RrVectorDisplay,
	#superclass : #MaDrawingArea,
	#instVars : [
		'backgroundColor',
		'layers',
		'lineColor',
		'lineWidth',
		'zoomFactor'
	],
	#category : #'ReactiveRobot-Demo'
}

{ #category : #accessing }
RrVectorDisplay >> backgroundColor [
	^ backgroundColor
]

{ #category : #'initialize-release' }
RrVectorDisplay >> backgroundColor: aColor [
	backgroundColor := aColor
]

{ #category : #'initialize-release' }
RrVectorDisplay >> defaultBackgroundColor [
	^Color white
]

{ #category : #drawing }
RrVectorDisplay >> draw: aVector [
	| extremite center correctedVector vectorPoint correctedAngle |
	center := self extent // 2.
	correctedAngle := aVector angle .
	correctedVector := VeVector
		length: aVector length * self zoomFactor
		angle: correctedAngle.
	vectorPoint := correctedVector asPoint.
	extremite := (center x + vectorPoint x) @ (center y - vectorPoint y).
	self 
		drawLineFrom: center to: extremite  width: self lineWidth color: self lineColor.

]

{ #category : #drawing }
RrVectorDisplay >> erase [
	self fillWith: self backgroundColor
]

{ #category : #'initialize-release' }
RrVectorDisplay >> initialize [
	super initialize.
	self backgroundColor: self defaultBackgroundColor.
	self erase
]

{ #category : #accessing }
RrVectorDisplay >> lineColor [
	^ lineColor
]

{ #category : #accessing }
RrVectorDisplay >> lineColor: anObject [
	lineColor := anObject
]

{ #category : #accessing }
RrVectorDisplay >> lineWidth [
	^ lineWidth
]

{ #category : #accessing }
RrVectorDisplay >> lineWidth: anObject [
	lineWidth := anObject
]

{ #category : #accessing }
RrVectorDisplay >> zoomFactor [
	^ zoomFactor
]

{ #category : #accessing }
RrVectorDisplay >> zoomFactor: anObject [
	zoomFactor := anObject
]
