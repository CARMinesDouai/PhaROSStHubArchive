Class {
	#name : #PhaROSTurtlesimNodelet,
	#superclass : #PhaROSStaticNodelet,
	#category : #'PhaROS-Nodelets-Turtlebot'
}

{ #category : #'as yet unclassified' }
PhaROSTurtlesimNodelet >> configure [
	self packages use: PhaROSTransformationNodelet as: #transformation.
	self packages use: SGROSStarGazerPackage as: #stargazer.
	self packages use: PhaROSLocalizerNodelet as: #localizer.
]
