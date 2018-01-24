Class {
	#name : #'Move_base_msgsMoveBaseActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionResult class >> rosMd5Sum [ 
^'1eb06eeff08fa7ea874431638cb52332'
]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionResult class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 move_base_msgs/MoveBaseResult result
'
]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionResult class >> rosTypeName [ 
^'move_base_msgs/MoveBaseActionResult'
]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Move_base_msgsMoveBaseResult new. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Move_base_msgsMoveBaseActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
