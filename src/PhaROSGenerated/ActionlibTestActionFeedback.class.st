Class {
	#name : #ActionlibTestActionFeedback,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTestActionFeedback >> feedback [
	^ self getAt: #feedback. 

]

{ #category : #'as yet unclassified' }
ActionlibTestActionFeedback >> feedback: aValue [
	^ self at: #feedback put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestActionFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
ActionlibTestActionFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestActionFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self feedback: ActionlibTestFeedback new. 

]

{ #category : #'as yet unclassified' }
ActionlibTestActionFeedback >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
ActionlibTestActionFeedback >> status: aValue [
	^ self at: #status put: aValue. 

]
