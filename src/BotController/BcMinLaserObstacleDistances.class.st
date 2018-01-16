Class {
	#name : #BcMinLaserObstacleDistances,
	#superclass : #BcWorldModel,
	#instVars : [
		'sideLeftFront',
		'sideRightFront',
		'sideRightRear',
		'sideLeftRear',
		'frontLeft',
		'frontRight'
	],
	#category : #'BotController-WorldModel'
}

{ #category : #accessing }
BcMinLaserObstacleDistances >> front [
	^self frontLeft min: self frontRight 
]

{ #category : #accessing }
BcMinLaserObstacleDistances >> frontLeft [
	^ frontLeft
]

{ #category : #accessing }
BcMinLaserObstacleDistances >> frontRight [
	^ frontRight
]

{ #category : #testing }
BcMinLaserObstacleDistances >> isFrontEcho: anEcho [
	^anEcho angle abs < 1.05 "Pi/3"
]

{ #category : #testing }
BcMinLaserObstacleDistances >> isLeftEcho: anEcho [
	^anEcho angle > 0 
]

{ #category : #testing }
BcMinLaserObstacleDistances >> isRearEcho: anEcho [
	^anEcho angle abs > 1.57 "Half Pi"
]

{ #category : #accessing }
BcMinLaserObstacleDistances >> left [
	^self frontLeft min: self sideLeft
]

{ #category : #updating }
BcMinLaserObstacleDistances >> min: distance frontEcho: anEcho [
	^distance min: (anEcho distance * anEcho angle cos)

]

{ #category : #updating }
BcMinLaserObstacleDistances >> min: distance sideEcho: anEcho [
	^distance min: (anEcho distance * anEcho angle abs sin)

]

{ #category : #'initialize-release' }
BcMinLaserObstacleDistances >> reset [
	frontLeft := Float infinity.
	frontRight := Float infinity.
	sideLeftFront := Float infinity.
	sideLeftRear := Float infinity.
	sideRightFront := Float infinity.
	sideRightRear := Float infinity
]

{ #category : #accessing }
BcMinLaserObstacleDistances >> right [
	^self frontRight min: self sideRight
]

{ #category : #accessing }
BcMinLaserObstacleDistances >> sideLeft [
	^self sideLeftFront min: self sideLeftRear 
]

{ #category : #accessing }
BcMinLaserObstacleDistances >> sideLeftFront [
	^ sideLeftFront
]

{ #category : #accessing }
BcMinLaserObstacleDistances >> sideLeftRear [
	^ sideLeftRear
]

{ #category : #accessing }
BcMinLaserObstacleDistances >> sideRight [
	^self sideRightFront min: self sideRightRear 
]

{ #category : #accessing }
BcMinLaserObstacleDistances >> sideRightFront [
	^ sideRightFront
]

{ #category : #accessing }
BcMinLaserObstacleDistances >> sideRightRear [
	^ sideRightRear
]

{ #category : #updating }
BcMinLaserObstacleDistances >> updateFromAllEchoes: echoes [
	self reset.
	echoes do: [ :each | self updateFromEcho: each ]
]

{ #category : #updating }
BcMinLaserObstacleDistances >> updateFromEcho: anEcho [
	(self isLeftEcho: anEcho) ifTrue: [ ^self updateFromLeftEcho: anEcho].
	self updateFromRightEcho: anEcho
]

{ #category : #updating }
BcMinLaserObstacleDistances >> updateFromLeftEcho: anEcho [
	(self isFrontEcho: anEcho) ifTrue: [^frontLeft := self min: frontLeft frontEcho: anEcho].
	(self isRearEcho: anEcho) ifTrue: [^sideLeftRear := self min: sideLeftRear sideEcho: anEcho].
	sideLeftFront := self min: sideLeftFront sideEcho: anEcho
]

{ #category : #updating }
BcMinLaserObstacleDistances >> updateFromRightEcho: anEcho [
	(self isFrontEcho: anEcho) ifTrue: [^frontRight := self min: frontRight frontEcho: anEcho].
	(self isRearEcho: anEcho) ifTrue: [^sideRightRear := self min: sideRightRear sideEcho: anEcho].
	sideRightFront := self min: sideRightFront sideEcho: anEcho.
]
