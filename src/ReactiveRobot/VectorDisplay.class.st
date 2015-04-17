Class {
	#name : #VectorDisplay,
	#superclass : #MaDrawingArea,
	#instVars : [
		'color',
		'speedVector',
		'obstacleVector'
	],
	#category : #'ReactiveRobot-Demo'
}

{ #category : #drawing }
VectorDisplay >> draw [
	self fillWith: Color white.
	self draw: speedVector withColor: Color blue.
	self draw: obstacleVector withColor: Color red.
]

{ #category : #drawing }
VectorDisplay >> draw: aVector withColor: aColor [
	| extremite center correctedVector vectorPoint correctedAngle |
	center := self extent // 2.
	correctedAngle := aVector angle .
	correctedVector := RrVector
		length: aVector length * 1000
		angle: correctedAngle.
	vectorPoint := correctedVector asPoint.
	extremite := (center x + vectorPoint x) @ (center y - vectorPoint y).
	self 
		drawLineFrom: center to: extremite  width: 3 color: aColor.

]

{ #category : #drawing }
VectorDisplay >> drawObstacle: aVector [
	obstacleVector := aVector.
	self draw
]

{ #category : #drawing }
VectorDisplay >> drawSpeed: aVector [
	speedVector  := aVector.
	self draw
]

{ #category : #initialization }
VectorDisplay >> initialize [
	super initialize.
	speedVector := RrVector zero.
	obstacleVector := RrVector zero
]
