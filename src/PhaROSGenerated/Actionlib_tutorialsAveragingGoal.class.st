Class {
	#name : #'Actionlib_tutorialsAveragingGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingGoal class >> rosTypeDefinition [ 
^' int32 samples
'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingGoal class >> rosTypeName [ 
^'actionlib_tutorials/AveragingGoal'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingGoal >> initialize [
	super initialize.
	 self samples: 0. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingGoal >> samples [
	^ self getAt: #samples. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingGoal >> samples: aValue [
	^ self at: #samples put: aValue. 

]
