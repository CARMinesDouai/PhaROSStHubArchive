Class {
	#name : #'Geometry_msgsTwistStamped',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsTwistStamped class >> rosMd5Sum [ 
^'98d34b0043a2093cf9d9345ab6eef12e'
]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistStamped class >> rosTypeDefinition [ 
^' std_msgs/Header header
 geometry_msgs/Twist twist
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistStamped class >> rosTypeName [ 
^'geometry_msgs/TwistStamped'
]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistStamped >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistStamped >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistStamped >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self twist: Geometry_msgsTwist new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistStamped >> twist [
	^ self getAt: #twist. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistStamped >> twist: aValue [
	^ self at: #twist put: aValue. 

]
