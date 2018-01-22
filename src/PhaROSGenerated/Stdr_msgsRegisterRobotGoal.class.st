Class {
	#name : #'Stdr_msgsRegisterRobotGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotGoal class >> rosTypeDefinition [ 
^' string name
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotGoal class >> rosTypeName [ 
^'stdr_msgs/RegisterRobotGoal'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotGoal >> initialize [
	super initialize.
	 self name: ''. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotGoal >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotGoal >> name: aValue [
	^ self at: #name put: aValue. 

]
