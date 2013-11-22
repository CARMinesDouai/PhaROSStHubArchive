Class {
	#name : #PhaROSBaseCase,
	#superclass : #TestCase,
	#instVars : [
		'masterProcess',
		'turtleProcess',
		'masterUrl',
		'masterURL',
		'controller'
	],
	#category : #'PhaROSTestROS-Kernel'
}

{ #category : #accessing }
PhaROSBaseCase >> callerId [
	^ '/testId'.
]

{ #category : #'default parameters' }
PhaROSBaseCase >> defaultMasterIp [
	^ 'localhost'
]

{ #category : #'default parameters' }
PhaROSBaseCase >> defaultMasterPort [
	^ 11311
]

{ #category : #accessing }
PhaROSBaseCase >> masterURL [
	^ masterURL ifNil: [ masterURL := 'http://', self defaultMasterIp, ':', self defaultMasterPort asString ] 
]

{ #category : #accessing }
PhaROSBaseCase >> masterURL: aString [
	masterURL := aString
]

{ #category : #'setup / teardown' }
PhaROSBaseCase >> setUp [
	masterUrl := self masterURL.
	PhaROSManifest cleanUp.
	controller := PhaROSMasiveNodeController url: masterUrl
]

{ #category : #actions }
PhaROSBaseCase >> shutdownMaster [
	PhaROSSystemLauncher instance shutdownMaster
]

{ #category : #actions }
PhaROSBaseCase >> shutdownTurtle [
	PhaROSSystemLauncher instance shutdownTurtle.

]

{ #category : #accessing }
PhaROSBaseCase >> spin: times [
	times timesRepeat: [
		(times * 100) timesRepeat: [].
		(Delay forMilliseconds: 100) wait.
	]

	
]

{ #category : #actions }
PhaROSBaseCase >> startUpMaster [
	PhaROSSystemLauncher instance startUpMaster.
	

]

{ #category : #actions }
PhaROSBaseCase >> startUpTurtle [
	PhaROSSystemLauncher instance startUpTurtle.
]

{ #category : #'setup / teardown' }
PhaROSBaseCase >> tearDown [ 

	PhaROSManifest cleanUp.
	self shutdownMaster.
	self shutdownTurtle.
]
