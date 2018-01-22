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
