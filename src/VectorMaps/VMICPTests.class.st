Class {
	#name : #VMICPTests,
	#superclass : #VMTests,
	#category : #'VectorMaps-Tests'
}

{ #category : #'as yet unclassified' }
VMICPTests >> matrix: matrixA isSimilarTo: matrixB [
	"returns true if the values of each cell are the same (+/- epsilon) between the two provided matrices"
	| error epsilon returnValue |
	
	returnValue := true.
	epsilon := 0.0001.
	
	1 to: 2 do: [ :r |
		1 to: 2 do: [ :c |
			error := (matrixA at: r at: c) - (matrixB at: r at: c).
			(error abs > epsilon) ifTrue: [
				returnValue := false.
			].
		].
	].
	
	^returnValue.

]

{ #category : #tests }
VMICPTests >> testAlignmentStep [
	"in this test the icp algorithm should result in a (near) perfect alignment after only one iteration step.
	additionally the translation component is expected to be 0@0 (or very close to this)."
	| data data2 icp epsilon translate error |
	
	data := {  -3 @ -3.  -2 @ -2.  -1 @ -1.  0@0. 1@1.  2@2.  3@3.  }.
	data2 := data collect: [ :p |  p rotateBy: 0.3 about: 0@0  ].
	epsilon := 0.000001.
	
	icp := VMICP new.
	icp alignPointCollection: data2 with: data.

	icp iterateOnce.
	
	icp outputA doWithIndex: [ :p :index |
		self assert: (( p dist: (data at: index)) < epsilon).
	].
	
	translate := Point x: (icp vecT at: 1) y: (icp vecT at: 2).
	self assert: ((translate dist: (0@0)) < epsilon).
	
	error := icp computeError.
	self assert: (error >= 0.0).
	self assert: (error < epsilon).
	
]

{ #category : #tests }
VMICPTests >> testAlignmentStep2 [
	"in this test we expect a (near) perfect match after 5 iterations."
	| data data2 icp epsilon error |
	
	data := {
		1@ -2.  2@ -1.  3@0.  4@1.  4@2.  4@3.  3@3.  2@3.  1@3.
		1@4.  1@5.  1@6.  1@7.  1@8.  2@9.  3@10.
		4@10. 5@10.  7@10.
	}.
	
	data2 := data collect: [ :p |
		(p rotateBy: 0.3 about: 3.5@3.5) + (0.1@0.133)
	].
	
	epsilon := 0.000001.
	
	icp := VMICP new.
	icp alignPointCollection: data2 with: data.
	
	icp iterateOnce.
	icp iterateOnce.
	icp iterateOnce.
	icp iterateOnce.
	icp iterateOnce.
	
	icp outputA doWithIndex: [ :p :index |
		self assert: (( p dist: (data at: index)) < epsilon).
	].
	
	error := icp computeError.
	self assert: (error >= 0.0).
	self assert: (error < epsilon).

]

{ #category : #tests }
VMICPTests >> testCenterOfMass [
	| icp points expectedResult centerOfMass epsilon error |
	
	icp := VMICP new.
	points := { -2@1. -1@1. 0@1. 1@1. 2@1.}.
	expectedResult := 0@1.
	epsilon := 0.000001.
	
	centerOfMass := icp computeCentroid: points.
	
	"Transcript
		show: 'center of mass=', centerOfMass printString, ', expected result=', expectedResult printString;
		cr.
	"
	error := expectedResult dist: centerOfMass.
	self assert: (error < epsilon).

]

{ #category : #tests }
VMICPTests >> testCenterOfMass2 [
	| icp points  expectedResult centerOfMass epsilon error |
	
	icp := VMICP new.
	points := { -2@ -1.  -1@0. 0@1. 1@2. 2@3.}.
	expectedResult := 0@1.
	epsilon := 0.000001.
	
	centerOfMass := icp computeCentroid: points.
	
	"Transcript
		show: 'center of mass=', centerOfMass printString, ', expected result=', expectedResult printString;
		cr.
	"
	error := expectedResult dist: centerOfMass.
	self assert: (error < epsilon).

]

{ #category : #tests }
VMICPTests >> testCenterOfMass3 [
	"same as test 2, but using a quad-tree as source collection"
	| icp points quadtree expectedResult centerOfMass epsilon error |
	
	icp := VMICP new.
	points := { -2@ -1.  -1@0. 0@1. 1@2. 2@3.}.
	quadtree := (VMQuadTreeNode size: 1@1 center: 0@0)
		addAll: points;
		root.
	expectedResult := 0@1.
	epsilon := 0.000001.
	
	centerOfMass := icp computeCentroid: quadtree.
	
	"Transcript
		show: 'center of mass=', centerOfMass printString, ', expected result=', expectedResult printString;
		cr.
	"
	error := expectedResult dist: centerOfMass.
	self assert: (error < epsilon).

]

{ #category : #tests }
VMICPTests >> testPointMatching [
	"tests if the icp point matching finds the correct nearest point in the provided quad-tree.
	note, that some ICP implementations in the literature are not as strict and only look for
	a good match, not necessarly the best/closest match."
	| icp quadtree sourceCollection shiftedPoints epsilon |
	
	icp := VMICP new.
	epsilon := 0.000001.
	
	sourceCollection := {
		0@1.  2@1.  4@1.  6@1.  3@ -3
	}.
	
	shiftedPoints := sourceCollection collect: [ :p | p + (0.1@0.3) ].
	
	quadtree := (VMQuadTreeNode size: 1@1 center: 0@0)
		addAll: shiftedPoints;
		root.
	
	sourceCollection doWithIndex: [ :p :index |
		| matchingPoint error |
		
		matchingPoint := icp findCorrespondingPoint: p inNNCollection: quadtree.
		error := matchingPoint dist: (shiftedPoints at: index).
		
		self assert: error < epsilon.
	].
	
	
]
