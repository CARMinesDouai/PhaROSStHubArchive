Class {
	#name : #PhaROSLocalizerEntity,
	#superclass : #Object,
	#instVars : [
		'id',
		'measures',
		'm',
		'adding'
	],
	#category : #'PhaROS-Packages-Localizer'
}

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity class >> for: anId [
	^ self new id: anId; yourself 
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> add: aMeasure [ 

	adding ifTrue: [
		measures add: aMeasure pose position.
		measures size > 1500 ifTrue: [ 
			self compact > 30 ifTrue: [
				adding := false.
			]
		].
		m := m +1.
	].
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> asGeometry_msgsPointCollection [
	| center a b  points |
	center := self center.
	
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

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> center [
	self compact.
	^ measures average. 
	
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> compact [
	| new | 
	new := Set new. 
	
	measures do: [ : measure | 
		new detect: [ : m2 | 
			measure  approximated: m2  threshold: PhaROSLocalizerPackage measureThreshold 
		] ifNone: [new add: measure ].
	].
	measures := new.
	^ new size.
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> fix: aPose [
	
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
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> length [
	^ 1.0
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> position [
	^ self center.
]
