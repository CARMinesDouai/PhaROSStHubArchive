Class {
	#name : #'Stdr_msgsDeleteRobotActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionResult class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 stdr_msgs/DeleteRobotResult result
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionResult class >> rosTypeName [ 
^'stdr_msgs/DeleteRobotActionResult'
]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Stdr_msgsDeleteRobotResult new. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
