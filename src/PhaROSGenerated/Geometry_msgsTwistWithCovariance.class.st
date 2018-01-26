Class {
	#name : #'Geometry_msgsTwistWithCovariance',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovariance class >> rosMd5Sum [ 
^'1fe8a28e6890a4cc3ae4c3ca5c7d82e6'
]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovariance class >> rosTypeDefinition [ 
^' geometry_msgs/Twist twist
 float64[36]  covariance
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovariance class >> rosTypeName [ 
^'geometry_msgs/TwistWithCovariance'
]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovariance class >> typeCreationOrder [ 
^153
]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovariance >> covariance [
	^ self getAt: #covariance. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovariance >> covariance: aValue [
	^ self at: #covariance put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovariance >> initialize [
	super initialize.
	 self twist: Geometry_msgsTwist new. 
	 self covariance:  (OrderedCollection new: 36). 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovariance >> twist [
	^ self getAt: #twist. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovariance >> twist: aValue [
	^ self at: #twist put: aValue. 

]
