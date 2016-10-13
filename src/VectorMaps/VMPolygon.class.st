"
VMPolygon

This class is used to represent a (closed) polygon. polygons have a winding order: clock-wise (CW) or counter-clock-wise (CCW). The vertices are stored as an ordered collection of VMGraphVertex objects.

Take a look at the class-side methods for convinient construction of VMPolygon objects.

 

    Instance Variables
	cw:			<Boolean>
			winding order, true if CW, false otherwise.
	minX/maxX/minY/maxY: 	<Number (e.g. Float)>
			left/right/top/bottom border of the polygon's bounding box
	vertices:		<OrderedCollection of VMGraphVertex objects>
			contains all the vertices of this polygon. the order of the polygons determines the neighborship and order.


"
Class {
	#name : #VMPolygon,
	#superclass : #Object,
	#instVars : [
		'vertices',
		'minX',
		'maxX',
		'minY',
		'maxY',
		'cw'
	],
	#category : #'VectorMaps-kernel'
}

{ #category : #'instance creation' }
VMPolygon class >> fromOrderedPoints: collection [ 
	"returns a new VMPolygon object with the vertices set. vertices must be a collection of points"
	^self new
		fromOrderedPoints: collection;
		applyAutoId;
		yourself

]

{ #category : #'instance creation' }
VMPolygon class >> fromOrderedVertices: collection [ 
	"returns a new VMPolygon object with the vertices set. vertices must be a collection
	of VMGraphVertex objects with the neighbors set accordingly."
	^(self new)
		fromOrderedVertices: collection;
		yourself.

]

{ #category : #'rendering support' }
VMPolygon class >> rendererClass [
	^ VMPolygonRenderer 
]

{ #category : #'instance creation' }
VMPolygon class >> vertices: v [ 
	"returns a new VMPolygon object with the vertices set. vertices must be a collection
	of VMGraphVertex objects with the neighbors set accordingly."
	^self new
		vertices: v;
		yourself

]

{ #category : #'as yet unclassified' }
VMPolygon >> applyAutoId [
	vertices doWithIndex: [ :v :i |
		v id: (i printString).
		v index: i.
	].
]

{ #category : #'rendering support' }
VMPolygon >> asRenderableElement [
	^ self class rendererClass new model: self
]

{ #category : #accessing }
VMPolygon >> bounds [
	^(Rectangle left: minX right: maxX top: minY bottom: maxY).
]

{ #category : #accessing }
VMPolygon >> cw [
	"returns the winding order without re-computing it (unlike testCW)"
	^cw.
]

{ #category : #expanding }
VMPolygon >> expand: size [
	"this method expands the polygon by the provided size. this process is also known as polygon offsetting."
	self subclassResponsibility.
]

{ #category : #initialization }
VMPolygon >> fromOrderedPoints: collection [
	|  newCollection |
	
	newCollection := OrderedCollection new.
	
	collection do: [ :p |
		newCollection add: (VMGraphVertex point: p ).
	].
	
	self fromOrderedVertices: newCollection..
]

{ #category : #expanding }
VMPolygon >> getExpandVectorPrev: prev next: next expand: size [
	"returns the vector which we use to expand from a given point.
			prev		the vector from the previous vertex to the current one
			next		the vector from the current vertex to the next one
			size		how much we expand"
	|	a				"unit vector in which direction we expand from p"
		prevNormal		"normal vector of s"
		cos				"dot product (=cosinus theta) to determine the correction factor when expanding"
	|
	
	a := ((prev normalized) - (next normalized)).
	prevNormal := prev normal.
	
	"check if 'prev' and 'next' are parallel. in that case, our vector 'a' has zero length."
	((a x = 0) and: (a y = 0)) ifTrue: [
		a := prevNormal.
		cos := 1.
	] ifFalse: [
		a := a normalized.
		cos := prevNormal dotProduct: a.
	].
	
	^(a * size / cos) negated.
]

{ #category : #initialization }
VMPolygon >> initialize [
	
	vertices := OrderedCollection new.
	cw := false.
]

{ #category : #test }
VMPolygon >> isPointInside: point [
	"always returns false. the derived classes are expected to compute this whenever doing so makes actually sense (i.e. if it is a closed polygon"
	^false.
]

{ #category : #'as yet unclassified' }
VMPolygon >> lineSegments [
	| collection |
	
	collection := OrderedCollection new.
	
	1 to: (vertices size - 1) do: [ :i |
		collection add: (  VMLineSegment from: (vertices at: i) to: (vertices at: (i+1))  ).
	].

	^collection.
]

{ #category : #test }
VMPolygon >> log: aString [
]

{ #category : #test }
VMPolygon >> logCr: aString [
]

{ #category : #modify }
VMPolygon >> makeCCW [
	"ensures that the polygon's winding is counter-clock-wise"
	self testCW ifTrue: [
		self reverse.
	].
	
	cw := false.

]

{ #category : #modify }
VMPolygon >> makeCW [
	"ensures that the polygon's winding is clock-wise"
	
	self logCr: 'makeCW'.
	self testCW ifFalse: [
		self reverse.
	].
	
	cw := true.
]

{ #category : #private }
VMPolygon >> markVertices [
	"adds this polygon to the list of polygons for each vertex, so that each vertex has a reference to this polygon"
	vertices do: [ :v |
		v polygons add: self.
	].
]

{ #category : #modify }
VMPolygon >> move: pt [
	
	vertices do: [ :v |
		v point: ((v point) + pt)
	].
]

{ #category : #test }
VMPolygon >> pointsInward: vec index: index [
	^false.
]

{ #category : #printing }
VMPolygon >> printString [
	| vertexString |
	
	vertexString := ''.
	
	vertices do: [ :v |
		vertexString := vertexString, '(', (v x)printString, ' / ', (v y)printString, ') '. 
	].
	
	^vertexString.
]

{ #category : #modify }
VMPolygon >> reverse [
	vertices := vertices reversed.
	cw :=  cw not.
]

{ #category : #'as yet unclassified' }
VMPolygon >> setVerticesIds [
	
	vertices doWithIndex: [ :v :i |
		v id: (i asString).
	].
]

{ #category : #test }
VMPolygon >> testCW [
	"always returns false. derived classes are expected to implement this when appropiate"

	^false.

]

{ #category : #accessing }
VMPolygon >> vertices [
	^vertices.
]

{ #category : #initialization }
VMPolygon >> vertices: collection [
	"takes a collection of vertices (VMGraphVertex objects) as parameter and sorts them into
	the ordered collection vertices', so that neighbors are next to each other in the collection."
	
	| first last cur |
	
	first := collection anyOne.
	
	minX := first x.
	maxX := first x.
	minY := first y.
	maxY := first y.
	
	(first neighbors) ifEmpty: [
		Transcript show: 'isolated point'; cr.
		^self.
	].
	
	(first neighbors size) ~= 2 ifTrue: [
		Transcript show: 'wrong number of neighbors: ',(first neighbors size)printString; cr.
		^self.
	].
	
	vertices add: first.
	
	last := first.
	cur := first neighbors anyOne.
	vertices add: cur.
	
	"
	Transcript show: 'minX=', minX printString, ', minY=', minY printString,', maxX=', maxX printString, ', maxY=', maxY printString; cr.
	
	self makeCCW.
	
	Transcript show: 'polygon size=',(vertices size)printString,', cw=',(cw printString); cr.
	"

]
