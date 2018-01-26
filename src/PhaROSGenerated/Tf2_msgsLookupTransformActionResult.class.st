Class {
	#name : #'Tf2_msgsLookupTransformActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionResult class >> rosMd5Sum [ 
^'ac26ce75a41384fa8bb4dc10f491ab90'
]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionResult class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 tf2_msgs/LookupTransformResult result
'
]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionResult class >> rosTypeName [ 
^'tf2_msgs/LookupTransformActionResult'
]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionResult class >> typeCreationOrder [ 
^371
]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Tf2_msgsLookupTransformResult new. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
