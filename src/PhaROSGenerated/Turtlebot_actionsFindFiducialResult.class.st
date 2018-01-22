Class {
	#name : #'Turtlebot_actionsFindFiducialResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialResult class >> rosTypeDefinition [ 
^' geometry_msgs/PoseStamped pose
'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialResult class >> rosTypeName [ 
^'turtlebot_actions/FindFiducialResult'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialResult >> initialize [
	super initialize.
	 self pose: Geometry_msgsPoseStamped new. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialResult >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialResult >> pose: aValue [
	^ self at: #pose put: aValue. 

]
