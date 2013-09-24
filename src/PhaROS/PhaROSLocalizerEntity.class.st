Class {
	#name : #PhaROSLocalizerEntity,
	#superclass : #Object,
	#instVars : [
		'id',
		'measures',
		'm',
		'adding',
		'annotations'
	],
	#category : #'PhaROS-Nodelets-Localizer'
}

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity class >> for: anId [
	^ self new id: anId; yourself 
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> add: aMeasure [ 

	
	adding ifTrue: [
		measures add: aMeasure pose. 
		measures removeAll: (measures select: [ : msr | (self center position - msr pose position) module2d > 0.3 ]).
		self compact > 20 ifTrue: [
			adding := false.
		].
		m := m +1.
		
	].
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> adding: aBoolean [
	adding := aBoolean 
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> annotate: aSymbol with: aValue [
	^ annotations at: aSymbol put: aValue.
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> annotation: aSymbol [
	^ annotations at: aSymbol ifAbsent: [ nil ].
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> asDump [
	| ms | 
	ms := (measures inject:'{' into: [ :acc : mr | acc, mr asDump , '.']), '}'.
	^ 'PhaROSLocalizerEntity new id: {1}; measures: {2}; adding: {3};yourself' format: { id asString . ms . adding asString  }.
	
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> asGeometry_msgsPointCollection [
	| center a b  points |
	center := self center position.
	
	a := (PhaROSPosition x: center x - (self length / 2) y: center y - (self length / 2) z: 0.0 ).
	b := (PhaROSPosition x: center x + (self length / 2) y: center y + (self length / 2) z: 0.0).

	points := OrderedCollection new.
	
	a x to: b x by: 0.05 do: [ : x  | 
		a y to: b y by: 0.05 do: [ : y  | 
			points add: (Geometry_msgsPoint new x: x ; y: y; z: (center z * -1)).
		]
	].

	^ points.
]

{ #category : #converting }
PhaROSLocalizerEntity >> asPose [
	^self center 
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> asTransform [ 
	^ self asPose asTransform.
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> asTransformStampedRelativeTo: aFrameParentID [

	| transformStamped | 
	
		transformStamped := Geometry_msgsTransformStamped new.
		
		transformStamped child_frame_id:  self frameName.
		transformStamped header frame_id:  aFrameParentID.
		transformStamped transform: self asTransform.
		
	^ transformStamped.
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> center [
	| point angle |
	self compact.
	point := (measures collect: #position) average .
	point z: 0.0.
	angle := (measures collect: [ :p | p orientation as2DOrientation z]) average.
	point := point asPose.
	point orientation: (PhaROS2DOrientation z: angle).
	^ point. 
	
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> compact [
	| new | 
	new := Set new. 
	
	measures do: [ : measure | 
		new detect: [ : m2 | 
			measure position approximated: m2 position  threshold: PhaROSLocalizerNodelet measureThreshold 
		] ifNone: [new add: measure ].
	].
	measures := new.
	^ new size.
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> complete [ 
	^ adding not.
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> extraInfo: anObject [
	extraInfo := anObject.

]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> fix: aPose [
	
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> frameName [
	^ '/landmark/', id asString
]

{ #category : #accessing }
PhaROSLocalizerEntity >> id [
	^ id
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> id: anId [ 	
	id := anId 
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> initialize [ 
	measures := Set new.
	m := 0.
	adding := true.
	annotations := Dictionary new.
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> length [
	^ 1.0
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> locate: aPose [
	^ self center asPose + aPose.
]

{ #category : #converting }
PhaROSLocalizerEntity >> match: aPose [
	^ adding not and: [ (self center position - aPose position ) module2d  <  0.1 ].
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> measures: aMeasureset [
	measures := aMeasureset asSet
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> position [
	^ self center.
]
