Class {
	#name : #BcTurtleBot,
	#superclass : #BcRosTwoWheelBody,
	#category : #'BotController-Bodies'
}

{ #category : #accessing }
BcTurtleBot >> interWheelsDistance [
	^0.23
]

{ #category : #accessing }
BcTurtleBot >> minBackwardLateralSpeed [
	^ -0.1
]
