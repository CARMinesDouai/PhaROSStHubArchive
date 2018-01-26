Class {
	#name : #'Stdr_msgsRegisterRobotActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionResult class >> rosMd5Sum [ 
^'ce3f59972017deeb55ae45b800a1a53d'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionResult class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 stdr_msgs/RegisterRobotResult result
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionResult class >> rosTypeName [ 
^'stdr_msgs/RegisterRobotActionResult'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionResult class >> typeCreationOrder [ 
^343
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Stdr_msgsRegisterRobotResult new. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
