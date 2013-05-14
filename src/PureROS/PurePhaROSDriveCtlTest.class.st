"
the DriveController dispatch messages to three different controller/services in order to achive what is asked. Here we test that the proper messages are sent to the proper service. 
"
Class {
	#name : #PurePhaROSDriveCtlTest,
	#superclass : #TestCase,
	#instVars : [
		'robotTracker',
		'trajectoryTracker',
		'stepTracker',
		'controller'
	],
	#category : #'PureROS-Controllers-Tests'
}

{ #category : #testing }
PurePhaROSDriveCtlTest >> robotReceived: aSelector [
	^ (robotTracker messages collect: #selector) includes: aSelector.


]

{ #category : #testing }
PurePhaROSDriveCtlTest >> robotTrackerIsEmpty [
	^ robotTracker isEmpty 
]

{ #category : #testing }
PurePhaROSDriveCtlTest >> setUp [
	super setUp.
	robotTracker := PureROSMessageRegisterForTests new.
	trajectoryTracker := PureROSMessageRegisterForTests new.
	stepTracker := PureROSMessageRegisterForTests new.
	controller := PurePhaROSDriveCtl for: robotTracker.
	controller trajectoryController: trajectoryTracker.
	controller stepController: stepTracker.
	
	
	
]

{ #category : #testing }
PurePhaROSDriveCtlTest >> stepServiceIsEmpty [
	^stepTracker isEmpty 
]

{ #category : #testing }
PurePhaROSDriveCtlTest >> stepServiceReceived: aSelector [
	^ (stepTracker messages collect: #selector) includes: aSelector.


]

{ #category : #test }
PurePhaROSDriveCtlTest >> testAdvance [ 
	
	controller advance: Object.
	self assert: (self trajectoryServiceReceived: #goToDelta:).
	self assert: self robotTrackerIsEmpty.
	self assert: self stepServiceIsEmpty.

]

{ #category : #test }
PurePhaROSDriveCtlTest >> testAdvanceTrough [
	
	controller advanceTrough: Object.
	self assert: (self trajectoryServiceReceived: #goToAllDelta:).
	self assert: self robotTrackerIsEmpty.
	self assert: self stepServiceIsEmpty.

]

{ #category : #test }
PurePhaROSDriveCtlTest >> testDrawSquare [
	
	controller drawSquare.
	self assert: (self trajectoryServiceReceived: #square).
	self assert: self robotTrackerIsEmpty.
	self assert: self stepServiceIsEmpty.

]

{ #category : #test }
PurePhaROSDriveCtlTest >> testMoveAt [
	
	controller moveAt: Object.
	self assert: self trajectoryServiceIsEmpty .
	self assert: (self robotReceived: #differentialService).
	self assert: (self robotReceived: #moveAt:).
	self assert: self stepServiceIsEmpty.

]

{ #category : #test }
PurePhaROSDriveCtlTest >> testMoveTo [
	
	controller moveTo: Object.
	self assert: (self trajectoryServiceReceived: #goTo:).
	self assert: self robotTrackerIsEmpty.
	self assert: self stepServiceIsEmpty.

]

{ #category : #test }
PurePhaROSDriveCtlTest >> testMoveTrough [
	
	controller moveTo: Object.
	self assert: (self trajectoryServiceReceived: #goTo:).
	self assert: self robotTrackerIsEmpty.
	self assert: self stepServiceIsEmpty.

]

{ #category : #test }
PurePhaROSDriveCtlTest >> testRotate [

	controller rotate: Object.
	self assert: self trajectoryServiceIsEmpty .
	self assert: self robotTrackerIsEmpty.
	self assert: (self stepServiceReceived: #thenRotate:).

]

{ #category : #test }
PurePhaROSDriveCtlTest >> testStep [
	
	controller step: Object.
	self assert: (self trajectoryServiceReceived: #goToDelta:).
	self assert: self robotTrackerIsEmpty.
	self assert: self stepServiceIsEmpty.

]

{ #category : #testing }
PurePhaROSDriveCtlTest >> trajectoryServiceIsEmpty [
	^trajectoryTracker isEmpty 
]

{ #category : #testing }
PurePhaROSDriveCtlTest >> trajectoryServiceReceived: aSelector [
	^ (trajectoryTracker messages collect: #selector) includes: aSelector.


]
