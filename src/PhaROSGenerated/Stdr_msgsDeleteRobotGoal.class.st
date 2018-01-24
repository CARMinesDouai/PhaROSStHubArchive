Class {
	#name : #'Stdr_msgsDeleteRobotGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotGoal class >> rosMd5Sum [ 
^'c1f3d28f1b044c871e6eff2e9fc3c667'
]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotGoal class >> rosTypeDefinition [ 
^' string name
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotGoal class >> rosTypeName [ 
^'stdr_msgs/DeleteRobotGoal'
]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotGoal >> initialize [
	super initialize.
	 self name: ''. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotGoal >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotGoal >> name: aValue [
	^ self at: #name put: aValue. 

]
