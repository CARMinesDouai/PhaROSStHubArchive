Class {
	#name : #'Actionlib_msgsGoalStatus',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatus class >> aborted [
	^4

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatus class >> active [
	^1

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatus class >> lost [
	^9

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatus class >> pending [
	^0

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatus class >> preempted [
	^2

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatus class >> preempting [
	^6

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatus class >> recalled [
	^8

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatus class >> recalling [
	^7

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatus class >> rejected [
	^5

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatus class >> rosMd5Sum [ 
^'d388f9b87b3c471f784434d671988d4a'
]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatus class >> rosTypeDefinition [ 
^' int8 PENDING=0
 int8 ACTIVE=1
 int8 PREEMPTED=2
 int8 SUCCEEDED=3
 int8 ABORTED=4
 int8 REJECTED=5
 int8 PREEMPTING=6
 int8 RECALLING=7
 int8 RECALLED=8
 int8 LOST=9
 actionlib_msgs/GoalID goal_id
 int8 status
 string text
'
]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatus class >> rosTypeName [ 
^'actionlib_msgs/GoalStatus'
]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatus class >> succeeded [
	^3

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatus >> goal_id [
	^ self getAt: #goal_id. 

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatus >> goal_id: aValue [
	^ self at: #goal_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatus >> initialize [
	super initialize.
	 self goal_id: Actionlib_msgsGoalID new. 
	 self status: 0. 
	 self text: ''. 

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatus >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatus >> status: aValue [
	^ self at: #status put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatus >> text [
	^ self getAt: #text. 

]

{ #category : #'as yet unclassified' }
Actionlib_msgsGoalStatus >> text: aValue [
	^ self at: #text put: aValue. 

]
