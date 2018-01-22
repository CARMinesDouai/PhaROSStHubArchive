Class {
	#name : #'Stdr_msgsSpawnRobotGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotGoal >> description [
	^ self getAt: #description. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotGoal >> description: aValue [
	^ self at: #description put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotGoal >> initialize [
	super initialize.
	 self description: Stdr_msgsRobotMsg new. 

]
