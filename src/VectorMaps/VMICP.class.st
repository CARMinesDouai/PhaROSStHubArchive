"
This class performs the Iteratice Closest Point (ICP) algorithm.


Public API and Key Messages

- alignPointCloud: <inputA> with: <inputB>
	this method performs the full ICP algorithm. both inputs are expected to be collections of points.
	the result (stored as 'outputA') is the transformed collection inputA. the collection inputB remains
	static. both input collections are not modified - the result is stored in a new collection.

the remaining methods are used for debugging and manually stepping through the iterative steps of the algorithm.


"
Class {
	#name : #VMICP,
	#superclass : #Object,
	#instVars : [
		'inputA',
		'inputB',
		'quadtree',
		'outputA',
		'matchCollection',
		'svd',
		'stepMatR',
		'stepVecT',
		'matR',
		'vecT'
	],
	#category : #'VectorMaps-SLAM - ICP'
}

{ #category : #'as yet unclassified' }
VMICP class >> rendererClass [
	^VMICPRenderer.
]

{ #category : #'public - aligning' }
VMICP >> alignPointCollection: collectionA with: collectionB [
	"alligns collectionA with collectionB. collectionB. both collections remain unchanged and a new collection based on the transformed collectionA is returned"
	
	quadtree := (VMQuadTreeNode size: 1@1 center: 0@0)
		addAll: collectionB;
		root.
	
	matR := VMMatrix2D identity.
	vecT := (DhbVector new: 2) at: 1 put: 0.0; at: 2 put: 0.
	inputA := collectionA.
	inputB := collectionB.
	outputA := inputA.
	
	"self computeMatchCollection: collectionA withNNCollection: quadtree.
	self computeTransform: matchCollection.
	self applyTransformTo: inputA.
	"
	"
	self iterateOnce.
	self iterateOnce.
	self iterateOnce.
	"
	Transcript show: 'alignPointCollection - done'; cr.

]

{ #category : #'public - aligning' }
VMICP >> alignPointCollection: collectionA withNNCollection: nnCollection [
	"alligns collectionA with collectionB. collectionB. both collections remain unchanged and a new collection based on the transformed collectionA is returned"
	
	quadtree := nnCollection.
	
	inputA := collectionA.
	inputB := nnCollection.
	outputA := inputA.
	
	self iterate.

]

{ #category : #transforming }
VMICP >> applyStepTransformTo: dataCollection [
	"applys the transformation to the provided collection and stores the result in 'outputA'. the original collection is not modified."
	outputA := dataCollection collect: [ :p |
		| vec |
		
		vec := DhbVector new: 2.
		vec at: 1 put: p x.
		vec at: 2 put: p y.
		vec := stepMatR * vec.
		
		Point
			x: ( (vec at: 1) + (stepVecT at: 1) )
			y: ( (vec at: 2) + (stepVecT at: 2) ).
	].
	
]

{ #category : #converting }
VMICP >> asRenderableElement [
	^ self class rendererClass new model: self
]

{ #category : #computing }
VMICP >> computeCentroid: collection [
	"computes the center of mass (average position over all points)"
	| point count |
	
	point := 0@0.
	count := 0.
	
	collection do: [ :obj |
		point := point + obj.
		count := count + 1.
	].
	
	(count = 0) ifTrue: [ ^point ].
	
	^ ((point x) / count) @ ((point y) / count).

]

{ #category : #computing }
VMICP >> computeError [
	"the stored match collection from the last iteration step contains the matches from before we
	transformed and updated outputA. therefore we have to compute the current match collection
	first."
	self computeMatchCollection: outputA withNNCollection: quadtree.
	^matchCollection squaredError.
]

{ #category : #'privat - matching' }
VMICP >> computeMatchCollection: sourceCollection withNNCollection: nnCollection [
	matchCollection := VMMatchCollection new.
	
	sourceCollection do: [ :point |
		matchCollection
			add: (VMMatchPair
				pointA: point
				pointB: (self findCorrespondingPoint: point inNNCollection: nnCollection)
			).
	].
	
	^matchCollection.


]

{ #category : #computing }
VMICP >> computeStepTransform: aMatchCollection [
	"the resulting transform is stored in the members 'matR' (rotation) and 'vecT' (translation)."
	| a b c d matH centA centB vecA vecB |
	
	centA := self computeCentroid: (aMatchCollection collect: [ :pair | pair first ] ).
	centB := self computeCentroid: (aMatchCollection collect: [ :pair | pair last ] ).
	
	a := 0.0.
	b := 0.0.
	c := 0.0.
	d := 0.0.
	
	aMatchCollection do: [ :obj |
		| vA vB |
		vA := obj first - centA.
		vB := obj last - centB.
		
		a := a + ( vA x * (vB x) ).
		b := b + ( vA x * (vB y) ).
		c := c + ( vA y * (vB x) ).
		d := d + ( vA y * (vB y) ).
	].
	
	matH := DhbMatrix rows: { { a. b. }. { c. d. } }.
	
	svd := VMSVD matrix: (matH transpose).
	stepMatR := (svd v) * (svd u) transpose.
	"Transcript
		show: 'v='; cr; show: svd v; cr;
		show: 'u='; cr; show: svd u; cr;
		show: 'R='; cr; show: matR; cr.
	"
	((stepMatR at: 1 at: 1) sign ~= (stepMatR at: 2 at: 2) sign) ifTrue: [
		stepMatR at: 2 at: 1 put: ((stepMatR at: 2 at: 1) negated).
		stepMatR at: 2 at: 2 put: ((stepMatR at: 2 at: 2) negated).
	].
	
	vecA := DhbVector new: 2.
	vecB := DhbVector new: 2.
	
	vecA at: 1 put: (centA x).
	vecA at: 2 put: (centA y).
	vecB at: 1 put: (centB x).
	vecB at: 2 put: (centB y).
	
	stepVecT := -1 * (stepMatR * vecA) + vecB.
	"vecT := stepMatR * -1.0 * vecA + vecB."

]

{ #category : #'privat - matching' }
VMICP >> findCorrespondingPoint: point inNNCollection: collection [
	"NNCollection is a collection that allows us to find the nearest neighbor for a given point"
	^(collection findNearest: point)
		result.
]

{ #category : #accessing }
VMICP >> inputA [
	^inputA.
]

{ #category : #accessing }
VMICP >> inputA: aCollection [
	inputA := aCollection.
]

{ #category : #accessing }
VMICP >> inputB [
	^inputB.
]

{ #category : #accessing }
VMICP >> inputB: aCollection [
	inputB := aCollection.
]

{ #category : #computing }
VMICP >> iterate [
	| counter error maxIterCount |
	
	maxIterCount := 10.
	counter := 0.
	
	[ counter < maxIterCount ] whileTrue: [
		counter := counter + 1.
		self iterateOnce.
		error := self computeError.
		Transcript show: 'ICP iteration #', counter printString, ', error=', error printString; cr.
		
		"todo: add abort conditions
			- error too small / improvment too small
			- oscillation
			- same matching as previous iteration (will result in identity transformation)
		"
	].
]

{ #category : #computing }
VMICP >> iterateOnce [
	
	self computeMatchCollection: outputA withNNCollection: quadtree.
	self computeStepTransform: matchCollection.
	self applyStepTransformTo: outputA.
	

]

{ #category : #accessing }
VMICP >> matR [
	^matR.
]

{ #category : #accessing }
VMICP >> matR: aDhbMatrix [
	matR := aDhbMatrix.
]

{ #category : #accessing }
VMICP >> matchCollection [
	^matchCollection.
]

{ #category : #accessing }
VMICP >> matchCollection: aMatchCollection [
	matchCollection := aMatchCollection asMatchCollection.
]

{ #category : #accessing }
VMICP >> outputA [
	^outputA.
]

{ #category : #accessing }
VMICP >> outputA: aCollection [
	outputA := aCollection.
]

{ #category : #accessing }
VMICP >> quadtree [
	^quadtree.
]

{ #category : #accessing }
VMICP >> stepMatR [
	^stepMatR.
]

{ #category : #accessing }
VMICP >> stepMatR: aMatrix [
	stepMatR := aMatrix.
]

{ #category : #accessing }
VMICP >> stepVecT [
	^stepVecT.
]

{ #category : #accessing }
VMICP >> stepVecT: aVector [
	stepVecT := aVector.
]

{ #category : #accessing }
VMICP >> svd [
	^svd
]

{ #category : #accessing }
VMICP >> vecT [
	^vecT.
]

{ #category : #accessing }
VMICP >> vecT: aDhbVector [
	vecT := aDhbVector.
]
