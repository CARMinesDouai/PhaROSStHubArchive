Class {
	#name : #PBLaserTest,
	#superclass : #PBSensorTest,
	#category : #'PureNGTest-Sensor'
}

{ #category : #testing }
PBLaserTest >> testLaserWhenRobotAtBottomLeftOfTheBox [
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
PBLaserTest >> testLaserWhenRobotAtBottomRightOfTheBox [
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
PBLaserTest >> testLaserWhenRobotAtCenterOfTheBox [
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
PBLaserTest >> testLaserWhenRobotAtTopLeftOfTheBox [
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
PBLaserTest >> testLaserWhenRobotAtTopRightOfTheBox [
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
PBLaserTest >> testLaserWhenRobotInsideTheBoxFacingObstacleAt2m [
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
