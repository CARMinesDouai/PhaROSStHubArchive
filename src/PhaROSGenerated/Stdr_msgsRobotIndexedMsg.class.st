Class {
	#name : #'Stdr_msgsRobotIndexedMsg',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsRobotIndexedMsg class >> rosTypeDefinition [ 
^' string name
 stdr_msgs/RobotMsg robot
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotIndexedMsg class >> rosTypeName [ 
^'stdr_msgs/RobotIndexedMsg'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotIndexedMsg >> initialize [
	super initialize.
	 self name: ''. 
	 self robot: Stdr_msgsRobotMsg new. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotIndexedMsg >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotIndexedMsg >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotIndexedMsg >> robot [
	^ self getAt: #robot. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRobotIndexedMsg >> robot: aValue [
	^ self at: #robot put: aValue. 

]
