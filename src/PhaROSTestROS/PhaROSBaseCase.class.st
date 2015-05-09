Class {
	#name : #PhaROSBaseCase,
	#superclass : #TestCase,
	#instVars : [
		'masterUrl',
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
PhaROSBaseCase >> masterUrl [
	^ masterUrl ifNil: [ 
			masterUrl := OSEnvironment default at: 'ROS_MASTER_URI' 
								ifAbsent: [ 'http://', self defaultMasterIp, ':', self defaultMasterPort asString ] ]
]

{ #category : #'setup / teardown' }
PhaROSBaseCase >> setUp [
	PhaROSManifest cleanUp.
	master := PhaROSMaster url: self masterUrl
	
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
