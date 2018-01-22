Class {
	#name : #'Geometry_msgsTwist',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsTwist class >> rosTypeDefinition [ 
^' geometry_msgs/Vector3 linear
 geometry_msgs/Vector3 angular
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsTwist class >> rosTypeName [ 
^'geometry_msgs/Twist'
]

{ #category : #'as yet unclassified' }
Geometry_msgsTwist >> angular [
	^ self getAt: #angular. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwist >> angular: aValue [
	^ self at: #angular put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwist >> initialize [
	super initialize.
	 self linear: Geometry_msgsVector3 new. 
	 self angular: Geometry_msgsVector3 new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwist >> linear [
	^ self getAt: #linear. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwist >> linear: aValue [
	^ self at: #linear put: aValue. 

]
