Extension { #name : #Collection }

{ #category : #'*VectorMaps' }
Collection >> asVMQuadTree [
	^VMQuadTreeNode fromCollection: self.
]

{ #category : #'*VectorMaps' }
Collection >> asVMQuadTree2 [
	^VMQuadTreeNode2 fromCollection: self.
]
