Class {
	#name : #PhaROSLocalizerEntity,
	#superclass : #Object,
	#instVars : [
		'id',
		'measures',
		'm',
		'adding'
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
		(measures size = 0 or: [ (self center - aMeasure pose position ) module2d < 1.0 ] ) ifTrue: [
			measures add: aMeasure pose position.
			self compact > 20 ifTrue: [
				adding := false.
			].
			m := m +1.
		] ifFalse: [ Transcript show: 'Rejecting measure'; show: aMeasure ;cr ].
	].
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> adding: aBoolean [
	adding := aBoolean 
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
PhaROSLocalizerEntity >> complete [ 
	^ adding not.
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> fix: aPose [
	
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
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> length [
	^ 1.0
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> measures: aMeasureset [
	measures := aMeasureset asSet
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerEntity >> position [
	^ self center.
]
