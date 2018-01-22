Class {
	#name : #'Yocs_msgsLocalizeActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionResult class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 yocs_msgs/LocalizeResult result
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionResult class >> rosTypeName [ 
^'yocs_msgs/LocalizeActionResult'
]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Yocs_msgsLocalizeResult new. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
