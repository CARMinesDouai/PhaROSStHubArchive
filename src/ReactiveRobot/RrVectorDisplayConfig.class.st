Class {
	#name : #RrVectorDisplayConfig,
	#superclass : #Object,
	#instVars : [
		'color',
		'lineWidth',
		'zoomFactor'
	],
	#classVars : [
		'DefaultColors'
	],
	#category : #'ReactiveRobot-00-SensorViewer'
}

{ #category : #initializing }
RrVectorDisplayConfig class >> initDefaultColor [
	| defaultColorsSelectors |
	DefaultColors := Set new.
	defaultColorsSelectors := Color registeredColorNames reject: [ : colorName | {'very'. 'pale'. 'light'. 'brick'} anySatisfy: [: prefix |colorName beginsWith: prefix]].
	defaultColorsSelectors do: [ : selector | 
		DefaultColors add: (Color perform: selector asSymbol).
	].
]

{ #category : #initializing }
RrVectorDisplayConfig class >> initialize [
	self initDefaultColor
]

{ #category : #accessing }
RrVectorDisplayConfig >> color [
	^ color
]

{ #category : #accessing }
RrVectorDisplayConfig >> color: anObject [
	color := anObject
]

{ #category : #'initialize-release' }
RrVectorDisplayConfig >> defaultColor [
	^DefaultColors atRandom
]

{ #category : #'initialize-release' }
RrVectorDisplayConfig >> defaultLineWidth [
	^3
]

{ #category : #'initialize-release' }
RrVectorDisplayConfig >> defaultZoomFactor [
	^100
]

{ #category : #'initialize-release' }
RrVectorDisplayConfig >> initialize [
	super initialize.
	self color: self defaultColor.
	self zoomFactor: self defaultZoomFactor.
	self lineWidth: self defaultLineWidth.
]

{ #category : #accessing }
RrVectorDisplayConfig >> lineWidth [
	^ lineWidth
]

{ #category : #accessing }
RrVectorDisplayConfig >> lineWidth: anObject [
	lineWidth := anObject
]

{ #category : #acting }
RrVectorDisplayConfig >> setUp: display [
	display
		lineColor: self color;
		lineWidth: self lineWidth;
		zoomFactor: self zoomFactor
]

{ #category : #accessing }
RrVectorDisplayConfig >> zoomFactor [
	^ zoomFactor
]

{ #category : #accessing }
RrVectorDisplayConfig >> zoomFactor: anObject [
	zoomFactor := anObject
]
