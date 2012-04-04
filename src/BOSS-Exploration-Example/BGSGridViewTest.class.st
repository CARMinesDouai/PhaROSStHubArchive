Class {
	#name : #BGSGridViewTest,
	#superclass : #TestCase,
	#instVars : [
		'gridView',
		'grid'
	],
	#category : #'BOSS-Kernel-Test'
}

{ #category : #testing }
BGSGridViewTest >> setUp [
	super setUp.
	grid := BGSGrid extent: 10@10.
	gridView := BGSGridView on: grid.
]

{ #category : #testing }
BGSGridViewTest >> testExtent [
	self assert: gridView extent = (121@121).
	gridView grid: (BGSGrid extent: 100@100).
	self assert: gridView extent = (1111@1111)
	
	
]
