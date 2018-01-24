Class {
	#name : #'Yocs_msgsTrajectory',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectory class >> rosMd5Sum [ 
^'ff318cb77adf15ade6b9b9b13aff3a64'
]

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectory class >> rosTypeDefinition [ 
^' std_msgs/Header header
 string name
 yocs_msgs/Waypoint[] waypoints
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectory class >> rosTypeName [ 
^'yocs_msgs/Trajectory'
]

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectory >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectory >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectory >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self name: ''. 
	 self waypoints: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectory >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectory >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectory >> waypoints [
	^ self getAt: #waypoints. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTrajectory >> waypoints: aValue [
	^ self at: #waypoints put: aValue. 

]
