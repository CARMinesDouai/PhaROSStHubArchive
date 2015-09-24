Class {
	#name : #RrContourVectorDisplay,
	#superclass : #RrVectorDisplay,
	#category : #'ReactiveRobot-00-SensorViewer'
}

{ #category : #drawing }
RrContourVectorDisplay >> drawVectorFrom: center to: extremite  width: width color: aColor [
	self drawOvalFrom: extremite - width to: extremite + width color: aColor borderWidth: 0 borderColor: aColor
]
