Class {
	#name : #PhaROSOneTimeSpaceEvent,
	#superclass : #PhaROSSpaceEvent,
	#category : #'PhaROS-Nodelets-Localizer'
}

{ #category : #'as yet unclassified' }
PhaROSOneTimeSpaceEvent >> executeAction: aLocalizerMeasure [ 
	super executeAction: aLocalizerMeasure.
	manager remove: self.
]
