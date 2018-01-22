Class {
	#name : #'Stdr_msgsSpawnRobotResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotResult class >> rosTypeDefinition [ 
^' stdr_msgs/RobotIndexedMsg indexedDescription
 string message
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotResult class >> rosTypeName [ 
^'stdr_msgs/SpawnRobotResult'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotResult >> indexedDescription [
	^ self getAt: #indexedDescription. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotResult >> indexedDescription: aValue [
	^ self at: #indexedDescription put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotResult >> initialize [
	super initialize.
	 self indexedDescription: Stdr_msgsRobotIndexedMsg new. 
	 self message: ''. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotResult >> message [
	^ self getAt: #message. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotResult >> message: aValue [
	^ self at: #message put: aValue. 

]
