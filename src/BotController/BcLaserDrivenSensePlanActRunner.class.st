"
I am a runner that makes the controller step upon the reception of each laser scan.

Example
bot := BcStopOnFrontObstacleController pureRobulab2.
bot runnerClass: BcLaserDrivenSensePlanActRunner.
bot start.

""Once done perform""
bot stop
"
Class {
	#name : #BcLaserDrivenSensePlanActRunner,
	#superclass : #BcSensePlanActRunner,
	#category : #'BotController-Runners'
}

{ #category : #living }
BcLaserDrivenSensePlanActRunner >> start [
	self body onLaserScanDo: [ self step ]
]

{ #category : #living }
BcLaserDrivenSensePlanActRunner >> stop [
	^self
]
