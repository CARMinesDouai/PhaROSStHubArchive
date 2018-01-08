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
	#category : #'BotController-Controllers'
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
	^anEcho angle abs > 0 
]

{ #category : #testing }
BcMinLaserObstacleDistances >> isRearEcho: anEcho [
	^anEcho angle abs > 1.57 "Half Pi"
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
	(self isFrontEcho: anEcho) ifTrue: [^frontLeft := frontLeft min: anEcho distance].
	(self isRearEcho: anEcho) ifTrue: [^sideLeftRear := sideLeftRear min: anEcho distance].
	sideLeftFront := sideLeftFront min: anEcho distance
]

{ #category : #updating }
BcMinLaserObstacleDistances >> updateFromRightEcho: anEcho [
	(self isFrontEcho: anEcho) ifTrue: [^frontRight := frontRight min: anEcho distance].
	(self isRearEcho: anEcho) ifTrue: [^sideRightRear := sideRightRear min: anEcho distance].
	sideRightFront := sideRightFront min: anEcho distance
]
