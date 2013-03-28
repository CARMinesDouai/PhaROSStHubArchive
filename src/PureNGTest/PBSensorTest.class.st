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
