Class {
	#name : #'Actionlib_msgsGoalID',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalID class >> rosMd5Sum [ 
^'302881f31927c1df708a2dbab0e80ee8'
]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalID class >> rosTypeDefinition [ 
^' time stamp
 string id
'
]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalID class >> rosTypeName [ 
^'actionlib_msgs/GoalID'
]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalID >> id [
	^ self getAt: #id. 

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalID >> id: aValue [
	^ self at: #id put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalID >> initialize [
	super initialize.
	 self stamp:  PhaROSTimestamp now. 
	 self id: ''. 

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalID >> stamp [
	^ self getAt: #stamp. 

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalID >> stamp: aValue [
	^ self at: #stamp put: aValue. 

]
