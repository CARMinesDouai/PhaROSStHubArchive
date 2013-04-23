Class {
	#name : #PNGController,
	#superclass : #Object,
	#instVars : [
		'robot'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'instance creation' }
PNGController class >> for: aRobot [
	^ self new robot: aRobot ; yourself.
]

{ #category : #'instance creation' }
PNGController class >> kompai1 [
	^self new
		robot: PNGRobulabHandcodedFactory kompai1;
		yourself
]

{ #category : #'instance creation' }
PNGController class >> kompai2 [
	^self new
		robot: PNGRobulabHandcodedFactory kompai2;
		yourself
]

{ #category : #services }
PNGController >> localizationService [ 
	^self robot localizationService
]

{ #category : #accessing }
PNGController >> robot [
	^ robot
]

{ #category : #accessing }
PNGController >> robot: anObject [
	robot := anObject
]

{ #category : #services }
PNGController >> stepService [ 
	^self robot stepService
]

{ #category : #services }
PNGController >> trajectoryService [ 
	^self robot trajectoryService
]
