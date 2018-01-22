Class {
	#name : #'Gazebo_msgsContactState',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Gazebo_msgsContactState class >> rosTypeDefinition [ 
^' string info
 string collision1_name
 string collision2_name
 geometry_msgs/Wrench[] wrenches
 geometry_msgs/Wrench total_wrench
 geometry_msgs/Vector3[] contact_positions
 geometry_msgs/Vector3[] contact_normals
 float64[] depths
'
]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactState class >> rosTypeName [ 
^'gazebo_msgs/ContactState'
]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactState >> collision1_name [
	^ self getAt: #collision1_name. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactState >> collision1_name: aValue [
	^ self at: #collision1_name put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactState >> collision2_name [
	^ self getAt: #collision2_name. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactState >> collision2_name: aValue [
	^ self at: #collision2_name put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactState >> contact_normals [
	^ self getAt: #contact_normals. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactState >> contact_normals: aValue [
	^ self at: #contact_normals put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactState >> contact_positions [
	^ self getAt: #contact_positions. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactState >> contact_positions: aValue [
	^ self at: #contact_positions put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactState >> depths [
	^ self getAt: #depths. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactState >> depths: aValue [
	^ self at: #depths put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactState >> info [
	^ self getAt: #info. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactState >> info: aValue [
	^ self at: #info put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactState >> initialize [
	super initialize.
	 self info: ''. 
	 self collision1_name: ''. 
	 self collision2_name: ''. 
	 self wrenches: OrderedCollection new . 
	 self total_wrench: Geometry_msgsWrench new. 
	 self contact_positions: OrderedCollection new . 
	 self contact_normals: OrderedCollection new . 
	 self depths: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactState >> total_wrench [
	^ self getAt: #total_wrench. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactState >> total_wrench: aValue [
	^ self at: #total_wrench put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactState >> wrenches [
	^ self getAt: #wrenches. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactState >> wrenches: aValue [
	^ self at: #wrenches put: aValue. 

]
