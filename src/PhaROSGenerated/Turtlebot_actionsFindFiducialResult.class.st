Class {
	#name : #'Turtlebot_actionsFindFiducialResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialResult class >> rosMd5Sum [ 
^'3f8930d968a3e84d471dff917bb1cdae'
]

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
Turtlebot_actionsFindFiducialResult class >> typeCreationOrder [ 
^392
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
