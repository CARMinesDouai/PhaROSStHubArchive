Class {
	#name : #BGSWirelessEnabledRangeSensorBeltRobotBody,
	#superclass : #BGSRangeSensorBeltRobotBody,
	#category : #'BOSS-Exploration-Example'
}

{ #category : #defaults }
BGSWirelessEnabledRangeSensorBeltRobotBody >> defaultWirelessRange [ 
	^10
]

{ #category : #'initialize-release' }
BGSWirelessEnabledRangeSensorBeltRobotBody >> initParts [
	super initParts.
	BGSWireless botBody: self name: #wireless range: self defaultWirelessRange 

]
