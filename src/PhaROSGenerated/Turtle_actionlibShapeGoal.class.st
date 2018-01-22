Class {
	#name : #'Turtle_actionlibShapeGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeGoal >> edges [
	^ self getAt: #edges. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeGoal >> edges: aValue [
	^ self at: #edges put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeGoal >> initialize [
	super initialize.
	 self edges: 0. 
	 self radius: 0.0. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeGoal >> radius [
	^ self getAt: #radius. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibShapeGoal >> radius: aValue [
	^ self at: #radius put: aValue. 

]
