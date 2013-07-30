Class {
	#name : #PureROSBasicExperiment,
	#superclass : #Object,
	#instVars : [
		'launch',
		'controller'
	],
	#category : #'PureROS-Experiments'
}

{ #category : #'as yet unclassified' }
PureROSBasicExperiment class >> kompai1 [
	^ self new controller: #kompai1; yourself .
]

{ #category : #'as yet unclassified' }
PureROSBasicExperiment class >> kompai2 [
	^ self new controller:  #kompai2; yourself .
]

{ #category : #experiment }
PureROSBasicExperiment >> beginExperiment [
	self setup.

]

{ #category : #accessing }
PureROSBasicExperiment >> controller [
	(controller isKindOf: PhaROSHandleController) ifFalse: [ controller := controller asPhaROSController ].
	^ controller.  
]

{ #category : #accessing }
PureROSBasicExperiment >> controller: aControllerOrConstructor [
	controller := aControllerOrConstructor 
]

{ #category : #experiment }
PureROSBasicExperiment >> endExperiment [
	self teardown. 
	controller finalize.
	controller := nil. 
	launch := nil. 
	
	
	Smalltalk garbageCollect.

]

{ #category : #'initialize-release' }
PureROSBasicExperiment >> finalize [
	self endExperiment.
	super finalize.
]

{ #category : #'initialize-release' }
PureROSBasicExperiment >> initialize [ 
	super initialize.
	self finalizationRegistry add: self.
	
]

{ #category : #'configure-system' }
PureROSBasicExperiment >> launch: aConfigurationFileOrBlock [
	| configuration path |
	
	path := (aConfigurationFileOrBlock isKindOf: String) ifTrue: [
		aConfigurationFileOrBlock.
	] ifFalse: [
		configuration := PhaROSLaunchBuilder new .
		aConfigurationFileOrBlock value: configuration.
		configuration writeFile.
	].

	launch := (PhaROSSystemLauncher instance roslaunch: path) asStickyReference.
	self halt.
	
]

{ #category : #accessing }
PureROSBasicExperiment >> robulab [
	^ self controller nodelets robulab.
]

{ #category : #'configure-system' }
PureROSBasicExperiment >> run: anArrayOfArguments [ 
	^ (PhaROSSystemLauncher instance rosrun: anArrayOfArguments).
]

{ #category : #'configure-publishing' }
PureROSBasicExperiment >> setCovariance: aMessage [
	| dValue |
	(36 - (aMessage covariance size) ) timesRepeat: [ 
		aMessage covariance add: 0.0. 
	].
	self flag: #lookAtComment.
" This value is really arbitrar.. is based on turtlebot specs, it should be based on robulab, or even better, parametrized "
	dValue := (0.017 * 0.017) roundUpTo: 0.0000001. 
	
	aMessage  covariance at:1 put: dValue.
	aMessage covariance at:8 put: dValue.
	aMessage  covariance at:15 put: dValue.
	aMessage covariance at:22 put: dValue.
	aMessage covariance at:29 put: dValue.	
	aMessage covariance at:36 put: dValue.
		
]

{ #category : #'initialize-release' }
PureROSBasicExperiment >> setup [
	self subclassResponsibility.
	
	
	
]

{ #category : #'initialize-release' }
PureROSBasicExperiment >> teardown [

	
	
	
]
