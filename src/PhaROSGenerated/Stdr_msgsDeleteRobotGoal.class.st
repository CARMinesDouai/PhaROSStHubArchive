Class {
	#name : #'Stdr_msgsDeleteRobotGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
