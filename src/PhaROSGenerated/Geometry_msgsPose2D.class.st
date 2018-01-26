Class {
	#name : #'Geometry_msgsPose2D',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsPose2D class >> rosMd5Sum [ 
^'938fa65709584ad8e77d238529be13b8'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPose2D class >> rosTypeDefinition [ 
^' float64 x
 float64 y
 float64 theta
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPose2D class >> rosTypeName [ 
^'geometry_msgs/Pose2D'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPose2D class >> typeCreationOrder [ 
^145
]

{ #category : #'as yet unclassified' }
Geometry_msgsPose2D >> initialize [
	super initialize.
	 self x: 0.0. 
	 self y: 0.0. 
	 self theta: 0.0. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPose2D >> theta [
	^ self getAt: #theta. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPose2D >> theta: aValue [
	^ self at: #theta put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPose2D >> x [
	^ self getAt: #x. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPose2D >> x: aValue [
	^ self at: #x put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPose2D >> y [
	^ self getAt: #y. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPose2D >> y: aValue [
	^ self at: #y put: aValue. 

]
