Class {
	#name : #'Gazebo_msgsLinkStates',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkStates class >> rosTypeDefinition [ 
^' string[] name
 geometry_msgs/Pose[] pose
 geometry_msgs/Twist[] twist
'
]

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkStates class >> rosTypeName [ 
^'gazebo_msgs/LinkStates'
]

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkStates >> initialize [
	super initialize.
	 self name: OrderedCollection new . 
	 self pose: OrderedCollection new . 
	 self twist: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkStates >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkStates >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkStates >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkStates >> pose: aValue [
	^ self at: #pose put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkStates >> twist [
	^ self getAt: #twist. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsLinkStates >> twist: aValue [
	^ self at: #twist put: aValue. 

]
