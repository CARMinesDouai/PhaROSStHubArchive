Class {
	#name : #VMBSPLeafTests,
	#superclass : #VMTests,
	#category : #'VectorMaps-Tests'
}

{ #category : #tests }
VMBSPLeafTests >> testCreatePlaneForPolygonIfNoneDo [
	"we create two sectors that share a common line segment. #createPlaneForPolygon: 
	is expected to return the shared line segment, since it is the only one that
	has all line segments of the second sector on the 'correct' side."
	| pointsA pointsB sectorA sectorB root plane |
	
	pointsA := { -2 @ 2.  0.2 @ 2.  0.4 @ -1.  2.2 @ -1. }.
	pointsB := { 0.2 @ 2.  2.2 @ 2.  2.2 @ -1.  0.4 @ -1. }.
	
	sectorA := VMSector new fromPoints: pointsA.
	sectorB := VMSector new fromPoints: pointsB.
	
	root := VMBSPLeaf parent: nil sector: sectorA.
	plane := root createPlaneForPolygon: sectorB ifNoneDo: [ self assert: false ].
	
	self assert: plane pointA equals: pointsA second.
	self assert: plane pointB equals: pointsA third.
	
	

]

{ #category : #tests }
VMBSPLeafTests >> testFindSectorByLineSeg [
	| polygons root sector results |
	
	polygons := VMDataSet toyExample_polygons.

	root := VMBSPLeaf new.
	
	root := root insert: polygons first.
	root := root insert: polygons second.
	root := root insert: polygons third.
	root := root insert: polygons fourth.
	
	sector := root rightChild rightChild rightChild leftChild rightChild rightChild sector.
	results := sector select: [ :lineSeg | lineSeg type isSector ] thenCollect: [ :lineSeg |
		root findSectorByLineSeg: lineSeg reversed		
	].
	
	self assert: results size equals: 4.
	results do: [ :obj |
		self assert: obj isNotNil.
	].

]

{ #category : #tests }
VMBSPLeafTests >> testInsert [
	| points polygons expectedResults tree |
	
	points := {
		{ -2 @ 2.  2 @ 2.  2 @ -2.  -2 @ -2 }. "the starting polygon - a square"
		{ -1 @ 1.  1 @ 1.  1 @ -1.  -1 @ -1 }. "a smaller square the fits inside the first polygon"
		{ -2 @ 2.  2 @ 2.  2 @ 0.  -2 @ 0 }. "a rectangle that is half the size of the first polygon, and lies inside the first polygon, touching it on three sides"
		{ 4 @ 2.  6 @ 2.  6 @ -2.  4 @ -2. }. "another rectangle, outside and not touching any of the other polygons"
	}.
	
	expectedResults := {
		1.  1.  2.  4.
	}.
	
	polygons := points collect: [ :pointCollection |
		VMPolygon new fromPoints: pointCollection
	].

	polygons second do: [ :lineSeg |
		lineSeg type: VMLineTypeFrontier new.
	].
	
	tree := VMBSPLeaf new.
	
	polygons doWithIndex: [ :polygon :index |
		tree := tree insert: polygon.
		self assert: tree sectorCount equals: (expectedResults at: index).
	].

]

{ #category : #tests }
VMBSPLeafTests >> testInsert2 [
	| points polygons expectedResults tree |
	
	points := {
		{ -2 @ 1.  2 @ 1.  2 @ -1.  -2 @ -1 }.
		{ -1 @ 2.  1 @ 2.  1 @ -2.  -1 @ -2 }.
	}.
	
	expectedResults := {
		1.  1.  1.  2.
	}.
	
	polygons := points collect: [ :pointCollection |
		VMPolygon new fromPoints: pointCollection
	].
	
	tree := VMBSPLeaf new.
	
	polygons doWithIndex: [ :polygon :index |
		tree := tree insert: polygon.
		"self assert: tree sectorCount equals: (expectedResults at: index)."
	].

]

{ #category : #tests }
VMBSPLeafTests >> testSectorNeighbors [
	| polygons root leaf results |
	
	polygons := VMDataSet toyExample_polygons.

	root := VMBSPLeaf new.
	
	root := root insert: polygons first.
	root := root insert: polygons second.
	root := root insert: polygons third.
	root := root insert: polygons fourth.
	
	leaf := root rightChild rightChild rightChild leftChild rightChild rightChild.
	results := leaf sectorNeighbors.
	
	self assert: results size equals: 4.
	results do: [ :obj |
		self assert: obj isNotNil.
	].

]
