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
