Class {
	#name : #'Pcl_msgsVertices',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Pcl_msgsVertices class >> rosMd5Sum [ 
^'39bd7b1c23763ddd1b882b97cb7cfe11'
]

{ #category : #'as yet unclassified' }
Pcl_msgsVertices class >> rosTypeDefinition [ 
^' int32[] vertices
'
]

{ #category : #'as yet unclassified' }
Pcl_msgsVertices class >> rosTypeName [ 
^'pcl_msgs/Vertices'
]

{ #category : #'as yet unclassified' }
Pcl_msgsVertices >> initialize [
	super initialize.
	 self vertices: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Pcl_msgsVertices >> vertices [
	^ self getAt: #vertices. 

]

{ #category : #'as yet unclassified' }
Pcl_msgsVertices >> vertices: aValue [
	^ self at: #vertices put: aValue. 

]
