Class {
	#name : #PhaROSOneTimeSpaceEvent,
	#superclass : #PhaROSSpaceEvent,
	#category : #PhaROSNodeletsLocalizer
}

{ #category : #'as yet unclassified' }
PhaROSOneTimeSpaceEvent >> executeAction: aLocalizerMeasure [ 
	super executeAction: aLocalizerMeasure.
	manager remove: self.
]
