Class {
	#name : #'Geometry_msgsPoseStamped',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsPoseStamped class >> rosMd5Sum [ 
^'d3812c3cbc69362b77dc0b19b345f8f5'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseStamped class >> rosTypeDefinition [ 
^' std_msgs/Header header
 geometry_msgs/Pose pose
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseStamped class >> rosTypeName [ 
^'geometry_msgs/PoseStamped'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseStamped class >> typeCreationOrder [ 
^42
]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseStamped >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseStamped >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseStamped >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self pose: Geometry_msgsPose new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseStamped >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseStamped >> pose: aValue [
	^ self at: #pose put: aValue. 

]
