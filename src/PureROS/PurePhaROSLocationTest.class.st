"
Test that we are sending the propper messages
"
Class {
	#name : #PurePhaROSLocationTest,
	#superclass : #TestCase,
	#category : #'PureROS-Controllers-Tests'
}

{ #category : #'as yet unclassified' }
PurePhaROSLocationTest >> testSetPose [
	| controller messageTracker messages |
	messageTracker := PureROSMessageRegisterForTests new.
	controller := PurePhaROSLocation for: messageTracker.
	controller setPose: Object.
	
	messages := (messageTracker messages collect:#selector).
	
	self assert: (messages includes:  #localizationService).
	self assert: (messages includes:  #pose:).
	self deny: (messages includes:  #suggest:).
]

{ #category : #'as yet unclassified' }
PurePhaROSLocationTest >> testSuggestPose [
	| controller messageTracker messages |
	messageTracker := PureROSMessageRegisterForTests new.
	controller := PurePhaROSLocation for: messageTracker.
	controller suggestPose: Object.
	
	messages := (messageTracker messages collect:#selector).
	
	self assert: (messages includes:  #localizationService).
	self assert: (messages includes:  #suggest:).
	self deny: (messages includes:  #pose:).
]
