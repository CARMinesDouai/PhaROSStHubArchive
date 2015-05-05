Class {
	#name : #PhaROSBaseCase,
	#superclass : #TestCase,
	#instVars : [
		'masterUrl',
		'masterURL',
		'master',
		'process'
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
	^ masterURL ifNil: [ 
			masterURL := OSEnvironment default at: 'ROS_MASTER_URI' 
								ifAbsent: [ 'http://', self defaultMasterIp, ':', self defaultMasterPort asString ] ]
]

{ #category : #accessing }
PhaROSBaseCase >> masterURL: aString [
	masterURL := aString
]

{ #category : #'setup / teardown' }
PhaROSBaseCase >> setUp [
	masterUrl := self masterURL.
	PhaROSManifest cleanUp.
	master := PhaROSMaster url: masterUrl
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
	process := PhaROSSystemLauncher instance roslaunchForTests: '<launch></launch>'.
	

]

{ #category : #actions }
PhaROSBaseCase >> startUpTurtle [
	process := PhaROSSystemLauncher instance roslaunchForTests: 
	'
	<launch>
		<node name="turtlesim" pkg="turtlesim" type="turtlesim_node" />
	</launch>'.
]

{ #category : #'setup / teardown' }
PhaROSBaseCase >> tearDown [ 

	PhaROSManifest cleanUp.
	process finalize.
	process := nil.
]
