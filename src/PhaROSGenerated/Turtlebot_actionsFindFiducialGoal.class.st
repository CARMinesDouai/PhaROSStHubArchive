Class {
	#name : #'Turtlebot_actionsFindFiducialGoal',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialGoal class >> asymmetric_circles_grid [
	^3

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialGoal class >> chessboard [
	^1

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialGoal class >> circles_grid [
	^2

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialGoal >> camera_name [
	^ self getAt: #camera_name. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialGoal >> camera_name: aValue [
	^ self at: #camera_name put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialGoal >> initialize [
	super initialize.
	 self camera_name: ''. 
	 self pattern_width: 0. 
	 self pattern_height: 0. 
	 self pattern_size: 0.0. 
	 self pattern_type: 0. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialGoal >> pattern_height [
	^ self getAt: #pattern_height. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialGoal >> pattern_height: aValue [
	^ self at: #pattern_height put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialGoal >> pattern_size [
	^ self getAt: #pattern_size. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialGoal >> pattern_size: aValue [
	^ self at: #pattern_size put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialGoal >> pattern_type [
	^ self getAt: #pattern_type. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialGoal >> pattern_type: aValue [
	^ self at: #pattern_type put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialGoal >> pattern_width [
	^ self getAt: #pattern_width. 

]

{ #category : #'as yet unclassified' }
Turtlebot_actionsFindFiducialGoal >> pattern_width: aValue [
	^ self at: #pattern_width put: aValue. 

]
