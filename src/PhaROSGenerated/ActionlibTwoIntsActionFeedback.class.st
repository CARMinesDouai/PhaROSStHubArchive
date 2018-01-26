Class {
	#name : #ActionlibTwoIntsActionFeedback,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionFeedback class >> rosMd5Sum [ 
^'aae20e09065c3809e8a8e87c4c8953fd'
]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 actionlib/TwoIntsFeedback feedback
'
]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionFeedback class >> rosTypeName [ 
^'actionlib/TwoIntsActionFeedback'
]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionFeedback class >> typeCreationOrder [ 
^22
]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: ActionlibTwoIntsFeedback new. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
