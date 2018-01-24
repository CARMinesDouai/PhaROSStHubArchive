Class {
	#name : #'Turtlebot_actionsTurtlebotMoveResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveResult class >> rosMd5Sum [ 
^'c971f114b08a2a1ad79af4c9ca9f358c'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveResult class >> rosTypeDefinition [ 
^' float32 turn_distance
 float32 forward_distance
'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveResult class >> rosTypeName [ 
^'turtlebot_actions/TurtlebotMoveResult'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveResult >> forward_distance [
	^ self getAt: #forward_distance. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveResult >> forward_distance: aValue [
	^ self at: #forward_distance put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveResult >> initialize [
	super initialize.
	 self turn_distance: 0.0. 
	 self forward_distance: 0.0. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveResult >> turn_distance [
	^ self getAt: #turn_distance. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveResult >> turn_distance: aValue [
	^ self at: #turn_distance put: aValue. 

]
