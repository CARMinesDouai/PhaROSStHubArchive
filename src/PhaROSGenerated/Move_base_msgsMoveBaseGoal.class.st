Class {
	#name : #'Move_base_msgsMoveBaseGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
