Class {
	#name : #'Control_msgsSingleJointPositionActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Control_msgsSingleJointPositionFeedback new. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Control_msgsSingleJointPositionActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
