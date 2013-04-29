Class {
	#name : #PhaROSGeometryTransformations,
	#superclass : #Object,
	#category : #'PhaROS-Util'
}

{ #category : #'as yet unclassified' }
PhaROSGeometryTransformations class >> rotationAsQuaternation: anOrientation into: aQuaternationObject [
	| array |
	" anOrientation is the value of the only one kind of rotation that robulab have, in terms of z axis. "

	array := PhaROSGeometryTransformations new quaternationFromEulerFor: 0.0 and: 0.0 and: anOrientation.
	aQuaternationObject x: (array at:1).
	aQuaternationObject y: (array at:2).
	aQuaternationObject z: (array at:3).
	aQuaternationObject w: (array at:4).
]

{ #category : #'as yet unclassified' }
PhaROSGeometryTransformations >> eulerFromMatrix: aRotationMatrix [

	| i j k rotationMatrix cy x y z |

	i := 1. 
	j := 2.
	k := 3.
	
	rotationMatrix  := aRotationMatrix atRows: 1 to: 3 columns: 1 to: 3.
	
	cy := ((rotationMatrix at: i at: i) * (rotationMatrix at: i at: i) ) + ((rotationMatrix at: j at: i) * (rotationMatrix at: j at: i) ).
	cy := cy sqrt.
	
	cy > Float epsilon ifTrue: [
		x := (rotationMatrix at: k at: j) arcTan: (rotationMatrix at: k at: k).
		y := ((rotationMatrix at: k at: i) * -1) arcTan: cy.
		z := (rotationMatrix at: j at: i) arcTan: (rotationMatrix at: i at: i).
	] ifFalse: [
		x := ((rotationMatrix at: j at: k) * -1) arcTan:  (rotationMatrix at: j at: j).
		y := ((rotationMatrix at: k at: i) * -1) arcTan: cy.
		z := 0.0
	].
	
	^ { x . y . z }
]

{ #category : #'as yet unclassified' }
PhaROSGeometryTransformations >> eulerFromQuaternation: aQuaternion [ 
	^ self eulerFromMatrix: (self quaternionMatrixFor: aQuaternion)
]

{ #category : #'as yet unclassified' }
PhaROSGeometryTransformations >> eulerFromQuaternation: x and: y and: z and: w [
	^ self eulerFromQuaternation: { x. y . z .w }
]

{ #category : #'as yet unclassified' }
PhaROSGeometryTransformations >> quaternationFromEuler: anEulerTuple [ 
 | i j k matrix cosins sins cisk cick sisk sick |

"
i versor is related to x 
j versor is related with y
k versor is related with z
"

	i := 1.
	j := 2.
	k := 3.
	
		
	matrix :=anEulerTuple collect: [ :it | it / 2.0].
	cosins := matrix collect: [ :it | it cos ].
	sins := matrix collect: [:it | it sin].
	

     cick := (cosins at: i) * (cosins at:k).
     cisk := (cosins at: i )* (sins at:k).
     sick := (sins at: i )* (cosins at:k).
     sisk := (sins at: i )* (sins at:k).
	
	
	^ 
	{ 
		((cosins at: j) * sick) - ((sins at: j )* cisk)  roundUpTo: 0.001.
		((cosins at: j) * sisk) - ((sins at: j )* cick)  roundUpTo: 0.001.
		((cosins at: j) * cisk) - ((sins at: j )* sick)  roundUpTo: 0.001.
		((cosins at: j) * cick) - ((sins at: j )* sisk)  roundUpTo: 0.001.
	}.
		
	







]

{ #category : #'as yet unclassified' }
PhaROSGeometryTransformations >> quaternationFromEulerFor:anIComponent and: aJComponent and: aKComponent [
	^ self quaternationFromEuler: { anIComponent . aJComponent . aKComponent }
]

{ #category : #'as yet unclassified' }
PhaROSGeometryTransformations >> quaternionMatrixFor: aQuaternion [

 "Return homogeneous rotation matrix from quaternion. "

| vector column  dot | 

	
	vector := Matrix rows:1 columns:4 tabulate: [ :r :c | (aQuaternion at: r+c - 1) asFloat ].
	column :=  Matrix rows:4 columns:1 tabulate: [ :r :c | (aQuaternion at: r+c - 1) asFloat].
	
	
	dot := vector dotProduct: column.
	
	
	dot < Float epsilon ifTrue: [
		^ Matrix identity:4.	
	].
	
	
	vector := vector * (( 2.0 / dot) sqrt ).
	vector := vector outerProduct: vector.
	
vector := {
	" Row 1 "
	(1.0 - (vector at: 2 at:2) - (vector at:3 at:3)) .
	(vector at:1 at:2) - (vector at:3 at:4) . 
	(vector at:1 at:3) + (vector at:2 at:4) .
	0.0 .
	
	" Row 2 "
	(vector at:1 at:2) + (vector at:3 at:4) . 	
	(1.0 - (vector at: 1 at:1) - (vector at:3 at:3)) .
	(vector at:2 at:3) - (vector at:1 at:4) .
	0.0 .
	
	" Row 3 "
	(vector at:1 at:3) - (vector at:2 at:4) .
	(vector at:2 at:3) + (vector at:1 at:4) .
	(1.0 - (vector at: 1 at:1) - (vector at:2 at:2)) .
	0.0 .
	
	"Row 4"
	0.0 .
	0.0 .
	0.0 .
	1.0
}.
	^ Matrix rows: 4 columns: 4 tabulate: [ :r :c | vector at: ((r-1*4)+c)  ]. 

























]
