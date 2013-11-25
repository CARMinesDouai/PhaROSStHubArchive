Class {
	#name : #PureROSRobulabCachedGoal,
	#superclass : #PureROSRobulabGoal,
	#category : #PureROSNodeletsMovement
}

{ #category : #'as yet unclassified' }
PureROSRobulabCachedGoal >> tryAchieveGoal [

	event ifNil: [
		event := robulab nodelets spaceEvents whenLocalizerMeasure:  [ :lm | 
			self hasArrived: lm. 
		] doOnce: [ : lm | 
			self onArrivalToGoal: lm 
		].
	].	
	
	self trajectoryDifferential:  (entity annotation: #lastPose) .
	1 second asDelay wait.
	goal := (robulab nodelets movebase client goTo: entity center asPose).
	
	
]
