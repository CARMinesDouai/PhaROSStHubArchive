Class {
	#name : #'Stdr_msgsRegisterRobotResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotResult class >> rosMd5Sum [ 
^'918af704950f3898fd078737c940764a'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotResult class >> rosTypeDefinition [ 
^' stdr_msgs/RobotMsg description
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotResult class >> rosTypeName [ 
^'stdr_msgs/RegisterRobotResult'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotResult class >> typeCreationOrder [ 
^342
]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotResult >> description [
	^ self getAt: #description. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotResult >> description: aValue [
	^ self at: #description put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRegisterRobotResult >> initialize [
	super initialize.
	 self description: Stdr_msgsRobotMsg new. 

]
