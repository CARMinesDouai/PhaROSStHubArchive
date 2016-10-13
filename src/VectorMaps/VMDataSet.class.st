Class {
	#name : #VMDataSet,
	#superclass : #Object,
	#category : #'VectorMaps-Examples'
}

{ #category : #'as yet unclassified' }
VMDataSet class >> dataLocalMap_1 [
	"a very small local map, designed to test the map merging on stright line segments.
	this local map has a 'gap' (a frontier) that should be filled when merged with the local
	map from dataLocalMap_2."
	| data lineSegments localMap |
	
	data := {
		{ 0@0. 2@0. 1 }.
		{ 2@0. 4@0. 1 }.
		{ 4@0. 6@0. 2 }.
		{ 6@0. 8@0. 1 }.
		{ 8@0. 10@0. 1 }.
		{ 10@0. 5@5. 2 }.
		{ 5@5. 0@0. 2 }.
	}.
	
	lineSegments := data collect: [ :obj |
		(VMLineSegment from: obj first to: obj second type: (obj third))
	].
	
	localMap := (VMLocalMap new)
		lineSegments: lineSegments;
		yourself.
	
	^localMap.
	
]

{ #category : #'as yet unclassified' }
VMDataSet class >> dataLocalMap_2 [
	"a very small local map, designed to test the map merging on stright line segments.
	this local map is meant to be used in conjungtion with dataLocalMap_1."
	| data lineSegments localMap |
	
	data := {
		{ 1@0. 3@0. 1 }.
		{ 3@0. 5@0. 1 }.
		{ 5@0. 7@0. 1 }.
		{ 7@0. 9@0. 1 }.
		{ 9@0. 4.5@5. 2 }.
		{ 4.5@5. 1@0. 2 }.
	}.
	
	lineSegments := data collect: [ :obj |
		(VMLineSegment from: obj first to: obj second type: (obj third))
	].
	
	localMap := (VMLocalMap new)
		lineSegments: lineSegments;
		yourself.
	
	^localMap.
	
]

{ #category : #'data - maps' }
VMDataSet class >> dataMap_1 [
	"a very simple test map. It has a closed boundary and a single obstacle inside."
	| info vertices edges |
	
	info := '8 8 0.01'.
	vertices:= '-20.0 -10.0 1 30.0 -10.0 1 30.0 40.0 1 -20.0 40 1 5.0 0.0 1 9.0 4.0 1 -3.0 16.0 1 -7.0 12.0 1'.
	edges := '1 2 2 3 3 4 4 1 5 6 6 7 7 8 8 5'.
	
	^{ info. vertices. edges }.
]

{ #category : #'data - maps' }
VMDataSet class >> dataMap_2 [
	"a simple test map. It has a closed boundary and contains a few obstacles inside."
	| info vertices edges |
	
	info := '18 18 0.01'.
	vertices:= '-1.0 -1.0 1 25 0 1 30 5 1 31 21 1 5 20 1 0 15 1 4.5 2 1 14 2 1 14 3 1 6 3 1 9 16 1 20 16 1 20 17 1 8 17 1 12 7 1 24 7 1 24 12 1 12 12 1'.
	edges := '1 2 2 3 3 4 4 5 5 6 6 1 7 8 8 9 9 10 10 11 11 12 12 13 13 14 14 7 15 16 16 17 17 18 18 15'.
	
	^{ info. vertices. edges }.
]

{ #category : #'data - maps' }
VMDataSet class >> dataMap_3 [
	"a test map to test several strange but valid obstacles, including poly-lines and closed polygons
	that are connected via poly-lines. this map also contains two isolated points.
	
	returns: an array of three strings (info, vertices, and edges) that can be used to create a VMMap object"
	| info vertices edges |
	
	info := '28 27 0.01'.
	vertices:= '-5 -5 1 35 -5 1 35 35 1 -5 35 1', "map boundary (1-4 / 4)"
		' 30 0 1 25 0 1 20 5 1', "poly-line (5-7 /3)"
		' 15 5 1 10 7.5 1 5 7.5 1 0 5 1 0 10 1', "triangle with attached poly-line (8-12 / 5)"
		' 10 15 1 15 10 1 20 15 1 25 10 1 30 15 1 25 20 1 15 20 1', "two dimond-shaped polygons, attached at a single vertex (13-19 / 7)"
		' 0 20 1 0 30 1 5 25 1 15 25 1 20 20 1 25 25 1 20 30 1', "a triangle connected to a line segment, connected to a dimond-shaped polygon (20-)"
		' 10 30 1 30 30 1'.
	edges := '1 2 2 3 3 4 4 1',
		' 5 6 6 7',
		' 8 9 9 10',
		' 10 11 11 12 12 10',
		' 13 14 14 15 15 16 16 17 17 18 18 15 15 19 19 13',
		' 20 21 20 22 22 21',
		' 22 23',
		' 23 24 23 26 25 24 25 26'.
	
	^{ info. vertices. edges }.
]

{ #category : #'data - maps' }
VMDataSet class >> dataMap_4 [
	"a test map to test poly-lines
	
	returns: an array of three strings (info, vertices, and edges) that can be used to create a VMMap object"
	| info vertices edges |
	
	info := '30 23 0.01'.
	vertices:= '-5 -5 1 35 -5 1 35 35 1 -5 35 1', "map bounds (1-4 / 4)"
		' 2 2 1 5 2 1 8 2 1 11 2 1', "horizontal poly-line (5-8 / 4)"
		' 4 10 1 8 6 1 12 6 1 16 10 1 12 14 1 8 12 1 8 8 1 12 8 1 12 10 1 10 10 1', "spiral (9-18 / 10)"
		' 20 3 1 17 6 1', "diagonal line segment (19-20 / 2)"
		' 15 0 1 12 0 1', "horizontal line segment (21-22 / 2)"
		' 30 -2 1 30 4 1', "vertical line segment (23-24 / 2)"
		' 0 20 1 1 24 1 5 21 1', "poly-line (25-27 / 3)"
		' 10 22 1 10 26 1 11 20 1', "poly-line (28-30 / 3)"
		' 25 11 1 23 15 1 21 14 1'. "poly-line (31-33 / 3)"
	edges := '1 2 2 3 3 4 4 1', "1-4 / 4"
		' 5 6 6 7 7 8 ', "5-8 / 3"
		' 9 10 10 11 11 12 12 13 13 14 14 15 15 16 16 17 17 18', "9-18 / 9"
		' 19 20', "19-20 / 1"
		' 21 22', "21-22 / 1"
		' 23 24', "23-24 / 1"
		' 25 26 26 27', "25-27 / 2"
		' 28 29 29 30', "28-30 / 2"
		' 31 32 32 33'. "31-33 / 2"
	^{ info. vertices. edges }.
]

{ #category : #'data - maps' }
VMDataSet class >> dataMap_5 [
	"a completly empty map (except for the borders)
	
	returns: an array of three strings (info, vertices, and edges) that can be used to create a VMMap object"
	| info vertices edges |
	
	info := '4 4 0.01'.
	vertices:= '-8 -6 1 8 -6 1 8 6 1 -8 6 1'. "map bounds (1-4 / 4)"
	edges := '1 2 2 3 3 4 4 1'. "1-4 / 4"
	^{ info. vertices. edges }.
]

{ #category : #'data - maps' }
VMDataSet class >> dataMap_6 [
	"a map where the obstacles are part of the boundary
	
	returns: an array of three strings (info, vertices, and edges) that can be used to create a VMMap object"
	| info vertices edges |
	
	info := '12 12 0.01'.
	vertices:= '-10 -10 1 -10 10 1 -1 10 1 -1 5 1 1 5 1 1 10 1 10 10 1 10 -10 1 1 -10 1 1 0 1 -1 0 1 -1 -10 1 '. "map bounds (1-12 / 12)"
	edges := '1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 11 11 12 12 1'. "1-12 / 12"
	^{ info. vertices. edges }.
]

{ #category : #'data - maps' }
VMDataSet class >> dataMap_7 [
	"a test map to test poly-lines
	
	returns: an array of three strings (info, vertices, and edges) that can be used to create a VMMap object"
	| info vertices edges |
	
	info := '30 23 0.01'.
	vertices:= '-5 -5 1 35 -5 1 35 35 1 -5 35 1', "map bounds (1-4 / 4)"
		' 2 2 1 5 2 1 8 2 1 11 2 1', "horizontal poly-line (5-8 / 4)"
		' 4 10 1 8 6 1 12 6 1 16 10 1 12 14 1 8 12 1 8 8 1 12 8 1 12 10 1 10 10 1', "spiral (9-18 / 10)"
		' 20 3 1 17 6 1', "diagonal line segment (19-20 / 2)"
		' 15 0 1 12 0 1', "horizontal line segment (21-22 / 2)"
		' 30 -2 1 30 4 1', "vertical line segment (23-24 / 2)"
		' 0 20 1 1 24 1 5 21 1', "poly-line (25-27 / 3)"
		' 10 22 1 10 26 1 11 20 1', "poly-line (28-30 / 3)"
		' 25 11 1 23 15 1 21 14 1'. "poly-line (31-33 / 3)"
	edges := '1 2 2 3 3 4 4 1', "1-4 / 4"
		' 5 6 6 7 7 8 ', "5-8 / 3"
		' 9 10 10 11 11 12 12 13 13 14 14 15 15 16 16 17 17 18', "9-18 / 9"
		' 19 20', "19-20 / 1"
		' 21 22', "21-22 / 1"
		' 23 24', "23-24 / 1"
		' 25 26 26 27', "25-27 / 2"
		' 28 29 29 30', "28-30 / 2"
		' 31 32 32 33'. "31-33 / 2"
	^{ info. vertices. edges }.
]

{ #category : #'data - maps' }
VMDataSet class >> dataMap_8 [
	"a semi-complex map to test SLAM on a small scale."
	| info vertices edges points obstacles startIndex left right top bottom |
	
	points := {
		-6@4.
		-3.9@4.
			-3.9@4.1. -6@4.1. -6@8.1. -1.05@8.1. -1.05@4.1. -3.1@4.1.
		-3.1@4.
		2.1@4.
			2.1@4.1. -0.95@4.1. -0.95@8.1. 3.95@8.1. 3.95@4.1. 2.9@4.1.
		2.9@4.
		5.1@4.
			5.1@4.1. 4.1@4.1. 4.1@8.1. 8@8.1. 8@4.1. 5.9@4.1.
		5.9@4.
		8@4.
		8@ -4.
		-6@ -4.
	}.
	
	obstacles := {
		{  -4.5@2.5.  2.2@2.5.  0.2@ -2.5.  -2@ -2.5.  -2@ -2.4.  -0.1@ -2.4.  -0.1@0.  0.9@2.4.  -4.4@2.4.  -4.4@ -2.4.  -2.8@ -2.4.  -2.8@ -2.5.  -4.5@ -2.5.  }.
		{  4@2.5.  6.5@2.5.  6.5@ -2.5.  2@ -2.5  }.
	} asOrderedCollection.
		
	info := '1 1 0.01'.
	edges := ''.
	vertices:= '-1 0 0 '.   "origin"
	
	
	"create boundary"
	points do: [ :p |
		vertices := vertices, p x printString, ' ', p y printString, ' 1 '.
	].
	
	"outer wall"
	left := points first x.
	right := points first x.
	top := points first y.
	bottom := points first y.
	points do: [ :p |
		(left > p x) ifTrue: [ left := p x. ].
		(right < p x) ifTrue: [ right := p x. ].
		(top > p y) ifTrue: [ top := p y. ].
		(bottom < p y) ifTrue: [ bottom := p y. ].
	].
	"
	obstacles add: {
		(left - 0.1) @ (top - 0.1).
		(left - 0.1) @ (bottom + 0.1).
		(right + 0.1) @ (bottom + 0.1).
		(right + 0.1) @ (top - 0.1).
	}.
	"
	
	1 to: (points size-1) do: [ :i |
		edges := edges, i printString, ' ', (i+1) printString, ' '.
	].
	edges := edges, (points size) printString, ' 1 '.
	
	
	"create obstacles"
	startIndex := points size.
	obstacles do: [ :aObstacle |
		aObstacle do: [ :p |
			vertices := vertices, p x printString, ' ', p y printString, ' 1 '.
		].
		1 to: (aObstacle size-1) do: [ :i |
			edges := edges, (i+startIndex) printString, ' ', (i+startIndex+1) printString, ' '.
		].
		edges := edges, ((aObstacle size) + startIndex) printString, ' ', (startIndex +1) printString, ' '.
		
		startIndex := startIndex + (aObstacle size).
	].

	vertices := vertices trimRight.
	edges := edges trimRight.
	
	^{ info. vertices. edges }.
	






]

{ #category : #'data - maps' }
VMDataSet class >> dataMap_9 [
	"a semi-complex map to test SLAM on a small scale."
	| info vertices edges points obstacles startIndex |
	
	points := {
		-6@4.
		-3.9@4.
			-3.9@4.1. -6@4.1. -6@8.1. -1.05@8.1. -1.05@4.1. -3.1@4.1.
		-3.1@4.
		2.1@4.
			2.1@4.1. -0.95@4.1. -0.95@8.1. 3.95@8.1. 3.95@4.1. 2.9@4.1.
		2.9@4.
		5.1@4.
			5.1@4.1. 4.1@4.1. 4.1@8.1. 8@8.1. 8@4.1. 5.9@4.1.
		5.9@4.
		8@4.
		8@ -4.
		-6@ -4.
	}.
	
	obstacles := {
		{  -4.5@2.5.  2.2@2.5.  0.2@ -2.5.  -2@ -2.5.  -2@ -2.4.  -0.1@ -2.4.  -0.1@0.  0.9@2.4.  -4.4@2.4.  -4.4@ -2.4.  -2.8@ -2.4.  -2.8@ -2.5.  -4.5@ -2.5.  }.
		{  4@2.5.  6.5@2.5.  6.5@ -2.5.  2@ -2.5  }.
	}.
		
	info := '1 1 0.01'.
	edges := ''.
	vertices:= '-1 0 0 '.   "origin"
	
	
	"create boundary"
	points do: [ :p |
		vertices := vertices, p x printString, ' ', p y printString, ' 1 '.
	].

	1 to: (points size-1) do: [ :i |
		edges := edges, i printString, ' ', (i+1) printString, ' '.
	].
	edges := edges, (points size) printString, ' 1 '.
	
	
	"create obstacles"
	startIndex := points size.
	obstacles do: [ :aObstacle |
		aObstacle do: [ :p |
			vertices := vertices, p x printString, ' ', p y printString, ' 1 '.
		].
		1 to: (aObstacle size-1) do: [ :i |
			edges := edges, (i+startIndex) printString, ' ', (i+startIndex+1) printString, ' '.
		].
		edges := edges, ((aObstacle size) + startIndex) printString, ' ', (startIndex +1) printString, ' '.
		
		startIndex := startIndex + (aObstacle size).
	].

	vertices := vertices trimRight.
	edges := edges trimRight.
	
	^{ info. vertices. edges }.
	






]

{ #category : #'data - polygons' }
VMDataSet class >> dataPolygon_1 [
	"a simple 4x4 square, from 0@0 to 4@4"
	| polygon points |
	
	points := { 0@0. 40@0. 40@40. 0@40 }.
	
	polygon :=VMClosedPolygon fromOrderedPoints: points.
	
	polygon vertices doWithIndex: [ :v :i |
		v id: i.
		v index: i.
	].
	
	^polygon.
	
]

{ #category : #'data - polygons' }
VMDataSet class >> dataPolygon_1bis [
	"a simple 4x4 square, from 10@20 to 50@60"
	| polygon points |
	
	points := { 10@20. 10@60. 50@60. 50@20 }.
	
	polygon :=VMClosedPolygon fromOrderedPoints: points.
	
	polygon vertices doWithIndex: [ :v :i |
		v id: i.
		v index: i.
	].
	
	^polygon.
	

]

{ #category : #'data - polygons' }
VMDataSet class >> dataPolygon_2 [
	"a simple rotate square (aka dimond shape)"
	| polygon points |
	
	points := { 10@1. 13@4. 10@7. 7@4 }.
	
	polygon :=VMClosedPolygon fromOrderedPoints: points.
	
	polygon vertices doWithIndex: [ :v :i |
		v id: i.
		v index: i.
	].
	
	^polygon.
	

]

{ #category : #'data - polygons' }
VMDataSet class >> dataPolygon_3 [
	"same as dataPolygon_2, but with reveresed winding order."
	| polygon points |
	
	points := { 10@8. 7@11. 10@14. 13@11 }.
	
	polygon :=VMClosedPolygon fromOrderedPoints: points.
	
	polygon vertices doWithIndex: [ :v :i |
		v id: i.
		v index: i.
	].
	
	^polygon.
	

]

{ #category : #'data - polygons' }
VMDataSet class >> dataPolygon_4 [
	"a non-convex polygon in the shape of a square with two dented sides"
	| polygon points |
	
	points := { 1@8. 1@13. 6@13. 5@10.5. 6@8. 3.5@9 }.
	
	polygon :=VMClosedPolygon fromOrderedPoints: points.
	
	polygon vertices doWithIndex: [ :v :i |
		v id: i.
		v index: i.
	].
	
	^polygon.
	

]

{ #category : #'data - polygons' }
VMDataSet class >> dataPolygon_5 [
	"a triangle"
	| polygon points |
	
	points := { 0@0. 30@30. 0@30. }.
	
	polygon :=VMClosedPolygon fromOrderedPoints: points.
	
	polygon vertices doWithIndex: [ :v :i |
		v id: i.
		v index: i.
	].
	
	^polygon.
	

]

{ #category : #'data - polygons' }
VMDataSet class >> dataPolygon_Triangles [
	"an ordered collection of triangles for testing the computation of the polygons winding oder. contains all configurations
	that can occure when computing the winding order."
	| polygons points swap vertices |
	
	"creates a copy of the array and swaps the second and third entries, which inverts the winding order"
	swap := [ :array |
		| oc |
		oc := OrderedCollection new.
		oc add: array first.
		oc add: (array at: 3).
		oc add: (array at: 2).
		
		oc
	].
	
	"all relevant test cases"
	points := {
		{ 3@3. 3@1. 1@3 }.
		{ 3@3. 3@1. 1@2 }.
		{ 3@3. 3@1. 5@1 }.
		{ 3@3. 1@1. 1@2 }.
		{ 3@3. 1@1. 5@1 }.
		{ 3@3. 4@1. 5@1 }.
		{ 3@3. 1@1. 1@3 }.
		{ 3@3. 5@1. 1@3 }.
	}.
	vertices := OrderedCollection new.
	points doWithIndex: [ :array :aIndex |
		| v collection |
		collection := OrderedCollection new.
		
		array doWithIndex: [ :p :pIndex |
			v := VMGraphVertex point: p.
			v id: (aIndex printString, '.', pIndex printString).
			v index: pIndex.	"for testing only. usually the index should be unique."
			collection add: v.
		].
		vertices add: collection.
	].
	
	polygons := OrderedCollection new.
	
	vertices do: [ :a |
		polygons add: (VMClosedPolygon fromOrderedVertices: a).
		polygons add: (VMClosedPolygon fromOrderedVertices: (swap value: a)).
	].
	
	^polygons.
	

]

{ #category : #'data - maps' }
VMDataSet class >> map_7 [
	"a test map to test poly-lines
	
	returns: an array of three strings (info, vertices, and edges) that can be used to create a VMMap object"
	| map roomA roomB roomC polygons |
	
	map := VMMap new.
	map origin: 0@0.
	polygons := OrderedCollection new.
	
	roomA := VMPolygonChain fromOrderedPoints: { 1@5.  0@5.  0@0.  7@0.  7@5.  2@5.  }.
	roomB := VMPolygonChain fromOrderedPoints: {  5@3.  5@5.  0@5.  0@0.  5@0.  5@2.  }.
	roomC := VMPolygonChain fromOrderedPoints: {  1@0.  0@0.  0@5.  7@5.  7@0.  2@0.  }.
	
	"map bounds"
	polygons addAll: ( {
		"map boundary
		(VMClosedPolygon fromOrderedPoints: { -15@  -15.  15@ -15.  15@15.  -15@15. })
			makeCW;			
			expand: 0.1."
		"room 1"
		((VMPolygonChain fromOrderedPoints: { 6@7.  5@8.  5@10.  0@ 10.  0@0.  10@0.  10@5.  8@5.  7@6  })
			expand: 0.1)
			move: -15@ -15;
			yourself.
		(roomA
			expand: 0.1)
			move: -5@ -15;
			yourself.
		"(roomC
			expand: 0.1)
			move: 8@ -7.5;
			yourself.
		(roomC
			expand: 0.1)
			move: 1@ -7.5;
			yourself.
		(roomA
			expand: 0.1)
			move: 2@ -15;
			yourself.
		(roomB
			expand: 0.1)
			move: -15@ -5;
			yourself.
		(roomB
			expand: 0.1)
			move: -15@0;
			yourself.
		(roomB
			expand: 0.1)
			move: -15@5;
			yourself.
		(roomB
			expand: 0.1)
			move: -15@10;
			yourself.
			"
	} ).
	
	map polygons add: (VMPolygonMerger merge: polygons).
	"map polygons add: ( polygons first merge: polygons )."
	map computeBounds.
	
	^map.
]

{ #category : #'data - simulator' }
VMDataSet class >> robot1: map [
	
	^(VMRobot id: 'robo')
		map: map;
		radius: 0.22;
		orientation: Float pi * 1.1;
		speed: 0.2@ -0.01;
		position: -2@0.
	
]

{ #category : #'data - simulator' }
VMDataSet class >> sensor1 [
	
	^(VMSensorLRF id: 'lrf')
		angle: (Float pi / 1.3);
		maxRange: 10.0;
		rayCount: 30.
	
]

{ #category : #'data - simulator' }
VMDataSet class >> sensor2 [
	
	^(VMSensorLRF id: 'lrf')
		angle: (Float pi * 1.25);
		maxRange: 10.0;
		rayCount: (151).
	
]
