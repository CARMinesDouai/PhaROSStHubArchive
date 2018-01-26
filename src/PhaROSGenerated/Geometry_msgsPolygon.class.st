Class {
	#name : #'Geometry_msgsPolygon',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsPolygon class >> rosMd5Sum [ 
^'cd60a26494a087f577976f0329fa120e'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPolygon class >> rosTypeDefinition [ 
^' geometry_msgs/Point32[] points
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPolygon class >> rosTypeName [ 
^'geometry_msgs/Polygon'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPolygon class >> typeCreationOrder [ 
^143
]

{ #category : #'as yet unclassified' }
Geometry_msgsPolygon >> initialize [
	super initialize.
	 self points: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPolygon >> points [
	^ self getAt: #points. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPolygon >> points: aValue [
	^ self at: #points put: aValue. 

]
