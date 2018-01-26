Class {
	#name : #'Actionlib_tutorialsAveragingActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionResult class >> rosMd5Sum [ 
^'8672cb489d347580acdcd05c5d497497'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionResult class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 actionlib_tutorials/AveragingResult result
'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionResult class >> rosTypeName [ 
^'actionlib_tutorials/AveragingActionResult'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionResult class >> typeCreationOrder [ 
^28
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Actionlib_tutorialsAveragingResult new. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
