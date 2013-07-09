Class {
	#name : #PhaROSTurtlesimNodelet,
	#superclass : #PhaROSStaticNodelet,
	#category : #'PhaROS-Nodelets-Turtlebot'
}

{ #category : #'as yet unclassified' }
PhaROSTurtlesimNodelet >> configure [
	self nodelets use: PhaROSTransformationNodelet as: #transformation.
	self nodelets use: SGROSStarGazerNodelet as: #stargazer.
	self nodelets use: PhaROSLocalizerNodelet as: #localizer.
]
