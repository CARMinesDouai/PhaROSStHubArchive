Class {
	#name : #SGUsageTest,
	#superclass : #TestCase,
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'as yet unclassified' }
SGUsageTest >> testUseStarGazer [

	| stargazer  expectedPose |
	stargazer := StarGazer default.
		
		
	expectedPose := SGPose position: (SGPoint x: 0 y: 0 z: 0)  orientation: (Float pi /2).
	self assert: stargazer lastKnownPosition = expectedPose . 
	
	self assert: (stargazer lastMark = SGLandMark id: 1 height: 2.5 mts  pose:  expectedPose).
	
	
	
	
]
