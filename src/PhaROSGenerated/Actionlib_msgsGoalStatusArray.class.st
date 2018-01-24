Class {
	#name : #'Actionlib_msgsGoalStatusArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatusArray class >> rosMd5Sum [ 
^'8b2b82f13216d0a8ea88bd3af735e619'
]

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
