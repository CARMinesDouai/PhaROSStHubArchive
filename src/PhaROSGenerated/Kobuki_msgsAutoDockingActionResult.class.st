Class {
	#name : #'Kobuki_msgsAutoDockingActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionResult class >> rosMd5Sum [ 
^'3fb2b9cd9cec6b4cb23b224521dd7679'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionResult class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 kobuki_msgs/AutoDockingResult result
'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionResult class >> rosTypeName [ 
^'kobuki_msgs/AutoDockingActionResult'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Kobuki_msgsAutoDockingResult new. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
