Class {
	#name : #'Yocs_msgsNavigateToGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToGoal class >> approach_near [
	^11

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToGoal class >> approach_on [
	^12

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToGoal class >> rosTypeDefinition [ 
^' int8 APPROACH_NEAR=11
 int8 APPROACH_ON=12
 string location
 int8 approach_type
 int8 num_retry
 float32 timeout
 float32 distance
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToGoal class >> rosTypeName [ 
^'yocs_msgs/NavigateToGoal'
]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToGoal >> approach_type [
	^ self getAt: #approach_type. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToGoal >> approach_type: aValue [
	^ self at: #approach_type put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToGoal >> distance [
	^ self getAt: #distance. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToGoal >> distance: aValue [
	^ self at: #distance put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToGoal >> initialize [
	super initialize.
	 self location: ''. 
	 self approach_type: 0. 
	 self num_retry: 0. 
	 self timeout: 0.0. 
	 self distance: 0.0. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToGoal >> location [
	^ self getAt: #location. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToGoal >> location: aValue [
	^ self at: #location put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToGoal >> num_retry [
	^ self getAt: #num_retry. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToGoal >> num_retry: aValue [
	^ self at: #num_retry put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToGoal >> timeout [
	^ self getAt: #timeout. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToGoal >> timeout: aValue [
	^ self at: #timeout put: aValue. 

]
