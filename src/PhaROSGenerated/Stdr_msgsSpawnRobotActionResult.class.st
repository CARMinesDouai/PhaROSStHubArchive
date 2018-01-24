Class {
	#name : #'Stdr_msgsSpawnRobotActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionResult class >> rosMd5Sum [ 
^'f95a810c7b5f2579dca2ec191de2a05c'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionResult class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 stdr_msgs/SpawnRobotResult result
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionResult class >> rosTypeName [ 
^'stdr_msgs/SpawnRobotActionResult'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Stdr_msgsSpawnRobotResult new. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSpawnRobotActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
