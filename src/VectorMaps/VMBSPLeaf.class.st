Class {
	#name : #VMBSPLeaf,
	#superclass : #VMBSPBase,
	#instVars : [
		'sector'
	],
	#category : #'VectorMaps-Collections, Trees & Graphs'
}

{ #category : #'instance creation' }
VMBSPLeaf class >> parent: aNode [
	^self new
		parent: aNode;
		yourself.

]

{ #category : #'instance creation' }
VMBSPLeaf class >> parent: aNode sector: aSector [
	"important: do not return 'yourself' here, because sector may return a newly created node,
	if the sector cannot be stored in a leaf (i.e. if the sector is not convex)."
	^self new
		parent: aNode;
		sector: aSector.
]

{ #category : #'rendering support' }
VMBSPLeaf class >> rendererClass [
	^VMBSPLeafRenderer
]

{ #category : #'as yet unclassified' }
VMBSPLeaf >> asCollectionOfSectors [
	sector ifNil: [ ^{} ].
	
	^{ sector }

]

{ #category : #accessing }
VMBSPLeaf >> bounds [
	"empty leafs return a default rectangle bounds to prevent error messages while rendering in the inspector"
	sector ifNil: [ ^ Rectangle origin: 0@0 corner: 1@1 ].
	^sector bounds
]

{ #category : #private }
VMBSPLeaf >> changeLineSeg: lineSeg type: type inPolygon: polygon [
	"creates a new line segment with the provided type and swaps it in the polygon with the old line segment"
	| newLineSeg |
	newLineSeg := lineSeg clone type: type.
	
	polygon at: (polygon indexOf: lineSeg) put: newLineSeg.

]

{ #category : #private }
VMBSPLeaf >> checkLineTypes: aSectorOrPolygon [
	"this method checks if any line segments of the sector overlap (i.e. are collinear) with
	any line segments from aSectorOrPolygon. those that overlap will share the 'strongest'
	line segment type. the types are ordered as:
	(lowest) frontier < obstacle < sector (highest)
	
	NOTE: this method is very optimistic about the whole 'collinear' check. there are certain
	conditions where the test is inaccurate at best."
	| maxDist |
	
	maxDist := 0.00001.
	
	aSectorOrPolygon do: [ :lineSeg |
		lineSeg type isFrontier ifFalse: [ "frontiers never change the type of other line segments"
			sector do: [ :sectorLineSeg |
				sectorLineSeg type isSector ifFalse: [ "sectors borders always remain sectors borders"
					(((sectorLineSeg distanceToPoint: lineSeg pointA) <= maxDist)
						and: [(sectorLineSeg distanceToPoint: lineSeg pointB) <= maxDist])
							ifTrue: [
								lineSeg type isSector
									ifTrue: [ self changeLineSeg: lineSeg type: lineSeg type inPolygon: aSectorOrPolygon ]
									ifFalse: [
										sectorLineSeg type isFrontier ifTrue: [
											self changeLineSeg: sectorLineSeg type: lineSeg type inPolygon: aSectorOrPolygon.
											sectorLineSeg type: lineSeg type
										].
									].
							].
				].
			].
		].
	].
]

{ #category : #private }
VMBSPLeaf >> createPlaneAlt: aSectorOrPolygon ifNoneDo: aBlock [
	"similar to createPlaneForPolygon:ifNoneDo:, but with reversed roles
	of sector and aSectorOrPolygon"
	| counter hyperplane |
	
	self assert: sector isNotNil.
	
	counter := 0.
	hyperplane := nil.
	
	"try every line segment of this leaf's sector as a hyperplane"
	aSectorOrPolygon do: [ :plane |
		| localCounter |
		localCounter := 0.
		sector do: [ :lineSeg |
			plane fuzzyPoint: lineSeg pointA
				ifOnLeftSideDo: [ localCounter := localCounter + 1. ]
				ifOnRightSideDo: []
				ifOnLineDo: [].
		].
		localCounter > counter ifTrue: [
			hyperplane := plane.
			counter := localCounter
		].
	].
	
	hyperplane ifNil: [
		aBlock value
	].
	
	^hyperplane

]

{ #category : #private }
VMBSPLeaf >> createPlaneForPolygon: aSectorOrPolygon ifNoneDo: aBlock [
	"returns a new hyperplane, or nil if no hyperplane was found (which should only
	happen if 'aSectorOrPolygon' lies inside the current sector."
	| counter hyperplane |
	
	self assert: sector isNotNil.
	
	counter := 0.
	hyperplane := nil.
	
	"try every line segment of this leaf's sector as a hyperplane"
	sector do: [ :plane |
		| localCounter |
		"iterate over all line segments of the new sector and count how many line
		segment start points are on the wrong side (i.e. are not on the same side
		as the leaf's sector)"
		localCounter := 0.
		aSectorOrPolygon do: [ :lineSeg |
			plane fuzzyPoint: lineSeg pointA
				ifOnLeftSideDo: [ localCounter := localCounter + 1. ]
				ifOnRightSideDo: []
				ifOnLineDo: [].
		].
		localCounter > counter ifTrue: [
			hyperplane := plane.
			counter := localCounter
		].
	].
	
	hyperplane ifNil: [
		"this case happens when aSectorOrPolygon is inside the current sector"
		
		self ifNotTouching: aSectorOrPolygon do: [
			Transcript show: 'skipping polygon=', aSectorOrPolygon printString; cr.
			aBlock value.
			^nil
		].
		
		^ self createPlaneAlt: aSectorOrPolygon ifNoneDo: [
			"1 halt."
			aBlock value
		].
	].
	
	^hyperplane

]

{ #category : #'as yet unclassified' }
VMBSPLeaf >> findSectorByLineSeg: aLineSeg [
	"^sector"
	sector ifNil: [ ^nil ].
	
	sector do: [ :lineSeg |
		(lineSeg isSimilarTo: aLineSeg) ifTrue: [ ^sector ]
	].
	
	^nil.
	

]

{ #category : #'as yet unclassified' }
VMBSPLeaf >> findSectorsByLineSeg: aLineSeg [
	sector ifNil: [ ^{} ].
	^{sector}

]

{ #category : #private }
VMBSPLeaf >> ifNotTouching: aSectorOrPolygon do: aBlock [
	"check if any of the polygon's corners is close to any of the sectors line segments"
	sector do: [ :sectorLineSeg |
		aSectorOrPolygon do: [ :lineSeg |
			((sectorLineSeg distanceToPoint: lineSeg pointA) < 0.000001) ifTrue: [ ^self ].
		].
	].
	
	aBlock value.

]

{ #category : #initialization }
VMBSPLeaf >> initialize [
	super initialize.
	
	sector := nil.
]

{ #category : #operations }
VMBSPLeaf >> insert: aPolygon [
	| newPlane newNode |
	
	"check if we have reached the maximum depth of the tree."
	(level > self maxDepth) ifTrue: [
		Transcript
			show: 'skipping (level=', level printString, '):'; cr;
			show: '  polygon=', aPolygon printString; cr.
			"show: ' plane=', parent hyperplane printString; cr."
		^ self
	].

	sector ifNil: [
		aPolygon
			ifConvexDo: [ :ignored |
				sector := aPolygon.
				^self.
			] otherwiseDo: [ :ignored :lineSeg |
				newPlane := lineSeg
			].
	] ifNotNil: [
		newPlane := self createPlaneForPolygon: aPolygon
			ifNoneDo: [
				self checkLineTypes: aPolygon.
				self logCr: self class name, ' insert status: skipping'.
				self logCr: '  polygon=', aPolygon printString.
				self logCr: '  sector=', sector printString.
				^self.
			].
	].
	
	newNode := self class nodeClass parent: parent plane: newPlane level: level.
	sector ifNotNil: [ newNode insert: sector. ].
	newNode insert: aPolygon.
	
	^newNode.

]

{ #category : #'as yet unclassified' }
VMBSPLeaf >> isLeaf [
	^true
]

{ #category : #accessing }
VMBSPLeaf >> sector [
	^sector
]

{ #category : #accessing }
VMBSPLeaf >> sector: aSector [
	sector := aSector
]

{ #category : #accessing }
VMBSPLeaf >> sectorCount [
	sector ifNil: [ ^0 ].
	^1
]

{ #category : #'as yet unclassified' }
VMBSPLeaf >> sectorNeighbors [
	| root neighbors  |
	
	root := self root.
	neighbors := sector select: [ :lineSeg | lineSeg type isSector ] thenCollect: [ :lineSeg |
		root findSectorByLineSeg: lineSeg reversed		
	].
	Transcript show: 'sectorNeighbors size=', neighbors size printString; cr.
	
	^ neighbors

]

{ #category : #'as yet unclassified' }
VMBSPLeaf >> sectorNeighbors2 [
	| root neighbors temp |
	
	root := self root.
	temp := sector select: [ :lineSeg | lineSeg type isSector ] thenCollect: [ :lineSeg |
		root findSectorsByLineSeg: lineSeg reversed		
	].
	neighbors := OrderedCollection new.
	temp do: [ :collection |
		neighbors addAll: collection
	].
	Transcript show: 'sectorNeighbors size=', neighbors size printString; cr.
	
	^ neighbors

]
