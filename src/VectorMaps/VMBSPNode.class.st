Class {
	#name : #VMBSPNode,
	#superclass : #VMBSPBase,
	#instVars : [
		'hyperplane',
		'leftChild',
		'rightChild'
	],
	#category : #'VectorMaps-Collections, Trees & Graphs'
}

{ #category : #'as yet unclassified' }
VMBSPNode class >> parent: aNodeOrNil plane: aHyperplane [
	
	^(self new)
		parent: aNodeOrNil;
		hyperplane: aHyperplane;
		yourself.
]

{ #category : #'as yet unclassified' }
VMBSPNode class >> parent: aNodeOrNil plane: aHyperplane leftChild: leftLeaf rightChild: rightLeaf [
	
	^(self new)
		parent: aNodeOrNil;
		hyperplane: aHyperplane;
		leftChild: leftLeaf;
		rightChild: rightLeaf;
		yourself.
]

{ #category : #'as yet unclassified' }
VMBSPNode class >> parent: aNodeOrNil plane: aHyperplane level: level [
	
	^(self new)
		parent: aNodeOrNil;
		hyperplane: aHyperplane;
		level: level;
		yourself.
]

{ #category : #'rendering support' }
VMBSPNode class >> rendererClass [
	^VMBSPNodeRenderer
]

{ #category : #'as yet unclassified' }
VMBSPNode >> asCollectionOfSectors [
	| collection |
	
	collection := OrderedCollection new.
	
	leftChild ifNotNil: [ collection addAll: leftChild asCollectionOfSectors ].
	rightChild ifNotNil: [ collection addAll: rightChild asCollectionOfSectors ].
	
	^collection

]

{ #category : #accessing }
VMBSPNode >> bounds [
	^ leftChild bounds merge: rightChild bounds
]

{ #category : #accessing }
VMBSPNode >> findSectorByLineSeg: aLineSeg [
	| temp |
	hyperplane fuzzyPoint: aLineSeg pointA
		ifOnLeftSideDo: [
			hyperplane fuzzyPoint: aLineSeg pointB
				ifOnLeftSideDo: [ Transcript show: 'left (l-l)'; cr. ^leftChild findSectorByLineSeg: aLineSeg ]
				ifOnRightSideDo: [ Transcript show: 'nil (l-r)'; cr. ^nil ]
				ifOnLineDo:[ Transcript show: 'left(l-o)'; cr. ^leftChild findSectorByLineSeg: aLineSeg ].
		]
		ifOnRightSideDo: [
			hyperplane fuzzyPoint: aLineSeg pointB
				ifOnLeftSideDo: [ Transcript show: 'nil (r-l)'; cr. ^nil ]
				ifOnRightSideDo: [ Transcript show: 'right(r-r)'; cr. ^rightChild findSectorByLineSeg: aLineSeg ]
				ifOnLineDo:[ Transcript show: 'right(r-o)'; cr. ^rightChild findSectorByLineSeg: aLineSeg ].
		]
		ifOnLineDo:[
			Transcript show: 'online(o-o)'; cr.
			temp := rightChild findSectorByLineSeg: aLineSeg.
			temp ifNotNil: [ Transcript show: 'left tree'; cr. ^temp ].
			temp := leftChild findSectorByLineSeg: aLineSeg.
			temp ifNotNil: [ Transcript show: 'right tree'; cr. ^temp ].
			Transcript show: 'tree nil'; cr.
			^nil.
		].

]

{ #category : #accessing }
VMBSPNode >> findSectorsByLineSeg: aLineSeg [
	hyperplane fuzzyPoint: aLineSeg pointA
		ifOnLeftSideDo: [
			hyperplane fuzzyPoint: aLineSeg pointB
				ifOnLeftSideDo: [ Transcript show: 'left (l-l)'; cr. ^leftChild findSectorsByLineSeg: aLineSeg ]
				ifOnRightSideDo: [ Transcript show: 'nil (l-r)'; cr. ^{} ]
				ifOnLineDo:[ Transcript show: 'left(l-o)'; cr. ^leftChild findSectorsByLineSeg: aLineSeg ].
		]
		ifOnRightSideDo: [
			hyperplane fuzzyPoint: aLineSeg pointB
				ifOnLeftSideDo: [ Transcript show: 'nil (r-l)'; cr. ^{} ]
				ifOnRightSideDo: [ Transcript show: 'right(r-r)'; cr. ^rightChild findSectorsByLineSeg: aLineSeg ]
				ifOnLineDo:[ Transcript show: 'right(r-o)'; cr. ^rightChild findSectorsByLineSeg: aLineSeg ].
		]
		ifOnLineDo:[
			| leftResult  rightResult |
			Transcript show: 'online(o-o)'; cr.
			rightResult := rightChild findSectorsByLineSeg: aLineSeg.
			leftResult := leftChild findSectorsByLineSeg: aLineSeg.
			^(OrderedCollection new)
				addAll: leftResult;
				addAll: rightResult;
				yourself.
		].

]

{ #category : #accessing }
VMBSPNode >> hyperplane [
	^hyperplane
]

{ #category : #accessing }
VMBSPNode >> hyperplane: aHyperplane [
	hyperplane := aHyperplane asVMLine.
]

{ #category : #initialization }
VMBSPNode >> initialize [
	super initialize.
	
	leftChild := self class leafClass new.
	leftChild level: level + 1.
	leftChild parent: self.
	rightChild := self class leafClass new.
	rightChild level: level + 1.
	rightChild parent: self.
	

]

{ #category : #operations }
VMBSPNode >> insert: aPolygon [
	| splitter |
	
	splitter := VMPolygonSplitter new.
	splitter split: aPolygon onPlane: hyperplane.
	
	"Transcript
		show: 'splitter left=', splitter leftPolygons size printString;
		show: ', right=', splitter rightPolygons size printString;
		show: ', plane=', hyperplane printString;
		cr.
	splitter leftPolygons do: [ :p |
		Transcript show: '  left: ', p printString; cr.
	].
	splitter rightPolygons do: [ :p |
		Transcript show: '  right: ', p printString; cr.
	]."
	
	splitter leftPolygons do: [ :aSector |
		leftChild := leftChild insert: aSector.
	].
	
	splitter rightPolygons do: [ :aSector |
		rightChild := rightChild insert: aSector.
	].

]

{ #category : #'as yet unclassified' }
VMBSPNode >> isLeaf [
	^false
]

{ #category : #accessing }
VMBSPNode >> leftChild [
	^leftChild
]

{ #category : #accessing }
VMBSPNode >> leftChild: aNodeOrLeaf [
	leftChild := aNodeOrLeaf
]

{ #category : #accessing }
VMBSPNode >> level: anInteger [
	level := anInteger.
	leftChild level: anInteger + 1.
	rightChild level: anInteger + 1.
]

{ #category : #accessing }
VMBSPNode >> rightChild [
	^rightChild
]

{ #category : #accessing }
VMBSPNode >> rightChild: aNodeOrLeaf [
	rightChild := aNodeOrLeaf
]

{ #category : #accessing }
VMBSPNode >> sectorCount [
	^ leftChild sectorCount + rightChild sectorCount
]
