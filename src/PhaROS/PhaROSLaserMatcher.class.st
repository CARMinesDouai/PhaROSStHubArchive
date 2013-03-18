Class {
	#name : #PhaROSLaserMatcher,
	#superclass : #Object,
	#instVars : [
		'map',
		'laserScan',
		'circles'
	],
	#category : #'PhaROS-MapMatcher'
}

{ #category : #'as yet unclassified' }
PhaROSLaserMatcher >> calculateCircles [
	| mapping index  scannedCircles |
	
	mapping := Dictionary new. 
	index := 0. 
	
	" Maps the related angle of each laser measure of that have the same range, with an error of 1 centimeter".
	laserScan ranges do: [: range | 
		
		| points relativePoint angle | 
		
		points := mapping at: (range roundUpTo: 0.01) ifAbsentPut: [ 
			{OrderedCollection new }.
		].  
	
		angle := index * laserScan angle_increment.
		
		relativePoint := range * angle cos @ range * angle sin.
		
		points add: relativePoint.
		index := index + 1. 
	].
	
 	scannedCircles := mapping values select: [ : p | p size > 1 ].
	
	self assert: circles size > 1. 
	
	self matchAllCircles: circles. 
	
	









]

{ #category : #'as yet unclassified' }
PhaROSLaserMatcher >> circles [ 
	
]

{ #category : #'as yet unclassified' }
PhaROSLaserMatcher >> match: aCollectionOfPoints measuredFrom: aPose at: aRange [ 

	| previous distance |
	
	
	previous := aCollectionOfPoints first.
	
	aCollectionOfPoints allButFirstDo: [ : current | 
		
		
		distance := current dist: previous.
		self posiblePositions do: [  : position | 	
			| mapIterator |
			mapIterator := map circleWith: aPose and: aRange.
			
			
			
			
			
		].
		
		
		
		
		
	].


]

{ #category : #'as yet unclassified' }
PhaROSLaserMatcher >> matchAllCircles: aCollectionOfScannedCircles [

	aCollectionOfScannedCircles inject: Dictionary new into: [ :mapper : each | 
		| pose |
		pose := self matchCircle: each. 
		mapper at: pose put: (mapper at: pose ifAbsent: [ 0 ]) +1.
		mapper.
	]

]
