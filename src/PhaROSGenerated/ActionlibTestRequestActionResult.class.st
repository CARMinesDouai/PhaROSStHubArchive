Class {
	#name : #ActionlibTestRequestActionResult,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionResult class >> rosMd5Sum [ 
^'0476d1fdf437a3a6e7d6d0e9f5561298'
]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionResult class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 actionlib/TestRequestResult result
'
]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionResult class >> rosTypeName [ 
^'actionlib/TestRequestActionResult'
]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionResult class >> typeCreationOrder [ 
^13
]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: ActionlibTestRequestResult new. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
ActionlibTestRequestActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
