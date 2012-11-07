Class {
	#name : #TrajectoryService,
	#superclass : #RobulabService,
	#category : #'Pure-Services'
}

{ #category : #'as yet unclassified' }
TrajectoryService >> limitSpeed: aSpeed [
	^ 2.0 min: aSpeed.
	
]

{ #category : #'as yet unclassified' }
TrajectoryService >> moveFrom: aPoint to: anOtherPoint with: aSpeed [
	| x1 y1 x2 y2 speed|
	
	x1 := PDRConverter as64BitsHexStringFromFloat: aPoint x.
	y1 := PDRConverter as64BitsHexStringFromFloat: aPoint y.
	x2 := PDRConverter as64BitsHexStringFromFloat: anOtherPoint x.
	y2 := PDRConverter as64BitsHexStringFromFloat: anOtherPoint y.
	
	speed := PDRConverter as32BitsHexStringFromFloat: (self limitSpeed: aSpeed).
	

	self insert: x1, y1, x2, y2, speed.
]

{ #category : #'as yet unclassified' }
TrajectoryService >> pause [
	self upDate: '2'.
	
]

{ #category : #'as yet unclassified' }
TrajectoryService >> reset [
	self upDate: '3'.
	
]

{ #category : #'as yet unclassified' }
TrajectoryService >> resetDistance [
	self upDate: '5'.
	
]

{ #category : #'as yet unclassified' }
TrajectoryService >> resetPath [
	self upDate: '4'.
	
]

{ #category : #'as yet unclassified' }
TrajectoryService >> status [
	^ self get.
	
]

{ #category : #'as yet unclassified' }
TrajectoryService >> stop [
	self upDate: '0'.
	
]
