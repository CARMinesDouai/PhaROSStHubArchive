Class {
	#name : #'Nav_msgsGetMapActionFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: Nav_msgsGetMapFeedback new. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Nav_msgsGetMapActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
