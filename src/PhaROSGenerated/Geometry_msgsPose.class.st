Class {
	#name : #'Geometry_msgsPose',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsPose class >> rosTypeDefinition [ 
^' geometry_msgs/Point position
 geometry_msgs/Quaternion orientation
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPose class >> rosTypeName [ 
^'geometry_msgs/Pose'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPose >> initialize [
	super initialize.
	 self position: Geometry_msgsPoint new. 
	 self orientation: Geometry_msgsQuaternion new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPose >> orientation [
	^ self getAt: #orientation. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPose >> orientation: aValue [
	^ self at: #orientation put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPose >> position [
	^ self getAt: #position. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPose >> position: aValue [
	^ self at: #position put: aValue. 

]
