Class {
	#name : #ActionlibTwoIntsGoal,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
ActionlibTwoIntsGoal class >> rosMd5Sum [ 
^'36d09b846be0b371c5f190354dd3153e'
]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsGoal class >> rosTypeDefinition [ 
^' int64 a
 int64 b
'
]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsGoal class >> rosTypeName [ 
^'actionlib/TwoIntsGoal'
]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsGoal class >> typeCreationOrder [ 
^17
]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsGoal >> a [
	^ self getAt: #a. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsGoal >> a: aValue [
	^ self at: #a put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsGoal >> b [
	^ self getAt: #b. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsGoal >> b: aValue [
	^ self at: #b put: aValue. 

]

{ #category : #'as yet unclassified' }
ActionlibTwoIntsGoal >> initialize [
	super initialize.
	 self a: 0. 
	 self b: 0. 

]
