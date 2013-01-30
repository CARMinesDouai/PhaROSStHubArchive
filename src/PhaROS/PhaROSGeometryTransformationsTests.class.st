Class {
	#name : #PhaROSGeometryTransformationsTests,
	#superclass : #TestCase,
	#category : #'PhaROS-Util-Test'
}

{ #category : #'as yet unclassified' }
PhaROSGeometryTransformationsTests >> testTransformation [
	| util |
	util := PhaROSGeometryTransformations new.
	self assert: (util  quaternationFromEulerFor: 0.0 and: 0.0 and: 0.0 ) = #(0.0 0.0 0.0 1.0).
	self assert: (util  quaternationFromEulerFor: 1.0 and: 0.0 and: 0.0 ) = #(0.48 0.0 0.0 0.878).
	self assert: (util  quaternationFromEulerFor: 0.0 and: 1.0 and: 0.0 ) = #(0.0 -0.47900000000000004 0.0 0.878).
	self assert: (util  quaternationFromEulerFor: 0.0 and: 0.0 and: 1.0 ) = #(0.0 0.0 0.48 0.878).
	self assert: (util  quaternationFromEulerFor: 1.0 and: 0.0 and: 1.0 ) = #(0.421 0.23 0.421 0.771).
	self assert: (util  quaternationFromEulerFor: 1.0 and: 1.0 and: 0.0 ) = #(0.421 -0.42 -0.229 0.771).
	self assert: (util  quaternationFromEulerFor: 0.0 and: 1.0 and: 1.0 ) = #(-0.229 -0.42 0.421 0.771).
	self assert: (util  quaternationFromEulerFor: 1.0 and: 1.0 and: 1.0 ) = #(0.168 -0.167 0.168 0.5660000000000001).
]
