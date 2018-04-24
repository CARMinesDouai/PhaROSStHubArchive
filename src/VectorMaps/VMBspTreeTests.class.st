Class {
	#name : #VMBspTreeTests,
	#superclass : #Object,
	#category : #'VectorMaps-Tests'
}

{ #category : #tests }
VMBspTreeTests >> testSize [
	| root data |
	
	root := VMBSPTreeNode new.
	data := {
		1@1.  5@1.  5@5.  1@5.  3@3.  1@3.  2@2.
	}.
	
	data doWithIndex: [ :point :index |
		root insert: (VMLineSegment from: point to: (data atWrap: index+1)).
		self assert: root size equals: index.
	].
	

]

{ #category : #tests }
VMBspTreeTests >> testTreeCreation [
	"testing to create a simple bsp tree with three lines. with only three lines, this
	structure is already convex by construction."
	| root data |
	
	root := VMBSPTreeNode new.
	data := {
		1@1.  5@1.  5@5.
	}.
	
	data doWithIndex: [ :point :index |
		root insert: (VMLineSegment from: point to: (data atWrap: index+1)).
	].
	
	"we consider this test successful if we don't rise any signals"
	self assert: true.

]

{ #category : #tests }
VMBspTreeTests >> testTreeCreation2 [
	"this test creates a bsp tree from a square. we are testing that parallel (but not
	collinear) lines don't cause problems"
	| root data |
	
	root := VMBSPTreeNode new.
	data := {
		1@1.  5@1.  5@5.  1@5.
	}.
	
	data doWithIndex: [ :point :index |
		root insert: (VMLineSegment from: point to: (data atWrap: index+1)).
	].
	
	"we consider this test successful if we don't rise any signals"
	self assert: true.

]

{ #category : #tests }
VMBspTreeTests >> testTreeCreation3 [
	"similar to testTreeCreation and testTreeCreation2, but with a non-convex structure"
	| root data |
	
	root := VMBSPTreeNode new.
	data := {
		1@1.  5@1.  5@5.  1@5.  3@3.  1@3.  2@2.
	}.
	
	data doWithIndex: [ :point :index |
		root insert: (VMLineSegment from: point to: (data atWrap: index+1)).
	].
	

]

{ #category : #tests }
VMBspTreeTests >> testlineSegifLeftOfPlaneifRightOfPlane [
	| root rootPlane data isLeft isRight lineSeg |
	rootPlane := VMLine pointA: 0@2 pointB: 2@0.
	
	data := {
		" pointA pointB isLeft isRight "
		{ 0@0.  5@5.  true.  true }.  "crossing the plane"
		{ 2@2.  4@2.  true.  false }.  "only on the left side of the plane"
		{ -1@0.  1@0.  false.  true }.  "only on the right side of the plane"
		{ 0@0.  -2@2.  false. true }.  "right side, parallel to the plane"
		{ 2@0.  4@ -2.  false.  true}.  "collinear with the plane, sharing a point"
	}.
	
	data do: [ :obj |
		isLeft := false.
		isRight := false.
		root := VMBSPTreeNode plane: rootPlane.
		lineSeg := VMLineSegment from: obj first to: obj second.
		root lineSeg: lineSeg ifLeftOfPlane: [isLeft := true] ifRightOfPlane: [isRight := true].
		
		Transcript show: 'left=', isLeft printString, ', right=', isRight printString; cr.
		self assert: isLeft equals: obj third.
		self assert: isRight equals: obj fourth.
	].
	

]
