Class {
	#name : #'Shape_msgsMesh',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Shape_msgsMesh class >> rosMd5Sum [ 
^'1ffdae9486cd3316a121c578b47a85cc'
]

{ #category : #'as yet unclassified' }
Shape_msgsMesh class >> rosTypeDefinition [ 
^' shape_msgs/MeshTriangle[] triangles
 geometry_msgs/Point[] vertices
'
]

{ #category : #'as yet unclassified' }
Shape_msgsMesh class >> rosTypeName [ 
^'shape_msgs/Mesh'
]

{ #category : #'as yet unclassified' }
Shape_msgsMesh >> initialize [
	super initialize.
	 self triangles: OrderedCollection new . 
	 self vertices: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Shape_msgsMesh >> triangles [
	^ self getAt: #triangles. 

]

{ #category : #'as yet unclassified' }
Shape_msgsMesh >> triangles: aValue [
	^ self at: #triangles put: aValue. 

]

{ #category : #'as yet unclassified' }
Shape_msgsMesh >> vertices [
	^ self getAt: #vertices. 

]

{ #category : #'as yet unclassified' }
Shape_msgsMesh >> vertices: aValue [
	^ self at: #vertices put: aValue. 

]
