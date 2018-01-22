Class {
	#name : #ActionlibTwoIntsActionResult,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionResult class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 actionlib/TwoIntsResult result
'
]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionResult class >> rosTypeName [ 
^'actionlib/TwoIntsActionResult'
]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: ActionlibTwoIntsResult new. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
