Class {
	#name : #'Control_msgsGripperCommandActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionResult class >> rosMd5Sum [ 
^'143702cb2df0f163c5283cedc5efc6b6'
]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionResult class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 control_msgs/GripperCommandResult result
'
]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionResult class >> rosTypeName [ 
^'control_msgs/GripperCommandActionResult'
]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Control_msgsGripperCommandResult new. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Control_msgsGripperCommandActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
