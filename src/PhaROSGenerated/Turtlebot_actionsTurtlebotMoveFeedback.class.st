Class {
	#name : #'Turtlebot_actionsTurtlebotMoveFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveFeedback class >> rosMd5Sum [ 
^'c971f114b08a2a1ad79af4c9ca9f358c'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveFeedback class >> rosTypeDefinition [ 
^' float32 turn_distance
 float32 forward_distance
'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveFeedback class >> rosTypeName [ 
^'turtlebot_actions/TurtlebotMoveFeedback'
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveFeedback class >> typeCreationOrder [ 
^401
]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveFeedback >> forward_distance [
	^ self getAt: #forward_distance. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveFeedback >> forward_distance: aValue [
	^ self at: #forward_distance put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveFeedback >> initialize [
	super initialize.
	 self turn_distance: 0.0. 
	 self forward_distance: 0.0. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveFeedback >> turn_distance [
	^ self getAt: #turn_distance. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsTurtlebotMoveFeedback >> turn_distance: aValue [
	^ self at: #turn_distance put: aValue. 

]
