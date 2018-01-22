Class {
	#name : #'Gazebo_msgsLinkState',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
