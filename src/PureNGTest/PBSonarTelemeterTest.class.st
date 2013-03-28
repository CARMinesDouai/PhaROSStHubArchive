Class {
	#name : #PBSonarTelemeterTest,
	#superclass : #PBSensorTest,
	#category : #'PureNGTest-Sensor'
}

{ #category : #testing }
PBSonarTelemeterTest >> testSonarWhenRobotAtBottomLeftOfTheBox [
	| laser notification minVal maxVal wrongDistances |
	minVal := 0.05.
	maxVal := 0.45.
	wrongDistances := OrderedCollection new.
	
	self requestAction: 'Please, put the robot at the bottom left of the 1x1 box' orDo:[].
	
	laser := robot sonarTelemeterService.
	laser enableNotificationsEvery: 10.
	notification := self notificationOrNilFrom: laser.
	notification distances doWithIndex:[ :e :i | (e > maxVal or: [e < minVal]) ifTrue:[wrongDistances add:  (i -> e) ]].
	
	self assert: (wrongDistances isEmpty).
]

{ #category : #testing }
PBSonarTelemeterTest >> testSonarWhenRobotAtBottomRightOfTheBox [
	| laser notification minVal maxVal wrongDistances |
	minVal := 0.05.
	maxVal := 0.45.
	wrongDistances := OrderedCollection new.
	
	self requestAction: 'Please, put the robot at the bottom right of the 1x1 box' orDo:[].
	
	laser := robot sonarTelemeterService.
	laser enableNotificationsEvery: 10.
	notification := self notificationOrNilFrom: laser.
	notification distances doWithIndex:[ :e :i | (e > maxVal or: [e < minVal]) ifTrue:[wrongDistances add:  (i -> e) ]].
	
	self assert: (wrongDistances isEmpty).
]

{ #category : #testing }
PBSonarTelemeterTest >> testSonarWhenRobotAtCenterOfTheBox [
	| laser notification minVal maxVal wrongDistances|
	minVal := 0.20.
	maxVal := 0.30.
	
	wrongDistances := OrderedCollection new.
	
	self requestAction: 'Please, put the robot at the center of the 1x1 box' orDo:[].
	
	laser := robot sonarTelemeterService.
	laser enableNotificationsEvery: 10.
	notification := self notificationOrNilFrom: laser.
	notification distances doWithIndex:[ :e :i | (e > maxVal or: [e < minVal]) ifTrue:[wrongDistances add:  (i -> e) ]].
	
	self assert: (wrongDistances isEmpty).
]

{ #category : #testing }
PBSonarTelemeterTest >> testSonarWhenRobotAtTopLeftOfTheBox [
	| laser notification minVal maxVal wrongDistances |
	minVal := 0.05.
	maxVal := 0.45.
	wrongDistances := OrderedCollection new.
	
	self requestAction: 'Please, put the robot at the top left of the 1x1 box' orDo:[].
	
	laser := robot sonarTelemeterService.
	laser enableNotificationsEvery: 10.
	notification := self notificationOrNilFrom: laser.
	notification distances doWithIndex:[ :e :i | (e > maxVal or: [e < minVal]) ifTrue:[wrongDistances add:  (i -> e) ]].
	
	self assert: (wrongDistances isEmpty).
]

{ #category : #'as yet unclassified' }
PBSonarTelemeterTest >> testSonarWhenRobotAtTopRightOfTheBox [
	| laser notification minVal maxVal wrongDistances |
	minVal := 0.05.
	maxVal := 0.45.
	wrongDistances := OrderedCollection new.
	
	self requestAction: 'Please, put the robot at the top right of the 1x1 box' orDo:[].
	
	laser := robot sonarTelemeterService.
	laser enableNotificationsEvery: 10.
	notification := self notificationOrNilFrom: laser.
	
	notification distances doWithIndex:[ :e :i | (e > maxVal or: [e < minVal]) ifTrue:[wrongDistances add:  (i -> e) ]].
	
	self assert: (wrongDistances isEmpty).
]
