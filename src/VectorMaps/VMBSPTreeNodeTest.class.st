"
A VMBSPTreeNodeTest is a test class for testing the behavior of VMBSPTreeNode
"
Class {
	#name : #VMBSPTreeNodeTest,
	#superclass : #Object,
	#category : #'VectorMaps-Tests'
}

{ #category : #tests }
VMBSPTreeNodeTest >> testAddCollinearLineSegLeftCollectionRightCollection [
	"
	test data: a simple non-convex map. the inside of the shape is traversable, the outside unkown space.
	
		     |  <- hyperplane
		+----+
		|    |
		|    +--+  <- non-convex polygon
		|    :  |
		+-------+
		     |
	"
	| root data collection left right |
	
	data := {
		1@1.  4@1.  4@2.  3@2.  3@3.  1@3.
	}.
	collection := OrderedCollection new.
	
	data doWithIndex: [ :aPoint :index |
		collection add: (VMLineSegment from: aPoint to: (data atWrap: (index+1))).
	].
	
	root := VMBSPTreeNode plane: collection third.
	
	left := OrderedCollection new.
	right := OrderedCollection new.
	
	root addCollinearLineSeg: collection third leftCollection: left rightCollection: right.
	self assert: left isEmpty.
	self assert: right size equals: 1.


]

{ #category : #tests }
VMBSPTreeNodeTest >> testBspTreeConstruction [
	"
	test data: a simple non-convex map. the inside of the shape is traversable, the outside unkown space.
	
		1@3 +----+ 3@3
		    |    |
		    |    +--+ 4@2
		    |       |
		1@1 +-------+ 4@1
	"
	| root data collection |
	
	data := {
		1@1.  4@1.  4@2.  3@2.  3@3.  1@3.
	}.
	collection := OrderedCollection new.
	
	data doWithIndex: [ :aPoint :index |
		collection add: (VMLineSegment from: aPoint to: (data atWrap: (index+1))).
	].
	
	root := VMBSPTreeNode new.
	
	root insertLineSegCollection: collection.
	1 halt.


]

{ #category : #tests }
VMBSPTreeNodeTest >> testsplitCollectionLeftCollectionRightCollection [
	| root data lineSegs left right |
	data := {
		1@1.  4@1.  4@2.  3@2.  3@3.  1@3.
	}.
	root := VMBSPTreeNode new.
	left := OrderedCollection new.
	right := OrderedCollection new.
	lineSegs := data collectWithIndex: [ :aPoint :index |
		VMLineSegment from: aPoint to: (data atWrap: index+1)
	].
	
	root plane: (lineSegs at: 4).
	
	root splitCollection: lineSegs leftCollection: left rightCollection: right.
	
	1 halt.

]
