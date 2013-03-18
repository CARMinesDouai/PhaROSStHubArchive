Class {
	#name : #PhaROSMapCircularAccessor,
	#superclass : #Object,
	#instVars : [
		'map',
		'pointMapper'
	],
	#category : #'PhaROS-MapMatcher'
}

{ #category : #'as yet unclassified' }
PhaROSMapCircularAccessor class >> for: aMap and: aPointMapper [
	self new map: aMap ; pointMapper: aPointMapper; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSMapCircularAccessor >> map: aMap [
	map := aMap.
]

{ #category : #'as yet unclassified' }
PhaROSMapCircularAccessor >> pointAt: anAngle [
	^ pointMapper pointAt: anAngle.
]

{ #category : #'as yet unclassified' }
PhaROSMapCircularAccessor >> pointMapper: aPointMapper [
	pointMapper := aPointMapper
]

{ #category : #'as yet unclassified' }
PhaROSMapCircularAccessor >> valueAt: anAngle [

	^ map at: (self pointAt: anAngle).
]
