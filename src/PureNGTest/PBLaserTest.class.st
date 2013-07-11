Class {
	#name : #PBLaserTest,
	#superclass : #PBSensorTest,
	#category : #'PureNGTest-Sensor'
}

{ #category : #testing }
PBLaserTest >> assert: distancesCollection areLessThan: maxVal andGreaterThan: minVal [
	
	| wrongDistances |
	wrongDistances := Set new.
	
	distancesCollection doWithIndex:[ :e :i | (e > maxVal or: [e < minVal]) ifTrue:[wrongDistances add:  (i -> e) ]].
	
	self assert: wrongDistances isEmpty.
]

{ #category : #testing }
PBLaserTest >> testLaserWhenRobotAtBottomLeftOfTheBox [
	| laser notification allDistances |

	self requestAction: 'Please, put the robot at the bottom left of the 1x1 box'.
	
	laser := robot laserService.
	laser enableNotificationsEvery: 10.
	notification := self notificationOrNilFrom: laser.
	
	allDistances := notification distances.
	self assert: allDistances areLessThan: 1.1 andGreaterThan: 0.20
	
]

{ #category : #testing }
PBLaserTest >> testLaserWhenRobotAtBottomRightOfTheBox [
	| laser notification allDistances |
	
	self requestAction: 'Please, put the robot at the bottom right of the 1x1 box'.
	
	laser := robot laserService.
	laser enableNotificationsEvery: 10.
	notification := self notificationOrNilFrom: laser.
	
	allDistances := notification distances.
	self assert: allDistances areLessThan: 1.1 andGreaterThan: 0.20

]

{ #category : #testing }
PBLaserTest >> testLaserWhenRobotAtCenterOfTheBox [
	| laser notification allDistances |
	
	self requestAction: 'Please, put the robot at the center of the 1x1 box'.
	
	laser := robot laserService.
	laser enableNotificationsEvery: 10.
	notification := self notificationOrNilFrom: laser.
	
	allDistances := notification distances.
	self assert: allDistances areLessThan: 0.8 andGreaterThan: 0.3

]

{ #category : #testing }
PBLaserTest >> testLaserWhenRobotAtTopLeftOfTheBox [
	| laser notification allDistances |
		
	self requestAction: 'Please, put the robot at the top left of the 1x1 box'.
	
	laser := robot laserService.
	laser enableNotificationsEvery: 10.
	notification := self notificationOrNilFrom: laser.
	
	allDistances := notification distances.
	self assert: allDistances areLessThan: 1.2 andGreaterThan: 0.05

]

{ #category : #testing }
PBLaserTest >> testLaserWhenRobotAtTopRightOfTheBox [
	| laser notification allDistances |
	
	self requestAction: 'Please, put the robot at the top right of the 1x1 box'.
	
	laser := robot laserService.
	laser enableNotificationsEvery: 10.
	notification := self notificationOrNilFrom: laser.
	
	allDistances := notification distances.
	self assert: allDistances areLessThan: 1.2 andGreaterThan: 0.05

]

{ #category : #testing }
PBLaserTest >> testLaserWhenRobotInsideTheBoxFacingObstacleAt2m [
	| laser notification allDistances  |
	
	self requestAction: 'Please, put the robot in the 1x1 box facing the hole and an obstacle at 2m'.
	
	laser := robot laserService.
	laser enableNotificationsEvery: 10.
	notification := self notificationOrNilFrom: laser.
	
	allDistances := notification distances.
	self assert: allDistances areLessThan: 2 andGreaterThan: 0

]
