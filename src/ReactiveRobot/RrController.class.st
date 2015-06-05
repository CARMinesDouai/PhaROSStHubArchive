Class {
	#name : #RrController,
	#superclass : #ChaComponent,
	#instVars : [
		'robot'
	],
	#category : #'ReactiveRobot-Kernel'
}

{ #category : #accessing }
RrController >> robot [
	^ robot
]

{ #category : #'initialize-release' }
RrController >> robot: aRobot [
	robot := aRobot.

]

{ #category : #acting }
RrController >> shutdown [
	self robot shutdown
]

{ #category : #acting }
RrController >> start [
	self subComponents do: [ :each | each start ] 
]

{ #category : #acting }
RrController >> stop [
	self subComponents do: [ :each | each stop ] 
]

{ #category : #acting }
RrController >> subComponents [
	^{self robot}
]
