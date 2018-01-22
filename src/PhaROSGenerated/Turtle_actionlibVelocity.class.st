Class {
	#name : #'Turtle_actionlibVelocity',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtle_actionlibVelocity class >> rosTypeDefinition [ 
^' float32 linear
 float32 angular
'
]

{ #category : #'as yet unclassified' }
Turtle_actionlibVelocity class >> rosTypeName [ 
^'turtle_actionlib/Velocity'
]

{ #category : #'as yet unclassified' }
Turtle_actionlibVelocity >> angular [
	^ self getAt: #angular. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibVelocity >> angular: aValue [
	^ self at: #angular put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibVelocity >> initialize [
	super initialize.
	 self linear: 0.0. 
	 self angular: 0.0. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibVelocity >> linear [
	^ self getAt: #linear. 

]

{ #category : #'as yet unclassified' }
Turtle_actionlibVelocity >> linear: aValue [
	^ self at: #linear put: aValue. 

]
