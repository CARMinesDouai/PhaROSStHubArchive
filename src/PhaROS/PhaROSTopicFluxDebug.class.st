Class {
	#name : #PhaROSTopicFluxDebug,
	#superclass : #PhaROSTopicFlux,
	#category : #'PhaROS-MessageAdapter'
}

{ #category : #'as yet unclassified' }
PhaROSTopicFluxDebug >> receive: aMessage from: aChannel [
	self halt.
	(self imInterestedIn: aMessage from: aChannel) ifTrue: [
		self redirect: (self adapt: aMessage ) from: aChannel.
	].



]
