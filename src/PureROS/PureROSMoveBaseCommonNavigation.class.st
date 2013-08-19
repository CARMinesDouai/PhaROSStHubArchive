Class {
	#name : #PureROSMoveBaseCommonNavigation,
	#superclass : #PhaROSStaticNodelet,
	#category : #'PureROS-Nodelets'
}

{ #category : #'as yet unclassified' }
PureROSMoveBaseCommonNavigation >> goTo: anEntity [
	self nodelets moveBase client goTo: anEntity center asPose.
]
