"
VMMap objects store all the relevant data for a single map.


instance variables:
	info <Array (or compatible collection>
		array that holds the map information that is usually found in the vmap text file: num_vertices, num_edges & epsilon
	vertices <OrderedCollection>
		a collection of all vertices of the map
	edges <OrderedCollection>
		a collection of all edges of the map
	polygons <OrderedCollection>
		a collection of all polygons
	lineSegments <OrderedCollection>
		a collection of all line segments
	bounds <Rectangle>
		bounds of the map
	epsilon <Number (typically Float)>
		unused
	origin <VMGraphVertex>
		the map origin. the vertex always is on traversable space
	visGraph <VMVisGraph>
		the visibility graph for this map
"
Class {
	#name : #VMMap,
	#superclass : #Object,
	#instVars : [
		'polygons',
		'bounds',
		'origin',
		'visGraph'
	],
	#category : #'VectorMaps-kernel'
}

{ #category : #'rendering support' }
VMMap class >> rendererClass [
	^ VMMapRenderer 
]

{ #category : #'rendering support' }
VMMap >> asRenderableElement [
	^ self class rendererClass new model: self
]

{ #category : #accessing }
VMMap >> bounds [
	^ bounds
]

{ #category : #accessing }
VMMap >> bounds: aRectangle [
	bounds := aRectangle
]

{ #category : #computing }
VMMap >> computeBounds [
	
	"computes the map boundaries and stores the reult in 'bounds'."
	
	| newBounds |
	
	"check if we have any vertices at all. if no, then we have to exit here. in that case we set the bounds to zero"
	(polygons size) < 1
		ifTrue: [
			"bounds := Rectangle origin: (0@0) corner: (0@0)."
			bounds := nil.
			 ^self.
		].
	
	"initialize the bounds with the first polygon. we don't create a copy because the merge function below will always create a new rectangle"
	newBounds := polygons first bounds.
	
	"merge with all bounds to receive the bounds over all polygons"
	polygons do: [ :p |
		newBounds merge: p bounds.
	].
	
	bounds := newBounds.
]

{ #category : #computing }
VMMap >> computeVisGraph [
	visGraph := VMVisGraph fromMap: self.
]

{ #category : #computing }
VMMap >> expand: size [
	| newMap newPolygons |
	
	newMap := VMMap new.
	newPolygons := OrderedCollection new.
	
	polygons do: [ :p |
		newPolygons add: (p expand: size).
	].
	
	^newMap
		polygons: newPolygons;
		computeBounds;
		yourself.
]

{ #category : #initialize }
VMMap >> initialize [
	super initialize.
	
	polygons := OrderedCollection new.
	bounds := nil.
	visGraph := nil.
	origin := 0@0.

]

{ #category : #'as yet unclassified' }
VMMap >> lineSegments [
	| lineSegCollection |
	
	lineSegCollection := OrderedCollection new.
	
	polygons do: [ :p |
		lineSegCollection addAll: p lineSegments.
	].

	^lineSegCollection.
]

{ #category : #accessing }
VMMap >> origin [
	^ origin
]

{ #category : #accessing }
VMMap >> origin: aPoint [
	origin := aPoint
]

{ #category : #accessing }
VMMap >> polygons [
	^ polygons
]

{ #category : #accessing }
VMMap >> polygons: polygonCollection [
	polygons := polygonCollection asOrderedCollection.
]

{ #category : #computing }
VMMap >> setPolygonsWindingOrder [
	"sets the winding order of all polygons in 'polygons' according to the position of 'origin'."
	
	polygons do: [ :p |
		(p isPointInside: origin) ifTrue: [
			p makeCW.
		] ifFalse: [
			p makeCCW.
		].
	].
]

{ #category : #computing }
VMMap >> sortPolygons [
	"sorts the OrderedCollection 'polygons', so that all polygons with ccw winding order appear first (i.e. have a
	lower index than the rest). Polygons with a ccw winding order are passable inside and obstacles/unkown on
	the outside."
	| left right temp |
	
	left := 1.
	right := polygons size.
	
	[left < right] whileTrue: [
		(polygons at: left) cw ifTrue: [
			"this case means that the current element at 'left' has the correct order: cw"
			left := left + 1.
		] ifFalse: [
			"this case means that the current element at 'left' has a ccw order, and we are looking for an element with cw order to switch with"
			(polygons at: right) cw ifTrue: [
				"swap the two entries"
				temp := polygons at: left.
				polygons at: left put: (polygons at: right).
				polygons at: right put: temp.
				left := left + 1.
				right := right - 1.
			] ifFalse: [
				right:= right - 1.
			].
		].
	].
]

{ #category : #accessing }
VMMap >> visGraph [
	^ visGraph
]

{ #category : #accessing }
VMMap >> visGraph: graph [
	visGraph := graph
]
