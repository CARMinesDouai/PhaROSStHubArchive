Class {
	#name : #PhaROSTurtlesimPackage,
	#superclass : #PhaROSStaticPackage,
	#category : #'PhaROS-Packages-Turtlebot'
}

{ #category : #'as yet unclassified' }
PhaROSTurtlesimPackage >> configure [
	self packages use: PhaROSTransformationPackage as: #transformation.
	self packages use: SGROSStarGazerPackage as: #stargazer.
	self packages use: PhaROSLocalizerPackage as: #localizer.
]
