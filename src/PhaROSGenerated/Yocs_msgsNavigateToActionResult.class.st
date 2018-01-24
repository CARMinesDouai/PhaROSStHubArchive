Class {
	#name : #'Yocs_msgsNavigateToActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionResult class >> rosMd5Sum [ 
^'8b1c61040f1b5f7e7ce4bb6b2de470b0'
]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionResult class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 yocs_msgs/NavigateToResult result
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionResult class >> rosTypeName [ 
^'yocs_msgs/NavigateToActionResult'
]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Yocs_msgsNavigateToResult new. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
