Class {
	#name : #'Geometry_msgsTwistWithCovarianceStamped',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovarianceStamped class >> rosMd5Sum [ 
^'8927a1a12fb2607ceea095b2dc440a96'
]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovarianceStamped class >> rosTypeDefinition [ 
^' std_msgs/Header header
 geometry_msgs/TwistWithCovariance twist
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovarianceStamped class >> rosTypeName [ 
^'geometry_msgs/TwistWithCovarianceStamped'
]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovarianceStamped class >> typeCreationOrder [ 
^154
]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovarianceStamped >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovarianceStamped >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovarianceStamped >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self twist: Geometry_msgsTwistWithCovariance new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovarianceStamped >> twist [
	^ self getAt: #twist. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistWithCovarianceStamped >> twist: aValue [
	^ self at: #twist put: aValue. 

]
