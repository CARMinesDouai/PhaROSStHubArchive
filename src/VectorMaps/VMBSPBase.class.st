Class {
	#name : #VMBSPBase,
	#superclass : #Object,
	#instVars : [
		'parent',
		'level'
	],
	#category : #'VectorMaps-Collections, Trees & Graphs'
}

{ #category : #'as yet unclassified' }
VMBSPBase class >> leafClass [
	^VMBSPLeaf
]

{ #category : #'as yet unclassified' }
VMBSPBase class >> nodeClass [
	^VMBSPNode
]

{ #category : #converting }
VMBSPBase >> asCollectionOfSectors [
	"note: the sectors are currently VMPolygon instances, and are NOT converted to VMSector instances here"
	^ self subclassResponsibility
]

{ #category : #converting }
VMBSPBase >> asRenderableElement [
	^ self class rendererClass new model: self
]

{ #category : #accessing }
VMBSPBase >> bounds [
	self subclassResponsibility
]

{ #category : #accessing }
VMBSPBase >> findSectorByLineSeg: aLineSeg [
	"returns the sector with the same line segment (as determined by VMLineSegment isSimilarTo:) or nil if none is found.
	by construction of the tree, at most one sector should contain such a line segment.
	this method is meant to find a neighboring sector by talking a sector border line segment and use this method on its
	reverse counterpart."
	self subclassResponsibility.
]

{ #category : #accessing }
VMBSPBase >> findSectorsByLineSeg: aLineSeg [
	self subclassResponsibility.
]

{ #category : #'GT Inspector' }
VMBSPBase >> gtInspectorRenderedIn: composite [
	<gtInspectorPresentationOrder: 50>
	
	(composite morph)
		title: 'Viewer';
		morph: [
			(VMViewer openWindowlessOn: { self asRenderableElement })
				autozoom.
		].
		
]

{ #category : #initialization }
VMBSPBase >> initialize [
	parent := nil.
	level := 0.
]

{ #category : #operations }
VMBSPBase >> insert: aSectorOrMap [
	self subclassResponsibility
]

{ #category : #accessing }
VMBSPBase >> level [
	^level
]

{ #category : #accessing }
VMBSPBase >> level: anInteger [
	level := anInteger.
]

{ #category : #accessing }
VMBSPBase >> maxDepth [
	^200
]

{ #category : #accessing }
VMBSPBase >> parent [
	^parent
]

{ #category : #accessing }
VMBSPBase >> parent: aNode [
	parent := aNode.
]

{ #category : #accessing }
VMBSPBase >> root [
	parent ifNil: [ ^ self ].
	^ parent root.
]

{ #category : #accessing }
VMBSPBase >> sectorCount [
	self subclassResponsibility.
]
