Class {
	#name : #ActionlibTestActionResult,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTestActionResult class >> rosMd5Sum [ 
^'3d669e3a63aa986c667ea7b0f46ce85e'
]

{ #category : #'as yet unclassified' }
ActionlibTestActionResult class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 actionlib/TestResult result
'
]

{ #category : #'as yet unclassified' }
ActionlibTestActionResult class >> rosTypeName [ 
^'actionlib/TestActionResult'
]

{ #category : #'as yet unclassified' }
ActionlibTestActionResult class >> typeCreationOrder [ 
^6
]

{ #category : #'as yet unclassified' }
ActionlibTestActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
ActionlibTestActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: ActionlibTestResult new. 

]

{ #category : #'as yet unclassified' }
ActionlibTestActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
ActionlibTestActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
ActionlibTestActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
