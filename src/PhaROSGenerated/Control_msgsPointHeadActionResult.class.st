Class {
	#name : #'Control_msgsPointHeadActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionResult class >> rosMd5Sum [ 
^'1eb06eeff08fa7ea874431638cb52332'
]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionResult class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 control_msgs/PointHeadResult result
'
]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionResult class >> rosTypeName [ 
^'control_msgs/PointHeadActionResult'
]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionResult class >> typeCreationOrder [ 
^86
]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Control_msgsPointHeadResult new. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Control_msgsPointHeadActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
