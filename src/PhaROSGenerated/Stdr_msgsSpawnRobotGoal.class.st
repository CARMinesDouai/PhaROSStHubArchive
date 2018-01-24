Class {
	#name : #'Stdr_msgsSpawnRobotGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotGoal class >> rosMd5Sum [ 
^'918af704950f3898fd078737c940764a'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotGoal class >> rosTypeDefinition [ 
^' stdr_msgs/RobotMsg description
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotGoal class >> rosTypeName [ 
^'stdr_msgs/SpawnRobotGoal'
]

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
