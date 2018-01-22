Class {
	#name : #'Gazebo_msgsContactsState',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Gazebo_msgsContactsState class >> rosTypeDefinition [ 
^' std_msgs/Header header
 gazebo_msgs/ContactState[] states
'
]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactsState class >> rosTypeName [ 
^'gazebo_msgs/ContactsState'
]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactsState >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactsState >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactsState >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self states: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactsState >> states [
	^ self getAt: #states. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsContactsState >> states: aValue [
	^ self at: #states put: aValue. 

]
