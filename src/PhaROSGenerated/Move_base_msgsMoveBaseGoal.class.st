Class {
	#name : #'Move_base_msgsMoveBaseGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseGoal class >> rosMd5Sum [ 
^'257d089627d7eb7136c24d3593d05a16'
]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseGoal class >> rosTypeDefinition [ 
^' geometry_msgs/PoseStamped target_pose
'
]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseGoal class >> rosTypeName [ 
^'move_base_msgs/MoveBaseGoal'
]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseGoal class >> typeCreationOrder [ 
^191
]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseGoal >> initialize [
	super initialize.
	 self target_pose: Geometry_msgsPoseStamped new. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseGoal >> target_pose [
	^ self getAt: #target_pose. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseGoal >> target_pose: aValue [
	^ self at: #target_pose put: aValue. 

]
