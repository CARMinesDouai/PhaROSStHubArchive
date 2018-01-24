Class {
	#name : #ActionlibTestGoal,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTestGoal class >> rosMd5Sum [ 
^'18df0149936b7aa95588e3862476ebde'
]

{ #category : #'as yet unclassified' }
ActionlibTestGoal class >> rosTypeDefinition [ 
^' int32 goal
'
]

{ #category : #'as yet unclassified' }
ActionlibTestGoal class >> rosTypeName [ 
^'actionlib/TestGoal'
]

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
