"
This class represents a polygon that is constructed  with VMLineSegment instances.


== Public API and Key Messages ==

= <aVMPolygon>
	returns true if all line segments of both polygons are identical (in start/end points' coordinates and types)

isSimilarTo:  <aVMPolygon>
	returns true if all line segments of both polygons are similar. line segments are similar, if their type is identical
	and their start/end points are identical or very close in terms of euclidean distance.

fromPoints: <aCollectionOfPoints>
	creates line segments from the provided collection of points. requires the polygon to be empty.

fromPoints: <aCollectionOfPoints> withTypes <aCollection>
	same as #fromPoints: but also sets the line segment types to the values in 'aCollection'. the types can be
	integers or instances of VMLineSegmentType

ifConvexDo: <aBlock> otherwiseDo: <otherBlock>
	if the polygon is convex, aBlock will be executed. otherwise otherBlock will be executed.
	keep in mind, that a polygon also needs to be orientated clockwise (CW) in order to be convex.
	
isCW
	returns if the polygon is oriented clockwise, false otherwise.

nextLineSeg: <aLineSeg>
	returns the line segment that is connected with ""aLineSeg pointB""

prevLineSeg: <aLineSeg>
	returns the line segment that is connected with ""aLineSeg pointA""



"
Class {
	#name : #VMPolygon,
	#superclass : #OrderedCollection,
	#category : #'VectorMaps-Data Structures: Polygons'
}

{ #category : #'rendering support' }
VMPolygon class >> rendererClass [
	^VMPolygonRenderer
]

{ #category : #comparing }
VMPolygon >> = aPolygon [
	| p |
	p := aPolygon asVMPolygon.
	self size = p size ifFalse: [ ^false ].
	
	"find a line segment with identical start and end point in both polygons"
	p doWithIndex: [ :lineSeg :index2 |
		"Transcript show: 'testing lineSeg=', self first printString, ' with lineSeg=', lineSeg printString; cr."
		(self first = lineSeg) ifTrue: [
			"check if all other line segments are identical too"
			
			1 to: self size-1 do: [ :i |
				(self atWrap: i+1) = (p atWrap: i+index2) ifFalse: [ ^false ].
			].
			^true
		].
	].
	
	^false

]

{ #category : #accessing }
VMPolygon >> area [
	^self signedArea abs
]

{ #category : #converting }
VMPolygon >> asRenderableElement [
	^ self class rendererClass new model: self
]

{ #category : #converting }
VMPolygon >> asVMPolygon [
	^self
]

{ #category : #accessing }
VMPolygon >> bounds [
	| rectangle |
	self ifEmpty: [ ^nil ].
	
	rectangle := Rectangle point: self first pointA point: self first pointB.
	
	self allButFirstDo: [ :lineSeg |
		rectangle := rectangle encompass: lineSeg pointA.
		rectangle := rectangle encompass: lineSeg pointB.
	].
	
	^rectangle

]

{ #category : #'as yet unclassified' }
VMPolygon >> centroid [
	"computes the centroid of the polygon"
	"see: https://en.wikipedia.org/wiki/Centroid#Centroid_of_a_polygon"
	| cx cy sumX sumY area |
	
	area := self signedArea.
	
	sumX := 0.
	self do: [ :lineSeg |
		sumX := sumX + (
			(lineSeg pointA x + lineSeg pointB x) *
			(lineSeg pointA x * lineSeg pointB y - (lineSeg pointB x * lineSeg pointA y))
		).
	].
	cx := sumX / (6 * area).
	
	sumY := 0.
	self do: [ :lineSeg |
		sumY := sumY + (
			(lineSeg pointA y + lineSeg pointB y) *
			(lineSeg pointA x * lineSeg pointB y - (lineSeg pointB x * lineSeg pointA y))
		).
	].
	cy := sumY / (6 * area).
	
	^ cx @ cy
	

]

{ #category : #testing }
VMPolygon >> containsDuplicates [
	| set |
	
	set := Set new.
	
	self do: [ :vector |
		(set includes: vector) ifTrue: [ ^true ].
		set add: vector.
	].
	
	^false

]

{ #category : #construction }
VMPolygon >> fromPoints: aCollectionOfPoints [
	
	"must be initially empty"
	self assert: self isEmpty.
	
	aCollectionOfPoints doWithIndex: [ :point :index |
		self add: (
			VMLineSegment
				pointA: point
				pointB: (aCollectionOfPoints atWrap: index+1)
		)
	].
]

{ #category : #construction }
VMPolygon >> fromPoints: aCollectionOfPoints withTypes: aCollectionOfTypes [
	"note: the types in aCollectionOfTypes can be VMLineType instances or the corresponding integers"
	self assert: self isEmpty.
	
	aCollectionOfPoints doWithIndex: [ :point :index |
		self add: (
			VMLineSegment
				pointA: point
				pointB: (aCollectionOfPoints atWrap: index+1)
				type: (aCollectionOfTypes at: index)
		)
	].
]

{ #category : #'GT Inspector' }
VMPolygon >> gtInspectorRenderedIn: composite [
	<gtInspectorPresentationOrder: 50>
	composite inspectOnce.
	(composite morph)
		title: 'Viewer';
		morph: [
			(VMViewer openWindowlessOn: { self asRenderableElement })
				autozoom.
		].
		
]

{ #category : #comparing }
VMPolygon >> hash [
	"note: we only use pointA of each line segment to compute the hash, because in a closed
	polygon there is always an identical pointB, which if XORed into the hash will cancel 
	each other out"
	| hashValue |
	
	hashValue := 0.
	self do: [ :lineSeg |
		hashValue := hashValue bitXor: lineSeg pointA hash.
	].
	
	^hashValue

]

{ #category : #testing }
VMPolygon >> ifConvexDo: aBlock otherwiseDo: otherBlock [

	self doWithIndex: [ :lineSeg :index |
		lineSeg asVMLine fuzzyPoint: (self atWrap: index +1) pointB
			ifOnLeftSideDo: [ otherBlock value: self value: lineSeg. ^self ]
			ifOnRightSideDo: [  ]
			ifOnLineDo: [  ].
	].
	"
	self doWithIndex: [ :lineSeg :index |
		lineSeg point: (self atWrap: index +1) pointB
			ifOnLeftSideDo: [ otherBlock value: self value: lineSeg. ^self ]
			ifOnRightSideDo: [  ]
			ifOnLineDo: [  ].
	].
	"
	aBlock value: self.

]

{ #category : #testing }
VMPolygon >> isCW [
	| topLineSeg prevLineSeg dL dR |
	"choose the line segment whose pointA has the highest y-value. if multiple points share this
	y-value, we choose the one amoung these with the highest x-value"
	topLineSeg := self at: 1.
	
	self allButFirstDo: [ :line | 
		topLineSeg pointA y < line pointA y
			ifTrue: [ topLineSeg := line ]
			ifFalse: [ topLineSeg pointA y = line pointA y
					ifTrue: [ topLineSeg pointA x < line pointA x
							ifTrue: [ topLineSeg := line ] ] ] ].

	"find the line segment that connects to lineSeg pointA"
	prevLineSeg := self prevLineSeg: topLineSeg.

	"handle the special case where prevLineSeg has no change in x"
	prevLineSeg pointA x = prevLineSeg pointB x
		ifTrue: [ ^topLineSeg dX > 0 	].
	
	
	"handle the special case where topLineSeg has no change in x"
	topLineSeg pointA x = topLineSeg pointB x
		ifTrue: [ ^ prevLineSeg pointA x < topLineSeg pointA x ].
	
	"compute the slope of the two line segments and compare them"
	dL := prevLineSeg dY / prevLineSeg dX.
	dR := topLineSeg dY / topLineSeg dX.
	
	dL = 0 ifTrue: [ ^ true ].
	dR = 0 ifTrue: [ ^ false ].
	
	dL sign = dR sign ifTrue: [
		dL < dR ifTrue: [ ^true ].
		^false.
	].
	
	dL > dR ifTrue: [ ^true ].
	
	^false.
	




]

{ #category : #testing }
VMPolygon >> isConvex [
	
	self doWithIndex: [ :lineSeg :index |
		lineSeg point: (self atWrap: index +1) pointB
			ifOnLeftSideDo: [ ^false ]
			ifOnRightSideDo: []
			ifOnLineDo: [].
	].
	
	^true.

]

{ #category : #testing }
VMPolygon >> isConvexEh [
	
	self doWithIndex: [ :lineSeg :index |
		lineSeg point: (self atWrap: index +1) pointB
			ifOnLeftSideDo: [ self logCr: 'left'. ^false ]
			ifOnRightSideDo: [ self logCr: 'right'. ]
			ifOnLineDo: [ self logCr: 'on-line, ', lineSeg printString, ', ', (self atWrap: index+1) pointB printString. ].
	].
	
	^true.

]

{ #category : #private }
VMPolygon >> isLeft: p a: a b: b [
	"returns True if the point p is left of the line which is defined by the two points a and b.
	the line must not be parallel to the x axis, i.e. a.y and b.y must not be identical."
	
	| u v w z |
	
	u := (a y) - (p y).
	v := (a y) - (b y).
	w := (b x) - (a x).
	
	z := (a x) + (w * u / v).
	
	(p x) < z ifTrue: [
		^true.
	].

	^false.
]

{ #category : #testing }
VMPolygon >> isPointInside: point [
	"returns True if the point lies inside the polygon and False otherwise"
	
	| wn |
	
	wn := self windingNumber:point.
	
	"self logCr: 'winding number=', (wn printString).
	"
	^wn ~= 0
]

{ #category : #comparing }
VMPolygon >> isSimilarTo: aPolygon [
	| p |
	p := aPolygon asVMPolygon.
	self size = p size ifFalse: [ ^false ].
	
	"find a line segment with identical start and end point in both polygons"
	p doWithIndex: [ :lineSeg :index2 |
		"Transcript show: 'testing lineSeg=', self first printString, ' with lineSeg=', lineSeg printString; cr."
		
		(self first isSimilarTo: lineSeg) ifTrue: [
			"check if all other line segments are identical too"
			
			1 to: self size-1 do: [ :i |
				((self atWrap: i+1) isSimilarTo: (p atWrap: i+index2)) ifFalse: [ ^false ].
			].
			^true
		].
	].
	
	^false

]

{ #category : #testing }
VMPolygon >> isValid [
	| line |
	(self size < 3) ifTrue: [ ^false ].
	
	line := self first asVMLine.
	self allButFirstDo: [ :lineSeg |
		(line isCollinearWith: lineSeg) ifFalse: [ ^true. ].
	].
	
	^false

]

{ #category : #'as yet unclassified' }
VMPolygon >> mergeShortVectors: maxLength [
	"removes all line segments that are of maxLength or shorter. line
	segments will be connected with their successor if they are no
	longer connected.
	
	Important: this process may result in a degenerated polygon, e.g.
	a polygon where all line segments are colinear, or a polygon that
	is empty (= contains no line segments)"
	| newPolygon |
	
	"select all vectors that are longer than 'maxLength'."
	newPolygon := self
		select: [ :lineSeg | lineSeg length > maxLength ].
		
	
	"connect all vectors that are not connected with their successor vector"
	newPolygon doWithIndex: [ :lineSeg :index |
		| nextLineSeg |
		nextLineSeg := newPolygon atWrap: (index + 1).
		(lineSeg pointB = nextLineSeg pointA) ifFalse: [
			newPolygon at: index put: (VMLineSegment pointA: lineSeg pointA pointB: nextLineSeg pointA type: lineSeg type).
		].
	].
		
	^newPolygon

]

{ #category : #'as yet unclassified' }
VMPolygon >> moveBy: aPoint [
	^(self species new)
		addAll: (self collect:[ :lineSeg | lineSeg moveBy: aPoint ])
		yourself.
]

{ #category : #'element access' }
VMPolygon >> nextLineSeg: aLineSeg [
	self do: [ :line |
		(line pointA = aLineSeg pointB) ifTrue: [ ^line. ].
	].
	
	self error: 'next line segment not found in polygon'.
]

{ #category : #'element access' }
VMPolygon >> prevLineSeg: aLineSeg [
	self do: [ :line |
		(line pointB = aLineSeg pointA) ifTrue: [ ^line. ].
	].
	
	self error: 'previous line segment not found in polygon'.
]

{ #category : #printing }
VMPolygon >> printString [
	| result |
	result := 'VMPolygon new fromPoints: {'.
	
	self do: [ :lineSeg |
		result := result, ' ', lineSeg pointA printString, '.'.
	].
	
	^ result, ' }'.
		
]

{ #category : #private }
VMPolygon >> reversed [
	| temp |
	
	temp := (self collect: [ :lineSeg | lineSeg reversed] ) asOrderedCollection reversed.
	
	^(self species new)
		addAll: temp;
		yourself
]

{ #category : #accessing }
VMPolygon >> signedArea [
	"see: https://en.wikipedia.org/wiki/Shoelace_formula"
	| sum |
	
	sum := 0.
	self doWithIndex: [ :lineSeg :index |
		sum := sum + (
			lineSeg pointA x * (lineSeg pointB y - (self atWrap: (index-1)) pointA y)
		).
	].
	
	^0.5 * sum
]

{ #category : #transforming }
VMPolygon >> transform: aVMTFMatrix [
	| mat polygon |
	
	mat := aVMTFMatrix asVMTFMatrix.
	polygon := self species new.
	polygon addAll: (self collect: [ :lineSeg | lineSeg transform: mat ]).
	
	^polygon
	
	
	
]

{ #category : #testing }
VMPolygon >> windingNumber: p [
	"computes the winding number for a point with respect to the polygon. does only make sense if we have a closed polygon."
	| wn length fun |
	
	wn := 0.
	length := self size.
	
	fun := [ :a :b |
		(a y) > (p y) ifTrue: [
			"a is located above p"
			(b y) > (p y) ifTrue: [
				"a and b are both located above p. the winding number does not change"
			] ifFalse: [
				"a is above p and b is below. the winding number changes if p lies to the left of the line a->b."
				(self isLeft: p a: a b: b) ifTrue: [
					wn := wn + 1.
				]
			]
		] ifFalse: [
			"a is located below p"
			(b y) > (p y) ifTrue: [
				"a is below p and b is above p. the winding number changes if p lies to the left of the line a->b."
				(self isLeft: p a: a b: b) ifTrue: [
					wn := wn - 1.
				].
			] ifFalse: [
				"a and b are both located below p. the winding number does not change"
			].
		].
	].

	"iterate over all but the last vertex. the last vertex is treated seperatly because it is connected with the first one"
	1 to: (length-1) do: [ :i |
		fun value: (self at: i) pointA value: (self at: (i+1)) pointA.
	].
	
	fun value: (self last) pointA value: (self first) pointA.
	
	^wn.
]
