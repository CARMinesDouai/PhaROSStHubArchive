Class {
	#name : #'Actionlib_tutorialsFibonacciActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionResult class >> rosMd5Sum [ 
^'bee73a9fe29ae25e966e105f5553dd03'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionResult class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 actionlib_tutorials/FibonacciResult result
'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionResult class >> rosTypeName [ 
^'actionlib_tutorials/FibonacciActionResult'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionResult class >> typeCreationOrder [ 
^35
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Actionlib_tutorialsFibonacciResult new. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsFibonacciActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
