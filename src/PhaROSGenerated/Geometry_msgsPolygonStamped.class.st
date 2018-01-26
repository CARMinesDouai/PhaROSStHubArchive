Class {
	#name : #'Geometry_msgsPolygonStamped',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsPolygonStamped class >> rosMd5Sum [ 
^'c6be8f7dc3bee7fe9e8d296070f53340'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPolygonStamped class >> rosTypeDefinition [ 
^' std_msgs/Header header
 geometry_msgs/Polygon polygon
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPolygonStamped class >> rosTypeName [ 
^'geometry_msgs/PolygonStamped'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPolygonStamped class >> typeCreationOrder [ 
^144
]

{ #category : #'as yet unclassified' }
Geometry_msgsPolygonStamped >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPolygonStamped >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPolygonStamped >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self polygon: Geometry_msgsPolygon new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPolygonStamped >> polygon [
	^ self getAt: #polygon. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPolygonStamped >> polygon: aValue [
	^ self at: #polygon put: aValue. 

]
