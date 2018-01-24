Class {
	#name : #'Nav_msgsGetMapActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionResult class >> rosMd5Sum [ 
^'ac66e5b9a79bb4bbd33dab245236c892'
]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionResult class >> rosTypeDefinition [ 
^' std_msgs/Header header
 actionlib_msgs/GoalStatus status
 nav_msgs/GetMapResult result
'
]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionResult class >> rosTypeName [ 
^'nav_msgs/GetMapActionResult'
]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Nav_msgsGetMapResult new. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
