Class {
	#name : #RrSingleVectorDisplayController,
	#superclass : #RrVectorDisplayController,
	#traits : 'TChaDefaultInputComponent',
	#classTraits : 'TChaDefaultInputComponent classTrait',
	#category : #'ReactiveRobot-00-SensorViewer'
}

{ #category : #acting }
RrSingleVectorDisplayController >> draw: aVector [
	self display 
		erase;
		draw: aVector
]

{ #category : #acting }
RrSingleVectorDisplayController >> input: aVector [
	self setUpDisplay.
	self draw: aVector
]
