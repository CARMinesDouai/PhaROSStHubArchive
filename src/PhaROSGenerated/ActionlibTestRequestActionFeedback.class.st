Class {
	#name : #ActionlibTestRequestActionFeedback,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionFeedback class >> rosMd5Sum [ 
^'aae20e09065c3809e8a8e87c4c8953fd'
]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 actionlib/TestRequestFeedback feedback
'
]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionFeedback class >> rosTypeName [ 
^'actionlib/TestRequestActionFeedback'
]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionFeedback class >> typeCreationOrder [ 
^15
]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: ActionlibTestRequestFeedback new. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
