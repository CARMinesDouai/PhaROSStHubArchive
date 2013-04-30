Class {
	#name : #PureROSPathPlanning,
	#superclass : #PureROSBasicExperiment,
	#category : #'PureROS-Experiments'
}

{ #category : #'as yet unclassified' }
PureROSPathPlanning >> setup [
	self launch: 'path_planning.launch'.
	
	" Output "
	self configureLaser.
	self configureTFIn: '/base_link' withParent: '/odom'.

	
	
	pureros 
]
