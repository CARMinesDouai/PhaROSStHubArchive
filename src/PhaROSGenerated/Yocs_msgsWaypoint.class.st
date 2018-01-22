Class {
	#name : #'Yocs_msgsWaypoint',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsWaypoint class >> rosTypeDefinition [ 
^' std_msgs/Header header
 string name
 geometry_msgs/Pose pose
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsWaypoint class >> rosTypeName [ 
^'yocs_msgs/Waypoint'
]

{ #category : #'as yet unclassified' }
Yocs_msgsWaypoint >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWaypoint >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWaypoint >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self name: ''. 
	 self pose: Geometry_msgsPose new. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWaypoint >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWaypoint >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWaypoint >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWaypoint >> pose: aValue [
	^ self at: #pose put: aValue. 

]
