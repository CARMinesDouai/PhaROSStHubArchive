Class {
	#name : #'Actionlib_tutorialsFibonacciActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionFeedback class >> rosMd5Sum [ 
^'73b8497a9f629a31c0020900e4148f07'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 actionlib_tutorials/FibonacciFeedback feedback
'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionFeedback class >> rosTypeName [ 
^'actionlib_tutorials/FibonacciActionFeedback'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Actionlib_tutorialsFibonacciFeedback new. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
