Class {
	#name : #PureROSGmappings,
	#superclass : #PureROSBasicExperiment,
	#category : #'PureROS-Experiments'
}

{ #category : #'as yet unclassified' }
PureROSGmappings >> configure [
	" Output "
	self configureLaser.
	self configureTFIn: '/base_link' withParent: '/odom'.
	

	
]
