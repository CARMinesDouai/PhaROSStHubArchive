"
I am a body of robot. I have an BGSOmnidirectionalRangeSensor that allows me to explore cells all arround my position.
"
Class {
	#name : #BGSRangeSensorBeltRobotBody,
	#superclass : #BGSRobotBody,
	#category : #'BOSS-Exploration'
}

{ #category : #'initialize-release' }
BGSRangeSensorBeltRobotBody >> initParts [
	super initParts.
	BGSOmnidirectionalRangeSensor botBody: self name: #rangeSensorBelt 

]
