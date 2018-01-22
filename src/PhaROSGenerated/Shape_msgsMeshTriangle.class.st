Class {
	#name : #'Shape_msgsMeshTriangle',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Shape_msgsMeshTriangle class >> rosTypeDefinition [ 
^' int32[3]  vertex_indices
'
]

{ #category : #'as yet unclassified' }
Shape_msgsMeshTriangle class >> rosTypeName [ 
^'shape_msgs/MeshTriangle'
]

{ #category : #'as yet unclassified' }
Shape_msgsMeshTriangle >> initialize [
	super initialize.
	 self vertex_indices:  (OrderedCollection new: 3). 

]

{ #category : #'as yet unclassified' }
Shape_msgsMeshTriangle >> vertex_indices [
	^ self getAt: #vertex_indices. 

]

{ #category : #'as yet unclassified' }
Shape_msgsMeshTriangle >> vertex_indices: aValue [
	^ self at: #vertex_indices put: aValue. 

]
