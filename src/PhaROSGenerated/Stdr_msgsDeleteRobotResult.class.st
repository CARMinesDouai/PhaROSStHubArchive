Class {
	#name : #'Stdr_msgsDeleteRobotResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotResult class >> rosTypeDefinition [ 
^' bool success
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotResult class >> rosTypeName [ 
^'stdr_msgs/DeleteRobotResult'
]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotResult >> initialize [
	super initialize.
	 self success: false. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotResult >> success [
	^ self getAt: #success. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsDeleteRobotResult >> success: aValue [
	^ self at: #success put: aValue. 

]
