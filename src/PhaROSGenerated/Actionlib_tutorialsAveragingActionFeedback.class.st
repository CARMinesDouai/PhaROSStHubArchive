Class {
	#name : #'Actionlib_tutorialsAveragingActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionFeedback class >> rosMd5Sum [ 
^'78a4a09241b1791069223ae7ebd5b16b'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionFeedback class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 actionlib_tutorials/AveragingFeedback feedback
'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionFeedback class >> rosTypeName [ 
^'actionlib_tutorials/AveragingActionFeedback'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionFeedback class >> typeCreationOrder [ 
^30
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Actionlib_tutorialsAveragingFeedback new. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
