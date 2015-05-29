Class {
	#name : #RrVectorDisplay,
	#superclass : #MaDrawingArea,
	#instVars : [
		'backgroundColor',
		'layers',
		'lineColor',
		'lineWidth',
		'zoomFactor',
		'label'
	],
	#category : #'ReactiveRobot-Display'
}

{ #category : #'instance creation' }
RrVectorDisplay class >> labelled: aString [
	^self new
		label: aString;
		yourself
]

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

{ #category : #'initialize-release' }
RrVectorDisplay >> defaultExtent [
	^400@400
]

{ #category : #'initialize-release' }
RrVectorDisplay >> defaultName [
	^'Vectors'
]

{ #category : #drawing }
RrVectorDisplay >> draw: aVector [
	| extremite center correctedVector vectorPoint correctedAngle |
	center := self extent // 2.
	correctedAngle := aVector angle + VeAngle halfPi.
	correctedVector := VeVector
		length: aVector length * self zoomFactor
		angle: correctedAngle.
	vectorPoint := correctedVector asPoint.
	extremite := (center x + vectorPoint x) @ (center y - vectorPoint y).
	self 
		drawVectorFrom: center to: extremite  width: self lineWidth color: self lineColor.

]

{ #category : #drawing }
RrVectorDisplay >> drawVectorFrom: center to: extremite  width: width color: aColor [
	self 
		drawLineFrom: center to: extremite  width: width color: aColor

]

{ #category : #drawing }
RrVectorDisplay >> erase [
	self fillWith: self backgroundColor
]

{ #category : #'initialize-release' }
RrVectorDisplay >> initialize [
	super initialize.
	self label: self defaultName.
	self extent: self defaultExtent.
	self backgroundColor: self defaultBackgroundColor.
	self erase
]

{ #category : #accessing }
RrVectorDisplay >> label [
	^ label
]

{ #category : #accessing }
RrVectorDisplay >> label: anObject [
	label := anObject
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
RrVectorDisplay >> name [
	^self label
]

{ #category : #accessing }
RrVectorDisplay >> zoomFactor [
	^ zoomFactor
]

{ #category : #accessing }
RrVectorDisplay >> zoomFactor: anObject [
	zoomFactor := anObject
]
