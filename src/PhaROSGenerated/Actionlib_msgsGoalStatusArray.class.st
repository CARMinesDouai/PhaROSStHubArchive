Class {
	#name : #'Actionlib_msgsGoalStatusArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatusArray class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus[] status_list
'
]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatusArray class >> rosTypeName [ 
^'actionlib_msgs/GoalStatusArray'
]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatusArray >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatusArray >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatusArray >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status_list: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatusArray >> status_list [
	^ self getAt: #status_list. 

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatusArray >> status_list: aValue [
	^ self at: #status_list put: aValue. 

]
