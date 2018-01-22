Class {
	#name : #'Control_msgsJointTrajectoryActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Control_msgsJointTrajectoryFeedback new. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Control_msgsJointTrajectoryActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
