Class {
	#name : #'Tf2_msgsLookupTransformGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformGoal class >> rosTypeDefinition [ 
^' string target_frame
 string source_frame
 time source_time
 duration timeout
 time target_time
 string fixed_frame
 bool advanced
'
]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformGoal class >> rosTypeName [ 
^'tf2_msgs/LookupTransformGoal'
]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformGoal >> advanced [
	^ self getAt: #advanced. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformGoal >> advanced: aValue [
	^ self at: #advanced put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformGoal >> fixed_frame [
	^ self getAt: #fixed_frame. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformGoal >> fixed_frame: aValue [
	^ self at: #fixed_frame put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformGoal >> initialize [
	super initialize.
	 self target_frame: ''. 
	 self source_frame: ''. 
	 self source_time:  PhaROSTimestamp now. 
	 self timeout:  Duration seconds: 0. 
	 self target_time:  PhaROSTimestamp now. 
	 self fixed_frame: ''. 
	 self advanced: false. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformGoal >> source_frame [
	^ self getAt: #source_frame. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformGoal >> source_frame: aValue [
	^ self at: #source_frame put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformGoal >> source_time [
	^ self getAt: #source_time. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformGoal >> source_time: aValue [
	^ self at: #source_time put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformGoal >> target_frame [
	^ self getAt: #target_frame. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformGoal >> target_frame: aValue [
	^ self at: #target_frame put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformGoal >> target_time [
	^ self getAt: #target_time. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformGoal >> target_time: aValue [
	^ self at: #target_time put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformGoal >> timeout [
	^ self getAt: #timeout. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformGoal >> timeout: aValue [
	^ self at: #timeout put: aValue. 

]
