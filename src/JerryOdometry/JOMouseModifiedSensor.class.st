Class {
	#name : #JOMouseModifiedSensor,
	#superclass : #InputEventSensor,
	#instVars : [
		'block'
	],
	#category : #JerryOdometry
}

{ #category : #'as yet unclassified' }
JOMouseModifiedSensor class >> onMousePositionChange: aBlock [
	self installEventSensorFramework.
	Sensor onMousePositionChange: aBlock.
]

{ #category : #'as yet unclassified' }
JOMouseModifiedSensor >> initialize [ 
	super initialize.
	block := []
]

{ #category : #'as yet unclassified' }
JOMouseModifiedSensor >> mousePositionHasChangedFrom: aPreviousMousePosition [

	[
		block cull: aPreviousMousePosition cull: mousePosition.
	] on: Error do: [].
]

{ #category : #'as yet unclassified' }
JOMouseModifiedSensor >> onMousePositionChange: aBlock [ 
	block := aBlock.
]

{ #category : #'as yet unclassified' }
JOMouseModifiedSensor >> processEvent: evt [ 
	| currentMousePosition return |
	
	currentMousePosition := mousePosition.
	return := super processEvent: evt.
	currentMousePosition = mousePosition ifFalse: [ 
		self mousePositionHasChangedFrom: currentMousePosition.
	].
	^ return.
	
]

{ #category : #'as yet unclassified' }
JOMouseModifiedSensor >> stopit [
	InputEventSensor installEventSensorFramework.
]
