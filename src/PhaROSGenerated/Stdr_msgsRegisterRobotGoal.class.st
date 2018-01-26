Class {
	#name : #'Stdr_msgsRegisterRobotGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotGoal class >> rosMd5Sum [ 
^'c1f3d28f1b044c871e6eff2e9fc3c667'
]

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
Stdr_msgsRegisterRobotGoal class >> typeCreationOrder [ 
^335
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
