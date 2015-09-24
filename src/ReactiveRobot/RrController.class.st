Class {
	#name : #RrController,
	#superclass : #ChaComponent,
	#instVars : [
		'robot'
	],
	#category : #'ReactiveRobot-Kernel'
}

{ #category : #acting }
RrController >> defaultForwardSpeed [
	^0.2
]

{ #category : #acting }
RrController >> defaultRotationSpeed [
	^0
]

{ #category : #motion }
RrController >> forwardAt: forwardSpeed [
	^self forwardAt: forwardSpeed rotateAt: 0
]

{ #category : #'forwarding-generated' }
RrController >> forwardAt: a1 rotateAt: a2 [ 
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #robot>

	^robot forwardAt: a1 rotateAt: a2 
]

{ #category : #accessing }
RrController >> robot [
	^ robot
]

{ #category : #'initialize-release' }
RrController >> robot: aRobot [
	robot := aRobot.

]

{ #category : #motion }
RrController >> rotateAt: rotationSpeed [
	^self forwardAt: 0 rotateAt: rotationSpeed 
]

{ #category : #acting }
RrController >> shutdown [
	self robot shutdown
]

{ #category : #acting }
RrController >> start [
	self subComponents do: [ :each | each start ].
	self forwardAt: self defaultForwardSpeed rotateAt: self defaultRotationSpeed.
]

{ #category : #'forwarding-generated' }
RrController >> startMotion [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #robot>

	^robot startMotion
]

{ #category : #acting }
RrController >> stop [
	self subComponents do: [ :each | each stop ] 
]

{ #category : #'forwarding-generated' }
RrController >> stopMotion [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #robot>

	^robot stopMotion
]

{ #category : #acting }
RrController >> subComponents [
	^{self robot}
]
