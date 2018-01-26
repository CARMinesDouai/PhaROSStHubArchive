Class {
	#name : #'Gazebo_msgsModelStates',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Gazebo_msgsModelStates class >> rosMd5Sum [ 
^'48c080191eb15c41858319b4d8a609c2'
]

{ #category : #'as yet unclassified' }
Gazebo_msgsModelStates class >> rosTypeDefinition [ 
^' string[] name
 geometry_msgs/Pose[] pose
 geometry_msgs/Twist[] twist
'
]

{ #category : #'as yet unclassified' }
Gazebo_msgsModelStates class >> rosTypeName [ 
^'gazebo_msgs/ModelStates'
]

{ #category : #'as yet unclassified' }
Gazebo_msgsModelStates class >> typeCreationOrder [ 
^133
]

{ #category : #'as yet unclassified' }
Gazebo_msgsModelStates >> initialize [
	super initialize.
	 self name: OrderedCollection new . 
	 self pose: OrderedCollection new . 
	 self twist: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsModelStates >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsModelStates >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsModelStates >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsModelStates >> pose: aValue [
	^ self at: #pose put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsModelStates >> twist [
	^ self getAt: #twist. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsModelStates >> twist: aValue [
	^ self at: #twist put: aValue. 

]
