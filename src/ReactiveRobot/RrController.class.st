Class {
	#name : #RrController,
	#superclass : #Object,
	#instVars : [
		'robot'
	],
	#category : #'ReactiveRobot-Kernel'
}

{ #category : #accessing }
RrController >> robot [
	^ robot
]

{ #category : #accessing }
RrController >> robot: aRobot [
	robot := aRobot.

]

{ #category : #acting }
RrController >> shutdown [
	self robot shutdown
]

{ #category : #acting }
RrController >> start [
	self subclassResponsibility 
]

{ #category : #acting }
RrController >> stop [
	self robot 
		stop;
		stopAllSensors
]
