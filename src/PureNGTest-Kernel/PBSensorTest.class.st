Class {
	#name : #PBSensorTest,
	#superclass : #PBServiceTest,
	#instVars : [
		'controller'
	],
	#category : #'PureNGTest-Sensor'
}

{ #category : #testing }
PBSensorTest >> setUp [
	super setUp.
	robot notificationService deleteAllNotifyingServices.
]

{ #category : #testing }
PBSensorTest >> tearDown [
	robot notificationService deleteAllNotifyingServices.
	super tearDown.

]

{ #category : #testing }
PBSensorTest >> testLaserWhenRobotAtBottomLeftOfTheBox [
	| laser notification allDistances minVal maxVal wrongDistances |
	minVal := 0.25.
	maxVal := 0.75.
	wrongDistances := OrderedCollection new.
	
	self requestAction: 'Please, put the robot at the bottom left of the 1x1 box' orDo:[].
	
	laser := robot laserService.
	laser enableNotificationsEvery: 10.
	notification := self notificationOrNilFrom: laser.
	notification distances doWithIndex:[ :e :i | (e > maxVal or: [e < minVal]) ifTrue:[wrongDistances add:  (i -> e) ]].
	
	self assert: (wrongDistances isEmpty).
]

{ #category : #testing }
PBSensorTest >> testLaserWhenRobotAtBottomRightOfTheBox [
	| laser notification allDistances minVal maxVal wrongDistances |
	minVal := 0.25.
	maxVal := 0.75.
	wrongDistances := OrderedCollection new.
	
	self requestAction: 'Please, put the robot at the bottom right of the 1x1 box' orDo:[].
	
	laser := robot laserService.
	laser enableNotificationsEvery: 10.
	notification := self notificationOrNilFrom: laser.
	notification distances doWithIndex:[ :e :i | (e > maxVal or: [e < minVal]) ifTrue:[wrongDistances add:  (i -> e) ]].
	
	self assert: (wrongDistances isEmpty).
]

{ #category : #testing }
PBSensorTest >> testLaserWhenRobotAtCenterOfTheBox [
	| laser notification minVal maxVal wrongDistances|
	minVal := 0.25.
	maxVal := 0.56.
	
	wrongDistances := OrderedCollection new.
	
	self requestAction: 'Please, put the robot at the center of the 1x1 box' orDo:[].
	
	laser := robot laserService.
	laser enableNotificationsEvery: 10.
	notification := self notificationOrNilFrom: laser.
	notification distances doWithIndex:[ :e :i | (e > maxVal or: [e < minVal]) ifTrue:[wrongDistances add:  (i -> e) ]].
	
	self assert: (wrongDistances isEmpty).
]

{ #category : #testing }
PBSensorTest >> testLaserWhenRobotAtTopLeftOfTheBox [
	| laser notification allDistances minVal maxVal wrongDistances |
	minVal := 0.15.
	maxVal := 0.75.
	wrongDistances := OrderedCollection new.
	
	self requestAction: 'Please, put the robot at the top left of the 1x1 box' orDo:[].
	
	laser := robot laserService.
	laser enableNotificationsEvery: 10.
	notification := self notificationOrNilFrom: laser.
	notification distances doWithIndex:[ :e :i | (e > maxVal or: [e < minVal]) ifTrue:[wrongDistances add:  (i -> e) ]].
	
	self assert: (wrongDistances isEmpty).
]

{ #category : #testing }
PBSensorTest >> testLaserWhenRobotAtTopRightOfTheBox [
	| laser notification allDistances minVal maxVal wrongDistances |
	minVal := 0.15.
	maxVal := 0.75.
	wrongDistances := OrderedCollection new.
	
	self requestAction: 'Please, put the robot at the top right of the 1x1 box' orDo:[].
	
	laser := robot laserService.
	laser enableNotificationsEvery: 10.
	notification := self notificationOrNilFrom: laser.
	notification distances doWithIndex:[ :e :i | (e > maxVal or: [e < minVal]) ifTrue:[wrongDistances add:  (i -> e) ]].
	
	self assert: (wrongDistances isEmpty).
]

{ #category : #testing }
PBSensorTest >> testLaserWhenRobotInsideTheBoxFacingObstacleAt2m [
	| laser notification allDistances  maxVal wrongDistances |
	maxVal := 2.
	wrongDistances := OrderedCollection new.
	self requestAction: 'Please, put the robot in the 1x1 box facing the hole and an obstacle at 2m' orDo: [  ].
	laser := robot laserService.
	laser enableNotificationsEvery: 10.
	notification := self notificationOrNilFrom: laser.
	notification distances
		doWithIndex: [ :e :i | 
			e > maxVal 
				ifTrue: [ wrongDistances add: i -> e ] ].
	self assert: wrongDistances isEmpty
]
