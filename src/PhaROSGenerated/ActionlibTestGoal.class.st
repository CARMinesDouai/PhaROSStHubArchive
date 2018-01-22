Class {
	#name : #ActionlibTestGoal,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTestGoal >> goal [
	^ self getAt: #goal. 

]

{ #category : #'as yet unclassified' }
ActionlibTestGoal >> goal: aValue [
	^ self at: #goal put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTestGoal >> initialize [
	super initialize.
	 self goal: 0. 

]
