Class {
	#name : #VMPointRenderer,
	#superclass : #VMElementRenderer,
	#instVars : [
		'radius'
	],
	#category : #'VectorMaps-GUI-Athens'
}

{ #category : #accessing }
VMPointRenderer >> centerPoint [
	"model is expected to be a point-like object, having 'x' and 'y' methods that return the coordinates of the object"
	^ self model.
	
]

{ #category : #initialization }
VMPointRenderer >> initialize [
	super initialize.
	radius := 0.3.
	lineWidth := 0.1
]

{ #category : #accessing }
VMPointRenderer >> labelPosition [
	^self centerPoint.
]

{ #category : #accessing }
VMPointRenderer >> radius [
	^ radius
]

{ #category : #accessing }
VMPointRenderer >> radius: anObject [
	radius := anObject
]

{ #category : #rendering }
VMPointRenderer >> renderOn: canvas [
		
	| top bottom path stroke |
		
	top := self centerPoint + (self radius@0).
	bottom := self centerPoint - (self radius@0).
	
	path := canvas createPath: [ :builder |
		builder 
			absolute; 
			moveTo: top;
			cwArcTo: bottom angle: Float pi;
			cwArcTo: top angle: Float pi.
	].

	stroke := canvas setStrokePaint: self color.
	stroke width: self lineWidth.
	canvas drawShape: path.
	
	super renderOn: canvas
]
