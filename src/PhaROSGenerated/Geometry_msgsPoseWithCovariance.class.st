Class {
	#name : #'Geometry_msgsPoseWithCovariance',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsPoseWithCovariance class >> rosMd5Sum [ 
^'c23e848cf1b7533a8d7c259073a97e6f'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseWithCovariance class >> rosTypeDefinition [ 
^' geometry_msgs/Pose pose
 float64[36]  covariance
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseWithCovariance class >> rosTypeName [ 
^'geometry_msgs/PoseWithCovariance'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseWithCovariance >> covariance [
	^ self getAt: #covariance. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseWithCovariance >> covariance: aValue [
	^ self at: #covariance put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseWithCovariance >> initialize [
	super initialize.
	 self pose: Geometry_msgsPose new. 
	 self covariance:  (OrderedCollection new: 36). 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseWithCovariance >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseWithCovariance >> pose: aValue [
	^ self at: #pose put: aValue. 

]
