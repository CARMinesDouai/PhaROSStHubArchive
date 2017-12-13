Class {
	#name : #BcTurtleBot,
	#superclass : #BcRosTwoWheelBody,
	#category : #'BotController-Body'
}

{ #category : #accessing }
BcTurtleBot >> interWheelsDistance [
	^0.23
]

{ #category : #accessing }
BcTurtleBot >> maxForwardLateralSpeed [
	^0.5
]

{ #category : #accessing }
BcTurtleBot >> minBackwardLateralSpeed [
	^ -0.1
]

{ #category : #accessing }
BcTurtleBot >> minForwardLateralSpeed [
	^ 0.1
]
