Class {
	#name : #VMPolygonTests,
	#superclass : #VMTests,
	#category : #'VectorMaps-Tests'
}

{ #category : #tests }
VMPolygonTests >> testArea [
	| p points area expectedResults |
	
	points := {
		{ 0 @ 0.  0 @ 2.  2 @ 2. }.
		{ -2 @ 0.  0 @ 2.  2 @ 0.  0 @ -2. }.
		{ 0 @ 0.  0 @ 2.  4 @ 0.  0 @ -2. }.
		{ 0 @ -2.  0 @ 2.  2 @ 2.  1 @ 0.  2 @ -2. }.
	}.
	expectedResults := { 2.  8.  8.  6. }.
	
	points doWithIndex: [ :pointCollection :index |
		p := VMPolygon new fromPoints: pointCollection.
		area := p area.
		self assert: (area closeTo: (expectedResults at: index)).
	].

]

{ #category : #tests }
VMPolygonTests >> testCentroid [
	| p points centroid expectedResults |
	
	points := {
		{ -2 @ 0.  0 @ 2.  2 @ 0.  0 @ -2. }.
		{ 0 @ 0.  2 @ 2.  4 @ 0.  2 @ -2. }.
		"{ 0 @ -2.  0 @ 2.  2 @ 2.  1 @ 0.  2 @ -2. }."
	}.
	expectedResults := { 0 @ 0.  2 @ 0. }.
	
	points doWithIndex: [ :pointCollection :index |
		p := VMPolygon new fromPoints: pointCollection.
		centroid := p centroid.
		self assert: (centroid closeTo: (expectedResults at: index)).
	].

]

{ #category : #tests }
VMPolygonTests >> testEquals [
	| points p1 p2 |
	
	points := { 0 @ 2.  4 @ 2.  4 @ -2.  0 @ -2. }.
	
	p1 := VMPolygon new fromPoints: points.
	p2 := VMPolygon new fromPoints: (points collectWithIndex: [ :point : index | points atWrap: index+2 ]).
	
	self assert: p1 = p2.
	self assert: (p1 = (p2 reversed)) not.

]

{ #category : #tests }
VMPolygonTests >> testFromPoints [
	| points polygon |
	
	points := {
		-2 @ -2.
		4 @ -2.
		0 @ 5.
	}.
	
	polygon := VMPolygon new fromPoints: points.
	
	self assert: polygon size equals: points size.
	

]

{ #category : #tests }
VMPolygonTests >> testFromPoints2 [
	| points polygon |
	
	points := {
		0 @ 0.
		-2.5 @ 0.
		1.1 @ 0.5.
	}.
	
	polygon := VMPolygon new fromPoints: points.
	
	self assert: polygon size equals: points size.
	

]

{ #category : #tests }
VMPolygonTests >> testIfConvexDoOtherwiseDo [
	| data expectedResults polygon result |
	data := {
		{  0 @ 2.  2 @ 0.  0 @ -2.  -2 @ 0. }.
		{ -2 @ 2.  2 @ 2.  2 @ 0.    1 @ 0.  1 @ -2.  -2 @ -2. }.
	}.
	expectedResults := {
		true.
		false. 
	}.
	
	data doWithIndex: [ :points :index |
		result := nil.
		polygon := VMPolygon new fromPoints: points.
		
		polygon
			ifConvexDo: [ :p | result := true ]
			otherwiseDo: [ :p :l | result := false ].
		
		self assert: result equals: (expectedResults at: index).
	].
	
	

]

{ #category : #tests }
VMPolygonTests >> testIsCW [
	| data expectedResults polygon |
	
	data := {
		{ -2 @ 2.  1 @ -1. -4 @ -1. }.
		{  0 @ 2.  2 @ 2.  -2 @ 0  }.
		{ -2 @ 2.  1 @ 0.  -2 @ -2 }.
		{ -2 @ 2.  2 @ 1.   0 @ -1 }.
		{  0 @ 2. -1 @ 0.  -2 @ 0  }.
		{ -2 @ 2.  2 @ 2.  -2 @ -2 }.
		{ -2 @ 2.  2 @ 2.   2 @ -2 }.
	}.
	expectedResults := {
		true.
		true.
		true.
		true.
		true.
		true.
		true.
	}.
	
	data doWithIndex: [ :aPointCollection :index |
		polygon := VMPolygon new fromPoints: aPointCollection.
		self assert: polygon isCW equals: (expectedResults at: index).
		
		polygon := VMPolygon new fromPoints: aPointCollection reversed.
		self assert: polygon isCW not equals: (expectedResults at: index).
	].
	

]

{ #category : #tests }
VMPolygonTests >> testIsConvex [
	| data expectedResults polygon result |
	data := {
		{  0 @ 2.  2 @ 0.  0 @ -2.  -2 @ 0. }.
		{ -2 @ 2.  2 @ 2.  2 @ 0.    1 @ 0.  1 @ -2.  -2 @ -2. }.
	}.
	expectedResults := {
		true.
		false. 
	}.
	
	data doWithIndex: [ :points :index |
		result := nil.
		polygon := VMPolygon new fromPoints: points.
		
		self assert: polygon isConvex equals: (expectedResults at: index).
	].
	
	

]

{ #category : #tests }
VMPolygonTests >> testMergeShortVectors [
	| points polygon expectedResults minLength |
	
	points := {
		{ -2 @ 0.  0 @ 2.  2 @ 0.  0 @ -2 }.
		{ -2 @ 2.  2 @ 2.  2 @ 2.  2 @ -2.  -2 @ -2 }.
		{ -2 @ 2.  2 @ 2.  1.99 @ 2.01.  2 @ -2.  -2 @ -2 }.
	}.
	expectedResults := {
		4.  4.  5.
	}.
	minLength := 0.00001.
	
	points doWithIndex: [ :pointCollection :index |
		| newPolygon |
		polygon := VMPolygon new fromPoints: pointCollection.
		newPolygon := polygon mergeShortVectors: minLength.
		self assert: newPolygon size equals: (expectedResults at: index).
	].
	

]

{ #category : #tests }
VMPolygonTests >> testTransform [
	| polygon transformedPolygon expectedResult tf |
	
	polygon := VMPolygon new fromPoints: { 1@1.  1@2.  2@2.  2@1 }.
	expectedResult := VMPolygon new fromPoints: { 3@2.  3@3.  4@3.  4@2 }.
	tf := VMTFMatrix angle:0 translation: 2@1.
	
	transformedPolygon := polygon transform: tf.
	
	self assert: transformedPolygon = expectedResult.
]

{ #category : #tests }
VMPolygonTests >> testWindingNumber [
	| points expectedResults |
	
	points := {
		{ -2 @ 2.  2 @ 2.  2 @ -2.  -2 @ -2. }.
		{ 0.2 @ 3.  3 @ -1.  -2 @ -1.6. }.
		{ -3@ 2.  1 @ 2.  1 @ 1.  -1 @ 1. -2 @ -1.  1 @ -1.  1 @ -2.  -3 @ -2. }.
	}.
	"results (columns):
	  1) original polygon, tested with 0@0
	  2) original polygon, tested with 20@20
	  3) inverted polygon, tested with 0@0
	  4) inveretd polygon, tested with 20@20
	"
	expectedResults := {
		{ 1.  0.  -1.  0 }.
		{ 1.  0.  -1.  0 }.
		{ 0.  0.  0.  0 }.
	}.
	
	points doWithIndex: [ :pointCollection :index |
		| polygon wn results |
		
		results := expectedResults at: index.
		
		polygon := VMPolygon new fromPoints: pointCollection.
		wn := polygon windingNumber: 0@0.
		self assert: wn equals: results first.
		wn := polygon windingNumber: 20@20.
		self assert: wn equals: results second.
		
		polygon := VMPolygon new fromPoints: pointCollection reversed.
		wn := polygon windingNumber: 0@0.
		self assert: wn equals: results third.
		wn := polygon windingNumber: 20@20.
		self assert: wn equals: results fourth.
	].

]
