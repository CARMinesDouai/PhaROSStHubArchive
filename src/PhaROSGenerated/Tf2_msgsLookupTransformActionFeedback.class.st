Class {
	#name : #'Tf2_msgsLookupTransformActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Tf2_msgsLookupTransformFeedback new. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
