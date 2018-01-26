Class {
	#name : #'Gazebo_msgsLinkState',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkState class >> rosMd5Sum [ 
^'0818ebbf28ce3a08d48ab1eaa7309ebe'
]

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkState class >> rosTypeDefinition [ 
^' string link_name
 geometry_msgs/Pose pose
 geometry_msgs/Twist twist
 string reference_frame
'
]

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkState class >> rosTypeName [ 
^'gazebo_msgs/LinkState'
]

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkState class >> typeCreationOrder [ 
^130
]

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkState >> initialize [
	super initialize.
	 self link_name: ''. 
	 self pose: Geometry_msgsPose new. 
	 self twist: Geometry_msgsTwist new. 
	 self reference_frame: ''. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkState >> link_name [
	^ self getAt: #link_name. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkState >> link_name: aValue [
	^ self at: #link_name put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkState >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkState >> pose: aValue [
	^ self at: #pose put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkState >> reference_frame [
	^ self getAt: #reference_frame. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkState >> reference_frame: aValue [
	^ self at: #reference_frame put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkState >> twist [
	^ self getAt: #twist. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkState >> twist: aValue [
	^ self at: #twist put: aValue. 

]
